//
//  UIBezierPath+Smoothing.h
//  OSMapFinder
//
//  Created by Gilbert Jolly on 06/03/2014.
//  Copyright (c) 2014 Gilbert Jolly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (Smoothing)
- (UIBezierPath *) smoothedPath: (int) granularity;
@end
