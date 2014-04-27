//
//  DAZooplaService.h
//  ScanAndTell
//
//  Created by Suman Chatterjee on 22/03/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    zoopla_localinfo,
    zoopla_areagraph
}ZooplaServices;

@interface DAZooplaService : NSObject

+ (void) requestZooplaServiceForPostCode:(NSString*)postcode;
+ (NSString*) URLForDict:(NSDictionary*)dictToAnalyze withService:(ZooplaServices )serviceIndex withIndexPath:(NSIndexPath*)indexpath;


@end
