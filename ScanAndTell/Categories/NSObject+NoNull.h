//
//  NSObject+NoNull.h
//  Juper
//
//  Created by Jack Dewhurst on 25/04/2013.
//  Copyright (c) 2013 Juper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NoNull)

- (id)notNullWithReplacement:(id)replacement;
- (id)nilNotNull;

@end
