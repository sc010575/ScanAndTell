//
//  UIImage+Rotate.h
//  Juper
//
//  Created by jonathan on 21/09/2013.
//  Copyright (c) 2013 Juper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Rotate)


//use this rotation - efficient (changes the metatag).
- (UIImage*) rotateExifToOrientation:(UIImageOrientation)orientation;


//don't use this if you can help it - it's really slow (transposes the bitmap)
- (UIImage*) rotateBitmapToOrientation:(UIImageOrientation)orientation;

@end
