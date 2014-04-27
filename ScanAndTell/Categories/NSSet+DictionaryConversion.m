//
//  NSSet+DictionaryConversion.m
//  Juper
//
//  Created by Gilbert Jolly on 21/06/2013.
//  Copyright (c) 2013 Juper. All rights reserved.
//

#import "NSSet+DictionaryConversion.h"

@implementation NSSet (DictionaryConversion)


- (NSDictionary*)asDictionaryUsingItemKey:(NSString*)string
{
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionaryWithCapacity:self.count];
    
    for (NSDictionary *dict in self) {
        id key = [dict valueForKey:string];
        if (key) {
            mutDict[key] =  dict;
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:mutDict];
}



@end
