//
//  DADownloadService.h
//  ScanAndTell
//
//  Created by Suman Chatterjee on 15/03/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DAResultResponse;

@interface DADownloadService : NSObject

+ (DADownloadService *) shared;

-(void) requestForADownload:(DAResultResponse*)response;


@end
