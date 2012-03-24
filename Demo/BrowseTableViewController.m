//
//  BrowseTableViewController.m
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewHelper.h"
#import "BrowseTableViewController.h"
#import "UIViewController+ActivityIndicate.h"
#import "UIViewController+SegueActiveModel.h"
#import "UIViewController+TableViewRefreshPuller.h"

@implementation BrowseTableViewController

@synthesize browseSegment = _browseSegment;
@synthesize listingTableView = _listingTableView;
@synthesize currentListings = _currentListings;
@synthesize filteredListContent = _filteredListContent;
@synthesize mapButton = _mapButton;
@synthesize leftButton = _leftButton;
@synthesize remoteNotificationListingId = _remoteNotificationListingId;
@synthesize tableFooter = _tableFooter;

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods
- (BOOL) isNearbyTabSelected
{
  return 0 == self.browseSegment.selectedSegmentIndex;
}

- (BOOL) isRecentTabSelected
{
  return 1 == self.browseSegment.selectedSegmentIndex;
}

- (BOOL) isMostPriceTabSelected
{
  return 2 == self.browseSegment.selectedSegmentIndex;
}

- (void)reloadTable
{
  DLog(@"BrowseTableViewController::reloadTable");
  if ( self.isNearbyTabSelected ) {
    self.currentListings = [VariableStore sharedInstance].nearBrowseListings;
  } else if ( self.isRecentTabSelected ){
    self.currentListings = [VariableStore sharedInstance].recentBrowseListings;
  } else {
    self.currentListings = [VariableStore sharedInstance].priceBrowseListings;
  }
  [self.listingTableView reloadData];
  [self doneLoadingTableViewData];
  [self hideIndicator];

   self.tableFooter.hidden =(self.currentListings.count > 6)? NO : YES;
}

// we need to locate user position before getting data
- (void)loadDataSource {
  DLog(@"BrowseTableViewController::loadDataSource");
  if (!location && !_locating) {
    [self showLoadingIndicator];
    [self locateMe];
  }else{
    [self populateData];
  }
}

/**
 EGORefreshTableHeaderDelegate
 */
- (void)refreshing
{
  [self loadDataSource];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void) appDidGetListing:(NSDictionary *)dict
{
    DLog(@"BrowseTableViewController::appDidGetListing:listing=%@", dict);
//    self.currentItem = [[ListItem alloc] initWithDictionary:dict];
    [self performSegueByModel:[[ListItem alloc] initWithDictionary:dict]];
}

- (void)remoteNotificationGetListing:(NSString *)listItemId
{
    DLog(@"BrowseTableViewController::remoteNotificationGetListing");
    if ( listItemId && ![listItemId isBlank] ) {
        [self.kassApp getListing:listItemId];
    }
}

- (void)appDidGetListingsNearby:(NSDictionary *)dict
{
  Listing *listing = [[Listing alloc] initWithDictionary:dict];
  [VariableStore sharedInstance].nearBrowseListings = [listing listItems];
  [self reloadTable];
}

- (void)appDidGetListingsRecent:(NSDictionary *)dict
{
  Listing *listing = [[Listing alloc] initWithDictionary:dict];
  [VariableStore sharedInstance].recentBrowseListings = [listing listItems];
  [self reloadTable];
}

- (void)appDidGetListingsMostPrice:(NSDictionary *)dict
{
  Listing *listing = [[Listing alloc] initWithDictionary:dict];
  [VariableStore sharedInstance].priceBrowseListings = [listing listItems];
  [self reloadTable];
}

- (void)populateData
{
  NSMutableDictionary * dictionary = [VariableStore.sharedInstance getDefaultCriteria];
  
  if ( self.isNearbyTabSelected ) {
    
    [[self kassApp] getListingsNearby:dictionary];
    
  } else if ( self.isRecentTabSelected ) {
    
    [[self kassApp] getListingsRecent:dictionary];
    
  } else {
    
    [[self kassApp] getListingsMostPrice:dictionary];
    
  }
}

- (void)locateMeFinished
{
  DLog(@"BrowseTableViewController::locateMeFinished ");
  location = VariableStore.sharedInstance.location;
  _locating = FALSE;
  [self populateData];

}

- (void) receivedFromNOMessageNotification:(NSNotification *) notification
{
    // [notification name] should always be NO_MESSAGE_TO_MESSAGE_VIEW_NOTIFICATION
    // unless you use this method for observation of other notifications
    // as well.
    transferJson = [notification object];
}

/**
 To clear item to show on map
 */
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  VariableStore.sharedInstance.itemToShowOnMap = nil;
  [super prepareForSegue:segue sender:sender];
}

- (void)viewDidLoad
{
    DLog(@"BrowseTableViewController::viewDidLoad ");
    _searching = FALSE;
    [super viewDidLoad];
    [self loadDataSource];

    if ([self.remoteNotificationListingId length] > 0) {
        [self remoteNotificationGetListing:self.remoteNotificationListingId];
        self.remoteNotificationListingId = nil;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedFromNOMessageNotification:) 
                                                 name:NO_MESSAGE_TO_MESSAGE_VIEW_NOTIFICATION
                                               object:nil];
  
  self.listingTableView.tableFooterView = self.tableFooter;  
  self.filteredListContent = [[NSMutableArray alloc] init];
	[self.listingTableView reloadData];
  
  // init segment control view
  UIImage* img = [UIImage imageNamed:UI_IMAGE_BROWSE_SEGMENT_DIVIDER];
  UIImage* tempImg = [UIImage imageNamed:UI_IMAGE_BROWSE_DATE];
  [self.browseSegment setDividerImage:img forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];    
  self.browseSegment.frame = CGRectMake(0, self.browseSegment.frame.origin.y, tempImg.size.width*3, tempImg.size.height);
  
  [self browseSegmentAction:self];    
  
  [ViewHelper buildSmallBackButton:self.leftButton];
  [ViewHelper buildMapButton:self.mapButton];
}

- (void)viewDidUnload
{
    [self setBrowseSegment:nil];
    [self setListingTableView:nil];
    [self setMapButton:nil];
    [self setLeftButton:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NO_MESSAGE_TO_MESSAGE_VIEW_NOTIFICATION object:nil];
    [self setTableFooter:nil];
    [super viewDidUnload];
 
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self registerTableViewRefreshPuller:self.listingTableView:self.view];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];  
  if (transferJson) {
    [self performSegueWithModelJson:transferJson:@"showBrowseItem":self];
  }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  [self unregisterTableViewRefreshPuller];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
  transferJson = nil;
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
	if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
	{
        return [self.filteredListContent count];
    }
	else
	{
        return [self.currentListings count];
    }    
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([aTableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        static NSString *CellIdentifier = @"browseListingTableCell";
        UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        //set cell using data
        cell.textLabel.text = ((ListItem *)[self.filteredListContent objectAtIndex:indexPath.row]).title;
        //[cell buildCellByListItem:[self.currentListings objectAtIndex:indexPath.row]];
        return cell;
    } else {
        static NSString *CellIdentifier = @"browseListingTableCell";
        ListingTableCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[ListingTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        //set cell using data
        
        [cell buildCellByListItem:[self.currentListings objectAtIndex:indexPath.row]];
        return cell;        
    }
}

// Reloading data
//- (void)refresh {
//    [self performSelector:@selector(setupArray) withObject:nil afterDelay:1.0];
//}

- (void)locateMe {
  _locating = TRUE;
  VariableStore.sharedInstance.locateMeManager.delegate = self;
  [VariableStore.sharedInstance.locateMeManager locateMe];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  int row = [indexPath row];
    
  // check table view  
  ListItem *item = ([tableView isEqual:self.searchDisplayController.searchResultsTableView])?
    [self.filteredListContent objectAtIndex:row]:[self.currentListings objectAtIndex:row];
    
  [self performSegueByModel:item];
    
}

- (IBAction)leftButtonAction:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)loadMoreButtonAction:(id)sender {
    [self refreshing];
}

- (IBAction)browseSegmentAction:(id)sender {
    DLog(@"BrowseTableViewController::(IBAction)browseSegmentAction");
    if ( ![VariableStore sharedInstance].recentBrowseListings || 
       ![VariableStore sharedInstance].priceBrowseListings || ![VariableStore sharedInstance].nearBrowseListings) {
      [self loadDataSource];
    }else{
      [self reloadTable]; //reload ui
    }
    
    if ( self.isNearbyTabSelected ) {
        [self.browseSegment setImage:[UIImage imageNamed:UI_IMAGE_BROWSE_NEAR_DOWN] forSegmentAtIndex:0];
        [self.browseSegment setImage:[UIImage imageNamed:UI_IMAGE_BROWSE_DATE] forSegmentAtIndex:1];
        [self.browseSegment setImage:[UIImage imageNamed:UI_IMAGE_BROWSE_MONEY] forSegmentAtIndex:2];
    } else if ( self.isRecentTabSelected ) {
        [self.browseSegment setImage:[UIImage imageNamed:UI_IMAGE_BROWSE_NEAR] forSegmentAtIndex:0];
        [self.browseSegment setImage:[UIImage imageNamed:UI_IMAGE_BROWSE_DATE_DOWN] forSegmentAtIndex:1];
        [self.browseSegment setImage:[UIImage imageNamed:UI_IMAGE_BROWSE_MONEY] forSegmentAtIndex:2];        
    } else if ( self.isMostPriceTabSelected ) {
        [self.browseSegment setImage:[UIImage imageNamed:UI_IMAGE_BROWSE_NEAR] forSegmentAtIndex:0];
        [self.browseSegment setImage:[UIImage imageNamed:UI_IMAGE_BROWSE_DATE] forSegmentAtIndex:1];
        [self.browseSegment setImage:[UIImage imageNamed:UI_IMAGE_BROWSE_MONEY_DOWN] forSegmentAtIndex:2];        
    }
}

- (void)appRequestFailed:(NSDictionary *)errors
{
  DLog(@"BrowseTableViewController::appRequestFailed:errors");
  [super appRequestFailed:errors];
  _searching = FALSE;
}

- (void)appDidGetListingsBySearch:(NSDictionary *)dict
{
  DLog(@"BrowseTableViewController::appDidGetListingsBySearch:dict=%@", dict);
  
  Listing *listing = [[Listing alloc] initWithDictionary:dict];
  NSMutableArray *listItems = [listing listItems];
  
  for (int i=0; i<[listItems count]; i++) {
    ListItem *item = (ListItem *)[listItems objectAtIndex:i];
    [self.filteredListContent addObject:item];
  }
  
  _searching = FALSE;
  [self.searchDisplayController.searchResultsTableView reloadData];
}


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
//  [self.filteredListContent removeAllObjects];
//  [self initListingsData];
  
  if (_searching) { DLog(@"BrowseTableViewController::filterContentForSearchText:searching ... "); return; }
  
  searchText = [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
  searchText = [searchText stringByReplacingOccurrencesOfString:@" " withString:@"+"];
  
  if ([searchText length] <= 0) { return; }
  
  NSString* encodedSearchText =
  [searchText stringByAddingPercentEscapesUsingEncoding:
   NSASCIIStringEncoding];
  
  DLog(@"BrowseTableViewController::filterContentForSearchText:q=%@,s=%@", encodedSearchText, scope);
  
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
  _searching = TRUE;
	
  [[self kassApp] getListingsBySearch:[VariableStore.sharedInstance getDefaultCriteria] :searchText];
  
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
  // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end
