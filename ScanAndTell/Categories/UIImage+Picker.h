//
//  UIImage+Picker.h
//  Juper
//
//  Created by jonathan on 05/07/2013.
//  Copyright (c) 2013 Juper. All rights reserved.
//  http://stackoverflow.com/a/12059435/1375695

#import <UIKit/UIKit.h>

@interface UIImage (Picker)

- (UIColor *)colorAtPosition:(CGPoint)position;

- (NSString*)hexAtPosition:(CGPoint)position;

@end
