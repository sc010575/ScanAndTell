//
//  UIImage+isPortrait.m
//  Juper
//
//  Created by jonathan on 22/08/2013.
//  Copyright (c) 2013 Juper. All rights reserved.
//

#import "UIImage+isPortrait.h"

@implementation UIImage (isPortrait)

- (BOOL) isPortrait
{
    BOOL result = NO;
    if (self.size.width) {
        result = [[NSNumber numberWithInt:floor(self.size.height/self.size.width)] boolValue];
    }
    return  result;
}

@end
