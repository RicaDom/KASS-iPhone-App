//
//  SellerAlertsListingsViewController.m
//  kass
//
//  Created by Wesley Wang on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SellerAlertsListingsViewController.h"
#import "UIResponder+VariableStore.h"
#import "UIViewController+SegueActiveModel.h"
#import "UIViewController+ActivityIndicate.h"
#import "ListingTableCell.h"
#import "ViewHelper.h"

@implementation SellerAlertsListingsViewController

@synthesize noListingsMessage = _noListingsMessage;
@synthesize alertId = _alertId;
@synthesize query = _query;
@synthesize alertListings = _alertListings;
@synthesize alertListingsTableView = _alertListingsTableView;

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

- (void)refreshViewAfterLoadData
{
    if (self.alertListings.count <= 0) {
        self.noListingsMessage.hidden = NO;
        self.alertListingsTableView.hidden = YES;
    } else {
        self.noListingsMessage.hidden = YES;
        self.alertListingsTableView.hidden = NO;
    }
  
    self.navigationItem.title = (self.query.isBlank || [self.query isEqualToString:@"ALL"]) ? TEXT_ALL_GOODS : self.query;
  
    [self.alertListingsTableView reloadData];
  [self hideIndicator];
}

- (void)accountDidGetAlertListings:(NSDictionary *)dict
{
    DLog(@"SellerAlertsListingsViewController::accountDidGetAlertListings");
    DLog(@"accountDidGetAlertListings dict: %@", dict);
    Listing *listing = [[Listing alloc] initWithDictionary:dict];
    self.alertListings = [listing listItems];
    [self refreshViewAfterLoadData];
}

- (void)loadAlertListings
{
    if (self.alertId.length > 0) {
      [self showLoadingIndicator];
        [self.currentUser getAlertListings:self.alertId];
    } else {
        [ViewHelper showErrorAlert:ERROR_MSG_CONNECTION_FAILURE:self];
    }
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
  self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:NAVIGATION_BAR_BACKGROUND_COLOR_RED green:NAVIGATION_BAR_BACKGROUND_COLOR_GREEN blue:NAVIGATION_BAR_BACKGROUND_COLOR_BLUE alpha:NAVIGATION_BAR_BACKGROUND_COLOR_ALPHA];
}

- (void)viewDidUnload
{
    [self setAlertListingsTableView:nil];
    [self setNoListingsMessage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
    [self loadAlertListings];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    return self.alertListings.count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"myAlertListingsTableCell";
    ListingTableCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ListingTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //set cell using data
    
    [cell buildCellByListItem:[self.alertListings objectAtIndex:indexPath.row]];
    return cell;     
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // check table view  
    //ListItem *item = [self.alertListings objectAtIndex:[indexPath row]];
    [self performSegueByModel:[self.alertListings objectAtIndex:indexPath.row]];
}


@end
