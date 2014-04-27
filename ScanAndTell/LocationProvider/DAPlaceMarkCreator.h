//
//  DAPlaceMarkCreator.h
//  ScanAndTell
//
//  Created by Suman Chatterjee on 14/03/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^adressDetailsCallBack)(NSDictionary* placemark);
typedef void (^placeMarkCallBack)(CLPlacemark* placemark);

@interface DAPlaceMarkCreator : NSObject

-(void)getAddressDictionary:(adressDetailsCallBack) callback;

@end
