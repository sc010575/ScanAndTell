//
//  NSArray+DictionaryConversion.h
//  Juper
//
//  Created by Gilbert Jolly on 29/05/2013.
//  Copyright (c) 2013 Juper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (DictionaryConversion)

- (NSDictionary*)asDictionaryUsingItemKey:(NSString*)string;

@end
