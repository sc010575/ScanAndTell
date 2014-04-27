//
//  DADownloadService.m
//  ScanAndTell
//
//  Created by Suman Chatterjee on 15/03/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DADownloadService.h"
#import "AFHTTPRequestOperation.h"
#import "DAResultResponse.h"

@interface DADownloadService ()
@property (strong, nonatomic) DAResultResponse *results;
@property (assign, nonatomic) BOOL isBusy;
-(void) start;
-(void) update;
@end

@implementation DADownloadService
{
    NSMutableArray *downloadQueue;
}
// Self
static DADownloadService *sharedServiceProviderInstance = nil;


+ (DADownloadService *) shared
{
    @synchronized(self)
    {
        if (sharedServiceProviderInstance == NULL)
        {
            sharedServiceProviderInstance = [[self alloc] init];
        }
    }
    return(sharedServiceProviderInstance);
}


-(id) init
{
    self = [super init];
    if (self)
    {
        _results = [DAResultResponse alloc];
        downloadQueue = [NSMutableArray array];
        self.isBusy = NO;
    }
    return self;
}


-(void)start
{
    if ((downloadQueue.count > 0 ) && (!_isBusy)){
        DAResultResponse * request = [downloadQueue objectAtIndex:0];
        [self getResponseForURL:request];
    }
}

-(void)update
{
    [downloadQueue removeObjectAtIndex:0];
    _isBusy = NO;
    [self start];
}

-(void) getResponseForURL:(DAResultResponse*) response
{
    _isBusy = YES;
    __block DAResultResponse * tempResult = response;
    NSURL *url = [NSURL URLWithString:tempResult.URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            tempResult.returnDict = (NSDictionary*) responseObject;
        self.results = tempResult;
            [self update];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Location Details"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];
}


-(void) requestForADownload:(NSString*)URL
{
    [downloadQueue addObject:URL];
    [self start];
}


@end
