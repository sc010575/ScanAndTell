//
//  UIView+QuickNibs.h
//  Boppl
//
//  Created by Gilbert Jolly on 11/04/2013.
//  Copyright (c) 2013 Boppl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (QuickNibs)

+ (id)loadFromNib;
+ (id)nibCalled:(NSString*)nibName;
+ (id)nibCalled:(NSString*)nibName owner:(id)owner;
+ (id)nibForClass:(Class)class;
+ (id)nibForClass:(Class)class owner:(id)owner;

@end
