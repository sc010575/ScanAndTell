//
//  DAPlaceDetailsViewController.m
//  ScanAndTell
//
//  Created by Suman Chatterjee on 24/02/2014.
//  Copyright (c) 2014 Suman Chatterjee. All rights reserved.
//

#import "DAInformationlistVC.h"
#import "DADownloadService.h"
#import "DAResultResponse.h"
#import "DALocalInfoVC.h"
#import "DAZooplaService.h"
#import "DAPlaceMarkCreator.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"


@interface DAInformationlistVC ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *localInfoTableView;
@property (strong , nonatomic) NSArray * localInfoArray;
@property (strong , nonatomic) NSArray * areaValueArray;
@property (strong , nonatomic) NSDictionary * localInfoDict;
@property (strong , nonatomic) NSDictionary * areaValueDict;
@end

@implementation DAInformationlistVC
{
    BOOL localInforAvailable;
    BOOL areaDataAvailable;
    DALocalInfoVC* showGraph;
    DAPlaceMarkCreator *placemarkCreator;
    
    
}

@synthesize  localInfoArray = _localInfoArray;
@synthesize  areaValueArray = _areaValueArray;

- (NSArray*)localInfoArray
{
    if (!_localInfoArray){
        _localInfoArray = @[@[@"Education Chart Graph", @"DALocalInfoVC"],
                            @[@"Council tax graph",@"DALocalInfoVC"],
                            @[@"Crime graph",@"DALocalInfoVC"],
                            @[@"People details", @"DALocalInfoVC"]
                            ];
        
    }
    return _localInfoArray;
}


- (NSArray*)areaValueArray
{
    if (!_areaValueArray){
        _areaValueArray = @[@[@"Average Price",@"DAAreaValueVC"],
                            @[@"Ranges",@"DAAreaValueVC"],
                            @[@"Trend", @"DAAreaValueVC"],
                            @[@"Average home price", @"DAAreaValueVC"]
                            ];
        
    }
    return _areaValueArray;
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
    localInforAvailable = NO;
    self.localInfoTableView.delegate = self;

}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[DADownloadService shared] addObserver:self forKeyPath:@"results" options:NSKeyValueObservingOptionNew
                                    context:NULL];
    self.navigationController.navigationBar.hidden = NO;
    
    placemarkCreator = [[DAPlaceMarkCreator alloc] init];
    [placemarkCreator getAddressDictionary:^(NSDictionary *placemark) {
        NSString *postcode = placemark[@"ZIP"];
        [DAZooplaService requestZooplaServiceForPostCode:postcode];
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    //Remove KVO for progress
    [[DADownloadService shared] removeObserver:self forKeyPath:@"results"];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"results"])
    {
        NSLog(@"handle value");
        DAResultResponse* response = [object valueForKeyPath:keyPath];
        if([response.requestID isEqualToString:@"Social"]){
            self.localInfoDict = response.returnDict;
            localInforAvailable = YES;
        }
        if([response.requestID isEqualToString:@"Area"]){
            self.areaValueDict = response.returnDict;
            areaDataAvailable = YES;
        }
        [self.localInfoTableView reloadData];
        NSLog(@"The keyPath %@ changed to %@", keyPath, response.returnDict);
        
    }
}

#pragma mark table view handling

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSLog(@"Number of Sections");
    if(section == 0)
        return @"Local information";
    if(section == 1)
        return @"Area value";
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section = 0) ?[self.areaValueArray count]:[self.localInfoArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"TableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if (indexPath.section == 0){
        if(!localInforAvailable ){
            cell.textLabel.text = @"Waiting ...";
            cell.textLabel.textColor = [UIColor lightGrayColor];
        }
        else{
            cell.textLabel.text = self.localInfoArray[indexPath.row][0];
            cell.textLabel.textColor = [UIColor darkTextColor];
        }
    }
    else if (indexPath.section == 1)
    {
        if(!areaDataAvailable)
        {
            cell.textLabel.text = @"Waiting ...";
            cell.textLabel.textColor = [UIColor lightGrayColor];
            
        }
        else
        {
            cell.textLabel.text = self.areaValueArray[indexPath.row][0];
            cell.textLabel.textColor = [UIColor darkTextColor];
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(showGraph == nil){
        showGraph = [self.storyboard instantiateViewControllerWithIdentifier:@"DAGraphDetailsVC"];
    }
    self.navigationController.navigationBar.hidden = YES;
    showGraph.URLToShow = [NSURL URLWithString:[self loadURLAndShow:indexPath]];
    [self.sidePanelController setCenterPanel:showGraph];
}

- (NSString*) loadURLAndShow:(NSIndexPath *)indexPath
{
    NSString * URLToShow;
    if (indexPath.section == 0 ){
     URLToShow =   [DAZooplaService URLForDict:self.localInfoDict withService:zoopla_localinfo withIndexPath:indexPath];
    }
    else if(indexPath.section == 1 ){
     URLToShow =   [DAZooplaService URLForDict:self.areaValueDict withService:zoopla_areagraph withIndexPath:indexPath];
    }
    return URLToShow;
}

@end
