//
//  NSDictionary+JSON.h
//  Juper
//
//  Created by Jack Dewhurst on 15/04/2013.
//  Copyright (c) 2013 Juper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSON)

+ (NSDictionary*)dictionaryWithContentsOfJSONString:(NSString*)fileLocation;


@end
