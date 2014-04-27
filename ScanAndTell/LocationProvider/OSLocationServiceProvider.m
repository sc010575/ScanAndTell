//
//  OSLocationServiceProvider.m
//  OSLocateMe
//
//  Created by Suman Chatterjee (C) on 03/01/2014.
//  Copyright (c) 2014 Ordnance Survey. All rights reserved.
//

#import "OSLocationServiceProvider.h"
#import <MapKit/MapKit.h>

@interface OSLocationServiceProvider()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong, readwrite) CLLocation *currentLocation;
@end


@implementation OSLocationServiceProvider

// Self
static OSLocationServiceProvider *sharedServiceProviderInstance = nil;


+ (OSLocationServiceProvider *) shared
{
    @synchronized(self)
    {
        if (sharedServiceProviderInstance == NULL)
        {
            sharedServiceProviderInstance = [[self alloc] init];
        }
    }
    return(sharedServiceProviderInstance);
}

//startUpdatingLocation
-(BOOL) startUpdatingLocation
{
    
    if([CLLocationManager locationServicesEnabled])
    {
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        //start the location manager
        [_locationManager startUpdatingLocation];
        _locationManager.delegate = self;
        return YES;
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOCATION_SERVICES_ERROR object:nil];
        return NO;
    }

    return NO;
}

//startUpdatingHeading
-(BOOL) startUpdatingHeading
{
    if([CLLocationManager headingAvailable])
    {
        _locationManager.headingFilter = kCLHeadingFilterNone;
        
        //start the location manager
        [_locationManager startUpdatingHeading];
        _locationManager.delegate = self;
        return YES;

    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOCATION_SERVICES_ERROR object:nil];
        return NO;
    }
    
    return NO;
}

-(id) init
{
    self = [super init];
    if (self)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _curentGridReferencePosition = nil;
    }
    return self;
}

//startAllServices
-(BOOL) startAllServices:(CLLocationAccuracy) accuracyValue
{
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager headingAvailable])
    {
        _locationManager.headingFilter = kCLHeadingFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationAccuracy = accuracyValue;
        //start the location manager
        [_locationManager startUpdatingLocation];
        [_locationManager startUpdatingHeading];
        return YES;
    }
    else
    {
        //call the delegate that location service is enabled
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOCATION_SERVICES_ERROR object:nil];
        return NO;
    }
    return NO;

}

//startAllServices
-(BOOL) startAllServices
{
    return [self startAllServices:kCLLocationAccuracyBest];
}


//stopAllServices
-(BOOL) stopAllServices
{
    //dissmiss all calibration
    if(_locationManager)
    {
        [_locationManager dismissHeadingCalibrationDisplay];
        //stop the location manager
        [_locationManager stopUpdatingHeading];
        [_locationManager stopUpdatingLocation];
        _locationManager.delegate = nil;
        return YES;
    }
    
    return NO;

}

/**
 stopUpdatingLocation
 */

-(BOOL) stopUpdatingLocation
{
    if(_locationManager)
    {
        [_locationManager stopUpdatingHeading];
        [_locationManager stopUpdatingLocation];
        _locationManager.delegate = nil;
        return YES;
    }
    return NO;
}

/**
 stopUpdatingHeading
 */

-(BOOL) stopUpdatingHeading
{
    if(_locationManager)
    {
        [_locationManager stopUpdatingHeading];
        [_locationManager stopUpdatingLocation];
        _locationManager.delegate = nil;
        return YES;
    }
    return NO;

}



#pragma mark
#pragma mark - CoreLocation


- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
	
    // Convert Degree to Radian

    NSNumber * oldRad =  [ NSNumber numberWithFloat:manager.heading.magneticHeading];
	NSNumber * newRad =  [ NSNumber numberWithFloat:newHeading.magneticHeading];
   
    NSDictionary*  userInfo = [NSDictionary dictionaryWithObjectsAndKeys:oldRad, @"oldValue",newRad,@"newValue",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DIRECTION_NEEDS_CHANGE object:nil userInfo:userInfo];
}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager
{
    return _locationManagerShouldDisplayHeadingCalibration;
}


- (void)dismissTheHeadingCalibrationDisplay
{
    [_locationManager dismissHeadingCalibrationDisplay];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //NSLog(@"didFailWithError: %@", error);
    
    if (error.code == kCLErrorLocationUnknown)
        return;
    
    if (error.code == kCLErrorDenied)
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOCATION_SERVICES_ERROR object:nil];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //NSLog(@"didUpdateToLocation: %@ accuracy %f", newLocation,newLocation.horizontalAccuracy);
    CLLocation *currentLocation = newLocation;
    if (currentLocation != nil)
    {
        //update display
        [self updateAndNotifyGridReffChange:currentLocation.coordinate withAccuracy:newLocation.horizontalAccuracy andDesiredAccuracy:manager.desiredAccuracy];
        
        NSNumber * currentLat = [NSNumber numberWithDouble:currentLocation.coordinate.latitude];
        
        NSNumber * currentLong = [NSNumber numberWithDouble:currentLocation.coordinate.longitude];
        self.currentLocation = newLocation;
        NSDictionary*  userInfo = [NSDictionary dictionaryWithObjectsAndKeys:currentLong, @"currentLong",currentLat,@"currentLat",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOCATION_SERVICES_AVAILABLE object:nil userInfo:userInfo];

    }
}

-(void) updateAndNotifyGridReffChange:(CLLocationCoordinate2D) currentCoordinate withAccuracy:(CLLocationAccuracy) horizontalAccuracy andDesiredAccuracy:(CLLocationAccuracy) desiredAccuracy
{
    NSString * grid;
    NSString * easting;
    NSString * northing;
    
    //got the accuracy . If the accuracy is greater than desire accuracy then send blank as grid reff
    if (horizontalAccuracy <= _locationAccuracy)
    {
        //Yes we got accurate location and GPS Signal!
        NSString* gp = [self getGridPointRefference:currentCoordinate];
        if ([_curentGridReferencePosition isEqualToString:@""] || ![_curentGridReferencePosition isEqualToString:gp])
        {
            _curentGridReferencePosition = gp;
            
            NSArray *subStrings = [_curentGridReferencePosition componentsSeparatedByString:@" "];
            if ([subStrings count] == 1) {
            return;
            }
        
            grid     =    [subStrings objectAtIndex:0];
            easting  =    [subStrings objectAtIndex:1];
            northing =    [subStrings objectAtIndex:2];
            
            NSDictionary*  userInfo = [NSDictionary dictionaryWithObjectsAndKeys:grid, @"grid",easting,@"easting",northing,@"northing",nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GRID_REFF_CHANGE object:nil userInfo:userInfo];

        }
    }
    else
    {
        grid     =    @"---";
        easting  =    @"---";
        northing =    @"---";
        
        NSDictionary*  userInfo = [NSDictionary dictionaryWithObjectsAndKeys:grid, @"grid",easting,@"easting",northing,@"northing",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GRID_REFF_CHANGE object:nil userInfo:userInfo];
        
    }
    
}


-(NSString*) getGridPointRefference:(CLLocationCoordinate2D)coordinate
{
    //update display
    return @"Test";
}


@end
