//
//  SettingViewController.m
//  Demo
//
//  Created by zhicai on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"
#import "UIViewController+ActivityIndicate.h"
#import "NotificationRenderHelper.h"
#import "SettingTable.h"

@implementation SettingViewController

@synthesize rightButton;
@synthesize welcomeMessageLabel;
@synthesize mainScrollView;
@synthesize mainTableView;

NSArray *settingArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)loadSettingTableData
{
    settingArray = ([VariableStore sharedInstance].isLoggedIn) ? [SettingTable userDidLoginArray] : [SettingTable guessArray];
    DLog(@"Setting Table: %@", settingArray);
    [self.mainTableView reloadData];
}

- (void)customViewLoad
{
    if ([VariableStore sharedInstance].isLoggedIn) {
        [ViewHelper buildLogoutButton:self.rightButton];
        self.rightButton.tag = RIGHT_BAR_BUTTON_LOGOUT;        
    } else{
        [ViewHelper buildLoginButton:self.rightButton];
        self.rightButton.tag = RIGHT_BAR_BUTTON_LOGIN;
    }
    
    // init scroll view content size
    self.mainScrollView.contentSize = CGSizeMake(_ScrollViewContentSizeX, _ScrollViewContentSettingSizeY);   
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customViewLoad];
}

- (void)loadDataSource
{
    if ([[VariableStore sharedInstance] isLoggedIn] ) {     
        [ViewHelper buildLogoutButton:self.rightButton];
        self.rightButton.tag = RIGHT_BAR_BUTTON_LOGOUT;   
        self.welcomeMessageLabel.text = [@"你好! " stringByAppendingString:[VariableStore sharedInstance].user.name]; 
    } else {
        [ViewHelper buildLoginButton:self.rightButton];
        self.rightButton.tag = RIGHT_BAR_BUTTON_LOGIN;
        self.welcomeMessageLabel.text = @"欢迎来到街区！！"; 
    }
    [self loadSettingTableData];
    [self hideIndicator];
}

- (void) accountLoginFinished
{
  DLog(@"SettingViewController::accountLoginFinished");
  [self loadDataSource];
}

- (void)accountLogoutFinished
{
  DLog(@"SettingViewController::accountLogoutFinished");
  [self loadDataSource];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadDataSource];
}

- (void)viewDidUnload
{
    [self setWelcomeMessageLabel:nil];
    [self setRightButton:nil];
    [self setMainScrollView:nil];
    [self setMainTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)rightButtonAction:(id)sender {
    if (self.rightButton.tag == RIGHT_BAR_BUTTON_LOGIN) {
        [MTPopupWindow showWindowWithUIView:self.tabBarController.view];
    } else {
        [[VariableStore sharedInstance] signOut];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	/*
	 If the requesting table view is the search display controller's table view, return the count of
     the filtered list, otherwise return the count of the main list.
	 */
    return settingArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"SettingTableCell";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //set cell using data
    cell.textLabel.text = ((SettingTable *)[settingArray objectAtIndex:indexPath.row]).displayName;
    return cell;     
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *displayName = ((SettingTable *)[settingArray objectAtIndex:indexPath.row]).displayName;
    if (![VariableStore sharedInstance].isLoggedIn && ([displayName isEqualToString:@"注册或登陆"] || [displayName isEqualToString:@"设置"])) {
        [MTPopupWindow showWindowWithUIView:self.tabBarController.view];
        return;
    }
    [self performSegueWithIdentifier:((SettingTable *)[settingArray objectAtIndex:indexPath.row]).segueName sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"SellerAlertsToListingsView"]) {
//        DLog(@"SellerAlertsViewController::prepareForSegue");
//        SellerAlertsListingsViewController *lc = segue.destinationViewController;    
//        lc.alertId = [[self.alerts objectAtIndex:self.alertsTableView.indexPathForSelectedRow.row] objectForKey:@"id"];
//        lc.query = [[self.alerts objectAtIndex:self.alertsTableView.indexPathForSelectedRow.row] objectForKey:@"query"];
//        DLog(@"SellerAlertsViewController Segue Data: %@", lc.alertId);
//    }
}


@end
