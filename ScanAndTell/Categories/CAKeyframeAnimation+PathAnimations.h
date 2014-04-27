//
//  CAKeyframeAnimation+PathAnimations.h
//  Juper
//
//  Created by Gilbert Jolly on 18/07/2013.
//  Copyright (c) 2013 Juper. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAKeyframeAnimation (PathAnimations)

+ (CAKeyframeAnimation*)curvedAnimationFrom:(CGPoint)point1 to:(CGPoint)point2 withControl:(CGPoint)controlPoint;
+ (CAKeyframeAnimation*)animationWithPath:(UIBezierPath *)path;

@end
