//
//  NSArray+DictionaryConversion.m
//  Juper
//
//  Created by Gilbert Jolly on 29/05/2013.
//  Copyright (c) 2013 Juper. All rights reserved.
//

#import "NSArray+DictionaryConversion.h"

@implementation NSArray (DictionaryConversion)


- (NSDictionary*)asDictionaryUsingItemKey:(NSString*)string
{
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionaryWithCapacity:self.count];
    
    for (NSDictionary *dict in self) {
        id key = [dict valueForKey:string];
        mutDict[key] =  dict;
    }
    
    return [NSDictionary dictionaryWithDictionary:mutDict];
}


@end
