//
//  OSLocationServiceProvider.h
//  OSLocateMe
//
//  Created by Suman Chatterjee (C) on 03/01/2014.
//  Copyright (c) 2014 Ordnance Survey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#pragma mark - NSNotifications

/**
 NOTIFICATION_DIRECTION_NEEDS_CHANGE  is used to get the Megnetic heading information
 This notification send two values for  Old and new Megnetic Heading  .
 Client program can add an obsrver for this notification and get the heading values through
 "oldValue" and "newValue" keys 
 
 Example use
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DirectionChanged:) name:NOTIFICATION_DIRECTION_NEEDS_CHANGE object:nil];

 -(void)DirectionChanged:(NSNotification *)notification
 {
 NSNumber *oldHeading = [[notification userInfo] valueForKey:@"oldValue"];
 
 NSNumber *newHeading = [[notification userInfo]  valueForKey:@"newValue"];
 
 }
 */

#define NOTIFICATION_DIRECTION_NEEDS_CHANGE @"NotificationDirectionNeedsChange"

/**
 
 NOTIFICATION_GRID_REFF_CHANGE will send a notification when the grid reff will change.
 This Notification will send three keys "grid" , "easting" and "northing" .
 
 Example Use 
 
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gridRefferenceChanged:) name:NOTIFICATION_GRID_REFF_CHANGE object:nil];

 
 - (void)gridRefferenceChanged:(NSNotification *)notification
 {
 //update the label
 _gridLabel.text = [[notification userInfo] valueForKey:@"grid"];
 _eastingLabel.text = [[notification userInfo] valueForKey:@"easting"];
 _northingLabel.text = [[notification userInfo]  valueForKey:@"northing"];
 }

 */

#define NOTIFICATION_GRID_REFF_CHANGE @"NotificationGridReffChange"

/**
 NOTIFICATION_LOCATION_SERVICES_ERROR will send when Location service provider will 
 encounter any error . Currently it is not sending any added User info but could be 
 extended later . 
 */
#define NOTIFICATION_LOCATION_SERVICES_ERROR @"NotificationLocationServicesError"


#define NOTIFICATION_LOCATION_SERVICES_AVAILABLE @"NotificationLocationServiceAvailable"


@interface OSLocationServiceProvider : NSObject

+ (OSLocationServiceProvider *) shared;


/**
 startUpdatingLocation will start the location based services
 locatiion update .
 */
-(BOOL) startUpdatingLocation;


/**
 stopUpdatingLocation 
 */

-(BOOL) stopUpdatingLocation;

/**
 stopUpdatingHeading
 */

-(BOOL) stopUpdatingHeading;


/**
 startUpdatingHeading will start the location based services
 heading update.
 */
-(BOOL) startUpdatingHeading;

/**
 startAllServices will start all the location based services
 locatiion update and heading update.
 It returns NO if the Location service is not available or switched Off
 in the Settings
 */
-(BOOL) startAllServices;

/**
 startAllServices will start all the location based services
 locatiion update and heading update with a desired accuracy value .
 It returns NO if the Location service is not available or switched Off
 in the Settings
 */

-(BOOL) startAllServices:(CLLocationAccuracy) accuracyValue;


/**
 stopAllServices will stop all the location based services
 locatiion update and heading update.

 */
-(BOOL) stopAllServices;

/**
 getGridPointRefference will return the National Grid details . 
 a String which will have a grid easting and northing . 
 */
-(NSString*) getGridPointRefference:(CLLocationCoordinate2D)coordinate;

/**
 The current position as OS Grid Reference with 3 digits per axis. Can be nil.
 */
@property (strong, readonly) NSString *curentGridReferencePosition;

/**
 If you return YES from this method, Core Location displays the heading calibration alert on top of the current window immediately. The calibration alert prompts the user to move the device in a particular pattern so that Core Location can distinguish between the Earth’s magnetic field and any local magnetic fields. The alert remains visible until calibration is complete or until you explicitly dismiss it by calling the dismissHeadingCalibrationDisplay method. In the latter case, you can use this method to set up a timer and dismiss the interface after a specified amount of time has elapsed.
 */
@property (assign, nonatomic)BOOL locationManagerShouldDisplayHeadingCalibration;


/**
 locationAccuracy will indecate the Accurecy you want to filter the desire accurecy 
 
 */
@property (assign, nonatomic)CLLocationAccuracy locationAccuracy;

@property (nonatomic, strong, readonly) CLLocation* currentLocation;


@end
