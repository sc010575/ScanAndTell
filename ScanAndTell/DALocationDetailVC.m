//
//  DALocationDetailVC.m
//  ScanAndTell
//
//  Created by Suman Chatterjee on 23/03/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DALocationDetailVC.h"
#import  <MapKit/MapKit.h>
#import "OSLocationServiceProvider.h"

@interface DALocationDetailVC ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation DALocationDetailVC

#pragma mark view handling

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
    self.mapView.showsPointsOfInterest = YES;
    self.mapView.zoomEnabled = YES;
    self.mapView.scrollEnabled = YES;
    self.mapView.zoomEnabled = YES;
    [self.view addSubview:self.slideBtn];
    [self.view bringSubviewToFront:self.slideBtn];
    self.slideBtn.hidden = NO;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CLLocationCoordinate2D location = [OSLocationServiceProvider shared].currentLocation.coordinate;
    self.mapView.region = MKCoordinateRegionMakeWithDistance(location, 5000, 5000);
    
    [UIView animateWithDuration:5.0 animations:^{
        
        self.mapView.showsUserLocation = YES;
        [self.mapView setCenterCoordinate:location];
        
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    //Remove KVO for progress
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
