//
//  NSData+ImageIO.h
//  Juper
//
//  Created by jonathan on 02/10/2013.
//  Copyright (c) 2013 Juper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ImageIO)

- (UIImage*)thumbnailWithSize:(CGSize)size;

@end
