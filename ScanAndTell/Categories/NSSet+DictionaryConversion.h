//
//  NSSet+DictionaryConversion.h
//  Juper
//
//  Created by Gilbert Jolly on 21/06/2013.
//  Copyright (c) 2013 Juper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (DictionaryConversion)

- (NSDictionary*)asDictionaryUsingItemKey:(NSString*)string;


@end
