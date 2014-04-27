//
//  NSData+Image.m
//  Juper
//
//  Created by jonathan on 01/10/2013.
//  Copyright (c) 2013 Juper. All rights reserved.
//

#import "NSData+ImageIO.h"
#import <ImageIO/ImageIO.h>

@implementation NSData (ImageIO)

- (UIImage*)thumbnailWithSize:(CGSize)size;
{
    //NSLog(@"%s",__FUNCTION__);


    //using CGImageSource so we don't have to open the fullsize image to shrink it
    CGFloat scale =   [UIScreen mainScreen].scale;
    size = (CGSize){scale*size.width,scale*size.height};



    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)(self), NULL);
    if (imageSourceRef == NULL){
        // NSLog(@"imageSourceRef==NULL");
        return  nil;
    }

    CGSize originalSize = [self sizeFromImageSource:imageSourceRef];
    CGSize finalSize = [self scaleImageFromSize:originalSize toFill:size];

    int maxPixelSize = [self maxPixelSize:finalSize]; // get the longest edge of the final size

    //CFDictionaryRef imageMetaData = CGImageSourceCopyPropertiesAtIndex(imageSourceRef,0,NULL);


    NSDictionary* dict =
    @{(id)kCGImageSourceShouldAllowFloat: (id)kCFBooleanTrue,
      (id)kCGImageSourceCreateThumbnailWithTransform: (id)kCFBooleanFalse,
      (id)kCGImageSourceCreateThumbnailFromImageAlways: (id)kCFBooleanTrue,
      (id)kCGImageSourceThumbnailMaxPixelSize: @(maxPixelSize)};//longest edge of final image size


    CGImageRef cgImageRef = CGImageSourceCreateThumbnailAtIndex(imageSourceRef, 0, (__bridge CFDictionaryRef)dict);
    UIImage* image = [UIImage imageWithCGImage:cgImageRef
                                         scale:scale
                                   orientation:UIImageOrientationUp];
    CFRelease(cgImageRef);
    CFRelease(imageSourceRef);

    return image;
}

- (CGSize)sizeFromImageSource:(CGImageSourceRef)imageSourceRef
{
    // NSLog(@"%s",__FUNCTION__);

    //http://developer.apple.com/library/ios/#qa/qa1654/_index.html
    CFDictionaryRef imagePropertiesDictionary =
    CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, nil);

    CFNumberRef imageWidth = (CFNumberRef)CFDictionaryGetValue(imagePropertiesDictionary, kCGImagePropertyPixelWidth);
    CFNumberRef imageHeight = (CFNumberRef)CFDictionaryGetValue(imagePropertiesDictionary, kCGImagePropertyPixelHeight);

    CGFloat width, height;
    CFNumberGetValue(imageWidth, kCFNumberFloatType, &width);
    CFNumberGetValue(imageHeight, kCFNumberFloatType, &height);

    CFRelease(imagePropertiesDictionary);

    return (CGSize){width,height};
}


- (CGSize) scaleImageFromSize:(CGSize)size toFill:(CGSize)box
{
    // NSLog(@"%s",__FUNCTION__);

    //http://stackoverflow.com/questions/603907/uiimage-resize-then-crop
    //got it wrong but i fixed it...
    CGSize result = CGSizeZero;
    float imageRatio = size.width / size.height;
    float boxRatio = box.width / box.height;
    if (imageRatio > boxRatio) {  //if image is fatter than box
        result.height = box.height;
        result.width = imageRatio * box.height;
    } else {
        result.width = box.width;
        result.height = 1/imageRatio * box.width;
    }
    return result;
}

- (int)maxPixelSize:(CGSize)size
{
    // NSLog(@"%s",__FUNCTION__);

    //to ensure that the smallest dimension does not get rounded down.
    int result = 0;
    if (size.width > size.height)
    {
        result = size.height*(size.width/size.height);
    } else {
        result = size.width*(size.height/size.width);
    }
    return ceil(result);
}


@end
