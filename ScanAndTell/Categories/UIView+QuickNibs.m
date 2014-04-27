//
//  UIView+QuickNibs.m
//  Boppl
//
//  Created by Gilbert Jolly on 11/04/2013.
//  Copyright (c) 2013 Boppl. All rights reserved.
//

#import "UIView+QuickNibs.h"

@implementation UIView (QuickNibs)

+ (id)loadFromNib
{
    return [self nibForClass:self];
}

+ (UIView*)nibCalled:(NSString*)nibName
{
    return [self nibCalled:nibName owner:nil];
}

+ (UIView*)nibCalled:(NSString*)nibName owner:(id)owner
{
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil] objectAtIndex:0];
}

+ (UIView*)nibForClass:(Class)class
{
    return [self nibCalled:NSStringFromClass(class) owner:nil];
}

+ (UIView*)nibForClass:(Class)class owner:(id)owner
{
    return [self nibCalled:NSStringFromClass(class) owner:owner];
}

@end
