//
//  UIImage+Rotate.m
//  Juper
//
//  Created by jonathan on 21/09/2013.
//  Copyright (c) 2013 Juper. All rights reserved.
//
//see also http://blog.logichigh.com/2008/06/05/uiimage-fix/
//see also http://blog.9mmedia.com/?p=932
//see also http://stackoverflow.com/questions/14484816/force-uiimagepickercontroller-to-take-photo-in-portrait-orientation-dimensions-i/14491293#14491293
//see also http://stackoverflow.com/questions/13971491/captured-photo-automatically-rotated-during-upload-in-ios-6-0-or-iphone/13974815#13974815

/*
 
 typedef enum { 
   0 UIImageOrientationUp,           // landscapeLeft
   1 UIImageOrientationDown,         // landscapeRight
   2 UIImageOrientationLeft,         // portraitUpsideDown
   3 UIImageOrientationRight,        // portrait
   4 UIImageOrientationUpMirrored,   // as above but image mirrored along
     // other axis. horizontal flip
   5 UIImageOrientationDownMirrored,  // horizontal flip
   6 UIImageOrientationLeftMirrored,  // vertical flip
   7 UIImageOrientationRightMirrored, // vertical flip
 } UIImageOrientation;
 
 Orientation

 Apple/UIImage.imageOrientation     Jpeg/File kCGImagePropertyOrientation
                                     (exif/TIFF 'orientation metatag)

 UIImageOrientationUp    = 0  =  Landscape left  = 1   
 UIImageOrientationDown  = 1  =  Landscape right = 3   
 UIImageOrientationLeft  = 2  =  Portrait  down  = 8   
 UIImageOrientationRight = 3  =  Portrait  up    = 6   

 */

#import "UIImage+Rotate.h"

@implementation UIImage (Rotate)

- (UIImage*)rotateExifToOrientation:(UIImageOrientation)orientation {
    return [[UIImage alloc] initWithCGImage:self.CGImage
                                      scale:self.scale
                                orientation:orientation];
}


-(UIImage*) rotateBitmapToOrientation:(UIImageOrientation)orientation
{
    UIImage* image = [self rotateExifToOrientation:orientation];
    CGImageRef imgRef = image.CGImage;
    CGSize imageSize = CGSizeMake(  CGImageGetWidth(imgRef)
                                  , CGImageGetHeight(imgRef));

    UIGraphicsBeginImageContext(imageSize);
    [image drawAtPoint:CGPointMake(0, 0)];
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}



@end
