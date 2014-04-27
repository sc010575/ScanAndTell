//
//  DAPlaceMarkCreator.m
//  ScanAndTell
//
//  Created by Suman Chatterjee on 14/03/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DAPlaceMarkCreator.h"
#import "OSLocationServiceProvider.h"

@interface DAPlaceMarkCreator()

@property (nonatomic, copy) adressDetailsCallBack addressCallback;
@property (nonatomic, copy) placeMarkCallBack placeMarkCallback;
@end

@implementation DAPlaceMarkCreator

-(void)getAddressDictionary:(adressDetailsCallBack) callback
{
    _addressCallback = callback;
    __block NSDictionary *dictionary = [NSDictionary dictionary];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation* currentLocation = [OSLocationServiceProvider shared].currentLocation;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if(placemarks.count){
            dictionary = [[placemarks objectAtIndex:0] addressDictionary];
            if(_addressCallback)
                _addressCallback(dictionary);
         }
    }];
    
}
@end
