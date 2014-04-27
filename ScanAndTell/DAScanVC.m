//
//  DAViewController.m
//  ScanAndTell
//
//  Created by Suman Chatterjee on 25/01/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DAScanVC.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "DAZooplaService.h"
#import "OSLocationServiceProvider.h"
#import <AVFoundation/AVFoundation.h>
#import "DASlidingPanelVC.h"

@interface DAScanVC ()
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (weak, nonatomic) IBOutlet UIButton *scanBtn;
@end

@implementation DAScanVC
{
    AVCaptureSession *session;
    CLLocationCoordinate2D currentLocation;
}

#pragma mark viewHandling

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self startCamera];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OnLocationServiceError) name:NOTIFICATION_LOCATION_SERVICES_ERROR object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OnlocationServiceAvailable:) name:NOTIFICATION_LOCATION_SERVICES_AVAILABLE object:nil];
    [[OSLocationServiceProvider shared] startUpdatingLocation];
    [OSLocationServiceProvider shared].locationAccuracy = kCLLocationAccuracyHundredMeters;

}

-(void) viewWillDisappear:(BOOL)animated
{
    [self stopCamera];
    [[OSLocationServiceProvider shared] stopUpdatingLocation];
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_LOCATION_SERVICES_AVAILABLE object:nil ];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_LOCATION_SERVICES_ERROR object:nil ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[OSLocationServiceProvider shared] stopUpdatingLocation];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_LOCATION_SERVICES_AVAILABLE object:nil ];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_LOCATION_SERVICES_ERROR object:nil ];
}


#pragma mark camera

- (void)startCamera
{
	// start capturing frames
	// Create the AVCapture Session
	session = [[AVCaptureSession alloc] init];
	
	// create a preview layer to show the output from the camera
	self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
	self.previewLayer.frame = self.view.frame;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
	[self.view.layer addSublayer:self.previewLayer];
    [self.view bringSubviewToFront:self.scanBtn];
	
	// Get the default camera device
	AVCaptureDevice* camera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	
	// Create a AVCaptureInput with the camera device
	NSError *error=nil;
	AVCaptureInput* cameraInput = [[AVCaptureDeviceInput alloc] initWithDevice:camera error:&error];
	if (cameraInput == nil) {
		NSLog(@"Error to create camera capture:%@",error);
	} else {
        [session addInput:cameraInput];
        [session setSessionPreset:AVCaptureSessionPresetPhoto];
        [session startRunning];
    }
}

- (void)stopCamera
{
    [session stopRunning];
    session = nil;
    
    [self.previewLayer removeFromSuperlayer];
    self.previewLayer = nil;
}

#pragma mark segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *segueIdentifier = [segue identifier];
    
    if ([segueIdentifier isEqualToString:@"toPlaceDetailsID"])
    {
 //       self.navigationController.navigationBar.hidden = NO;
        NSLog(@"toPlaceDetailsID response");
    }
}

#pragma mark location service delegate


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
    [[OSLocationServiceProvider shared] stopUpdatingLocation];
    //set up initial location
    currentLocation = [OSLocationServiceProvider shared].currentLocation.coordinate;
    
}


@end
