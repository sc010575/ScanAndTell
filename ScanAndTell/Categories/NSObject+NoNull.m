//
//  NSObject+NoNull.m
//  Juper
//
//  Created by Jack Dewhurst on 25/04/2013.
//  Copyright (c) 2013 Juper. All rights reserved.
//

#import "NSObject+NoNull.h"

@implementation NSObject (NoNull)


- (id)nilNotNull
{
    return [self notNullWithReplacement:nil];
}


- (id)notNullWithReplacement:(id)replacement
{
    if ([self isKindOfClass:[NSNull class]]
        || self == nil
        || !self
        || self == NULL)
    {
        if (replacement == nil) {
            return nil;
        }
        return replacement;
    }
    return self;
}


@end
