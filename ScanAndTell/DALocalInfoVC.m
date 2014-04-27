//
//  DAGraphDetailsVC.m
//  ScanAndTell
//
//  Created by Suman Chatterjee on 16/03/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DALocalInfoVC.h"

@interface DALocalInfoVC ()
@property (strong, nonatomic) IBOutlet UIWebView *graphView;

@end

@implementation DALocalInfoVC

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
}

- (void)viewWillAppear:(BOOL)animated
{
    NSURLRequest *request = [NSURLRequest requestWithURL:_URLToShow];
    [self.graphView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
