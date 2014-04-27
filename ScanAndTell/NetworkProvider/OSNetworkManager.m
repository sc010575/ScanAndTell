//
//  OSNetworkManager.m
//  ThreadedCoreData
//
//  Created by Suman Chatterjee on 10/11/2013.
//
//

#import "OSNetworkManager.h"
@interface OSNetworkManager()
{
    NSError * _error;
}
@property (nonatomic) NSURLConnection *earthquakeFeedConnection;
@property (nonatomic) NSMutableData *earthquakeData;
@property (nonatomic , assign)   NSString *URL;
@property (copy) SuccessBlock  successblock;
@property (copy) ErrorBlock     errorblock;

@end


@implementation OSNetworkManager

//static method to implement the class singleton object
+ (OSNetworkManager*) shared
{
	static OSNetworkManager* shared = nil;
	
    // singleton allocate
    if (shared == nil){
        shared = [[OSNetworkManager alloc] init];
    }
    
	return shared;
}

- (void) ConnectWithURL:(NSString *)url
       withSuccessBlock:(SuccessBlock) success
             errorBlock:(ErrorBlock) error
{
    
    /*
     Use NSURLConnection to asynchronously download the data. This means the main thread will not be blocked - the application will remain responsive to the user.
     */
    
    self.URL = url;
    self.successblock = success;
    self.errorblock = error;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLRequest *earthquakeURLRequest =
    [NSURLRequest requestWithURL:[NSURL URLWithString:self.URL]];
    self.earthquakeFeedConnection = [[NSURLConnection alloc] initWithRequest:earthquakeURLRequest delegate:self];
    
    /*
     Test the validity of the connection object. The most likely reason for the connection object to be nil is a malformed URL, which is a programmatic error easily detected during development. If the URL is more dynamic, then you should implement a more flexible validation technique, and be able to both recover from errors and communicate problems to the user in an unobtrusive manner.
     */
    NSAssert(self.earthquakeFeedConnection != nil, @"Failure to create URL connection.");
    
}

#pragma mark - NSURLConnectionDelegate

/*
 The following are delegate methods for NSURLConnection. Similar to callback functions, this is how the connection object, which is working in the background, can asynchronously communicate back to its delegate on the thread from which it was started - in this case, the main thread.
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    /*
     Check for HTTP status code for proxy authentication failures anything in the 200 to 299 range is considered successful, also make sure the MIMEType is correct.
     */
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ((([httpResponse statusCode]/100) == 2) && [[response MIMEType] isEqual:@"application/atom+xml"]) {
        self.earthquakeData = [NSMutableData data];
    }
    else {
        NSString * errorString = NSLocalizedString(@"HTTP Error", @"Error message displayed when receving a connection error.");
        
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorString};
        _error = [NSError errorWithDomain:errorString code:[httpResponse statusCode]  userInfo:userInfo];
        if(_errorblock)
            self.errorblock(_error);
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [self.earthquakeData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if ([error code] == kCFURLErrorNotConnectedToInternet) {
        // If we can identify the error, we present a suitable message to the user.
        NSString * errorString = NSLocalizedString(@"No Connection Error", @"Error message displayed when not connected to the Internet.");
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorString};
        _error = [NSError errorWithDomain:NSCocoaErrorDomain code:kCFURLErrorNotConnectedToInternet userInfo:userInfo];
        if(self.errorblock)
            self.errorblock(_error);
    }
    else {
        // Otherwise handle the error generically.
       // Handle error
    }
    
    self.earthquakeFeedConnection = nil;
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    self.earthquakeFeedConnection = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    /*
     Spawn an NSOperation to parse the earthquake data so that the UI is not blocked while the application parses the XML data.
     IMPORTANT! - Don't access or affect UIKit objects on secondary threads.
     */
    
    if(self.successblock)
        self.successblock(self.earthquakeData);
    
    self.earthquakeData = nil;
}

- (void)dealloc {
[_earthquakeFeedConnection cancel];
}



@end
