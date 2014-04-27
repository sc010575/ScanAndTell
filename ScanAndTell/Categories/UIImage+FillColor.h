//
//  UIImage+FillColor.h
//  Magnet-O-Meter
//
//  Created by foundry on 15/03/2013.
//  Copyright (c) 2013 foundry. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIImage (FillColor)
+ (UIImage*) fillImgOfSize:(CGSize)img_size
                 withColor:(UIColor*)img_color;

+ (UIImage*) fillImgOfSize:(CGSize)img_size
                 withColor:(UIColor*)img_color
              cornerRadius:(CGFloat)cornerRadius;
@end
