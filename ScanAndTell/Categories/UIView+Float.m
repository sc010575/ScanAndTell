//
//  UIView+Float.m
//  Juper
//
//  Created by Gilbert Jolly on 05/09/2013.
//  Copyright (c) 2013 Juper. All rights reserved.
//

#import "UIView+Float.h"

@implementation UIView (Float)



- (CGPoint)randomPositionInSuperView
{
    return [self randomPositionInRect:self.superview.frame];
}




- (CGPoint)randomPositionInRect:(CGRect)rect
{
    int x = arc4random() % (int)rect.size.width;
    int y = arc4random() % (int)rect.size.height;
    return CGPointMake(rect.origin.x + x,rect.origin.y + y);
}




- (CGPoint)randomPositionNotTouchingOtherViews
{    
    CGPoint newPoint = CGPointMake(-100, -100);
    int numberOfAttempts = 0;
    UIView *touchingView = self;
    
    
    while (touchingView && numberOfAttempts < 20) {
        newPoint = [self randomPositionInRect:self.superview.bounds];
        CGRect newFrame = CGRectMake(newPoint.x - self.width/2, newPoint.y - self.height/2, self.width, self.height);
        
        for (UIView *siblingView in self.superview.subviews) {
            if (CGRectContainsPoint(siblingView.frame, newPoint) || CGRectIntersectsRect(siblingView.frame, newFrame)) {
                touchingView = siblingView;
            }else{
                touchingView = nil;
            }
        }

        numberOfAttempts++;
    }

    
    return newPoint;
}




- (void)floatAround
{
    self.userInteractionEnabled = YES;
    CGPoint nextPoint = [self randomPositionNotTouchingOtherViews];
    
    float duration = 8 + arc4random() % 8;
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        self.userInteractionEnabled = YES;
        self.center = nextPoint;
        
    }completion:^(BOOL finished) {
        
        self.userInteractionEnabled = YES;
        if (finished) {
            [self floatAround];
        }
        
    }];
}





@end
