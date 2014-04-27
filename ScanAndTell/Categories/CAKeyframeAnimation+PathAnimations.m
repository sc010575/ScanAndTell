//
//  CAKeyframeAnimation+PathAnimations.m
//  Juper
//
//  Created by Gilbert Jolly on 18/07/2013.
//  Copyright (c) 2013 Juper. All rights reserved.
//

#import "CAKeyframeAnimation+PathAnimations.h"

@implementation CAKeyframeAnimation (PathAnimations)



+ (CAKeyframeAnimation*)curvedAnimationFrom:(CGPoint)point1 to:(CGPoint)point2 withControl:(CGPoint)controlPoint
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addQuadCurveToPoint:point2 controlPoint:controlPoint];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim.duration = 0.5;
    anim.path = path.CGPath;
    
    return anim;
}


+ (CAKeyframeAnimation*)animationWithPath:(UIBezierPath *)path
{
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    bounceAnimation.path = path.CGPath;
	bounceAnimation.duration = 0.5f;
    bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    return bounceAnimation;
}


@end
