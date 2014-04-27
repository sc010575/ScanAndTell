//
//  DASlidingPanelViewController.m
//  ScanAndTell
//
//  Created by Suman Chatterjee on 13/03/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DASlidingPanelVC.h"

@interface DASlidingPanelVC ()

@end

@implementation DASlidingPanelVC

-(void) awakeFromNib
{
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"DAInformationlistVC"]];
    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"DALocationDetailVC"]];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}
@end
