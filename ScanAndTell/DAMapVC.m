//
//  DAMapViewController.m
//  ScanAndTell
//
//  Created by Suman Chatterjee on 09/02/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DAMapVC.h"
#import "OSLocationServiceProvider.h"
#import  <MapKit/MapKit.h>

@interface DAMapVC ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *MapView;

@end

@implementation DAMapVC
{
    long double _currentLat;
    long double _currentLong;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.MapView.pitchEnabled = YES;
    self.MapView.showsBuildings = YES;
    self.MapView.showsPointsOfInterest = YES;
    self.MapView.zoomEnabled = YES;
    self.MapView.scrollEnabled = YES;
    self.MapView.zoomEnabled = YES;
    self.MapView.userInteractionEnabled = YES;
}


//OnLocationServiceError
-(void) OnLocationServiceError
{
    
    UIAlertView *noLocationAlert = [[UIAlertView alloc] initWithTitle:@"Sacn" message:@"Location Service  is disabled , Please enable it from Settings > Privacy > Location Services" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [noLocationAlert show];
    //Stop all location services
   [[OSLocationServiceProvider shared] stopUpdatingLocation];
}

//OnlocationServiceAvailable
-(void) OnlocationServiceAvailable:(NSNotification *)notification
{
    //Stop location update because you got the data
    [[OSLocationServiceProvider shared] stopUpdatingLocation];
    
    _currentLat = [[[notification userInfo] valueForKey:@"currentLat"] doubleValue] ;
    _currentLong = [[[notification userInfo] valueForKey:@"currentLong"] doubleValue] ;
    
    //set up initial location
    CLLocationCoordinate2D breckenridgeLocation = CLLocationCoordinate2DMake(_currentLat, _currentLong);
    //self.mapView.centerCoordinate = breckenridgeLocation;
    self.MapView.region = MKCoordinateRegionMakeWithDistance(breckenridgeLocation, 5000, 5000);
    CLLocationCoordinate2D ground = CLLocationCoordinate2DMake(_currentLat, _currentLong);
    
    CLLocationCoordinate2D eye = CLLocationCoordinate2DMake(_currentLat, _currentLong);

    MKMapCamera *mapCamera = [MKMapCamera cameraLookingAtCenterCoordinate:ground
                                                        fromEyeCoordinate:eye
                                                              eyeAltitude:100];
    //set the pith
     mapCamera.pitch = 80;
    
    [UIView animateWithDuration:5.0 animations:^{
        
                self.MapView.camera = mapCamera;
                self.MapView.showsUserLocation = YES;
                [self.MapView setCenterCoordinate:breckenridgeLocation];

    }];
 }


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OnLocationServiceError) name:NOTIFICATION_LOCATION_SERVICES_ERROR object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OnlocationServiceAvailable:) name:NOTIFICATION_LOCATION_SERVICES_AVAILABLE object:nil];
   [[OSLocationServiceProvider shared] startUpdatingLocation];
    [OSLocationServiceProvider shared].locationAccuracy = kCLLocationAccuracyHundredMeters;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[OSLocationServiceProvider shared] stopUpdatingLocation];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_LOCATION_SERVICES_AVAILABLE object:nil ];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_LOCATION_SERVICES_ERROR object:nil ];
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
	// Center the map the first time we get a real location change.
	static dispatch_once_t centerMapFirstTime;
    
	if ((userLocation.coordinate.latitude != 0.0) && (userLocation.coordinate.longitude != 0.0)) {
		dispatch_once(&centerMapFirstTime, ^{
			[self.MapView setCenterCoordinate:userLocation.coordinate animated:YES];
		});
	}
	
	// Lookup the information for the current location of the user.
 /*   [self.geocoder reverseGeocodeLocation:self.mapView.userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
		if ((placemarks != nil) && (placemarks.count > 0)) {
			// If the placemark is not nil then we have at least one placemark. Typically there will only be one.
			_placemark = [placemarks objectAtIndex:0];
			
			// we have received our current location, so enable the "Get Current Address" button
			[self.getAddressButton setEnabled:YES];
		}
		else {
			// Handle the nil case if necessary.
		}
    }];*/
    
}


@end
