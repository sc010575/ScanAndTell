//
//  OSNetworkManager.h
//  ThreadedCoreData
//
//  Created by Suman Chatterjee on 10/11/2013.
//
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock) (NSMutableData* result);
typedef void (^ErrorBlock) (NSError* error);

@interface OSNetworkManager : NSObject

+ (OSNetworkManager*) shared;


//Function to create the Table if it is not exists
- (void) ConnectWithURL:(NSString *)url
         withSuccessBlock:(SuccessBlock) success
         errorBlock:(ErrorBlock) error;

@end
