//
//  DAResultResponse.m
//  ScanAndTell
//
//  Created by Suman Chatterjee on 17/03/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DAResultResponse.h"

@implementation DAResultResponse

-(void) initWithRequestID:(NSString*)request andURL:(NSString*)URL
{
    self.requestID = request;
    self.URL = URL;
    self.returnDict = [NSDictionary dictionary];
}


@end
