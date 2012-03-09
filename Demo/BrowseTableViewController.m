//
//  BrowseTableViewController.m
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BrowseTableViewController.h"
#import "UIViewController+ActivityIndicate.h"
#import "UIViewController+SegueActiveModel.h"

@implementation BrowseTableViewController

@synthesize browseSegment = _browseSegment;
@synthesize listingTableView = _listingTableView;
@synthesize currentListings = _currentListings;
@synthesize filteredListContent = _filteredListContent;
@synthesize mapButton = _mapButton;
@synthesize leftButton = _leftButton;

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;	
}

- (void)doneLoadingTableViewData{	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];	
}
#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{		
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
    [self performSelector:@selector(setupArray) withObject:nil afterDelay:1.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{	
	return _reloading; // should return if data source model is reloading	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{	
	return [NSDate date]; // should return date data source was last changed	
}

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
  [self.tableView reloadData];
  [self doneLoadingTableViewData];
//  [self stopLoading];
  [self hideIndicator];
}

// we need to locate user position before getting data
- (void)setupArray {
  DLog(@"BrowseTableViewController::setupArray");
  [self showLoadingIndicator];
  [self locateMe];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)locateMeFinished
{
  DLog(@"BrowseTableViewController::locateMeFinished ");
  
  NSMutableDictionary * dictionary = [VariableStore.sharedInstance getDefaultCriteria];
  
  if ( self.isNearbyTabSelected ) {
    
    [[self kassApp] getListingsNearby:dictionary];
    
  } else if ( self.isRecentTabSelected ) {
    
    [[self kassApp] getListingsRecent:dictionary];
    
  } else {
    
    [[self kassApp] getListingsMostPrice:dictionary];
    
  }

}

- (void) receivedFromNOMessageNotification:(NSNotification *) notification
{
    // [notification name] should always be NO_MESSAGE_TO_MESSAGE_VIEW_NOTIFICATION
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:NO_MESSAGE_TO_MESSAGE_VIEW_NOTIFICATION]) {
      DLog(@"BrowseTableViewController::receivedFromNOMessageNotification");
      NSDictionary *json = [notification object];
      [self performSegueWithModelJson:json:@"showBrowseItem":self];
    }
}

- (void)viewDidLoad
{
    DLog(@"BrowseTableViewController::viewDidLoad ");
    _searching = FALSE;
    [super viewDidLoad];
    [self setupArray];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedFromNOMessageNotification:) 
                                                 name:NO_MESSAGE_TO_MESSAGE_VIEW_NOTIFICATION
                                               object:nil];

    // navigation bar background color
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:NAVIGATION_BAR_BACKGROUND_COLOR_RED green:NAVIGATION_BAR_BACKGROUND_COLOR_GREEN blue:NAVIGATION_BAR_BACKGROUND_COLOR_BLUE alpha:NAVIGATION_BAR_BACKGROUND_COLOR_ALPHA];

//    UIImage *tableHeaderViewImage = [UIImage imageNamed:@"tableHeader.png"];
//    UIImageView *tableHeaderView = [[UIImageView alloc] initWithImage:tableHeaderViewImage];
//    self.listingTableView.tableHeaderView = tableHeaderView;
    //UIImage *tableHeaderViewImage = [UIImage imageNamed:@"tableHeader.png"];
    //UIImageView *tableHeaderView = [[UIImageView alloc] initWithImage:tableHeaderViewImage];
    
    UIImage *tableFooterViewImage = [UIImage imageNamed:@"login.png"];
    UIImageView *tableFooterView = [[UIImageView alloc] initWithImage:tableFooterViewImage];
    self.listingTableView.tableFooterView = tableFooterView;

    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
        view.delegate = self;
        [self.tableView addSubview:view];
        _refreshHeaderView = view;
    }
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
        
    self.filteredListContent = [[NSMutableArray alloc] init];
	[self.tableView reloadData];
    
    // init segment control view
    UIImage* img = [UIImage imageNamed:UI_IMAGE_BROWSE_SEGMENT_DIVIDER];
    UIImage* tempImg = [UIImage imageNamed:UI_IMAGE_BROWSE_DATE];
    [self.browseSegment setDividerImage:img forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];    
    self.browseSegment.frame = CGRectMake(0, self.browseSegment.frame.origin.y, tempImg.size.width*3+8, tempImg.size.height);
    [self browseSegmentAction:self];    
    UIImage *mapImg = [UIImage imageNamed:UI_IMAGE_BROWSE_MAP];
    [self.mapButton setImage:mapImg forState:UIControlStateNormal];
    self.mapButton.frame = CGRectMake(200, self.mapButton.frame.origin.y, mapImg.size.width+20, mapImg.size.height);
}

- (void)viewDidUnload
{
    [self setBrowseSegment:nil];
    [self setListingTableView:nil];
    [self setMapButton:nil];
    [self setLeftButton:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NO_MESSAGE_TO_MESSAGE_VIEW_NOTIFICATION object:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
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
    
  // if not login
  if ( ![self kassVS].isLoggedIn ) {
    
    DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:not login");
    [self performSegueWithModelJson:item.toJson:@"showBrowseItemUnlogin":self];
    
  }else if ( [[self kassVS ].user hasListItem:item] ){
    
    //if you are the buyer and you already accepted it
    if (item.isAccepted) {
      
      DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:you already accepted! ");
      [self performSegueWithModelJson:item.acceptedOffer.toJson:@"BrowseListingToBuyerPay":self];
      
    }else{
      //if you are the buyer go to buyers listing page
      DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:you are buyer");
      [self performSegueWithModelJson:item.toJson:@"BrowseListingToBuyerOffers":self];
    }
  }else if ( [item hasOfferer:[self currentUser]]){
    
    // if you have an offer
    DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:you've offered!");
    Offer *offer = [item getOfferFromOfferer:[self currentUser]];
    [self performSegueWithModelJson:offer.toJson:@"showBrowseItem":self];


  }else{
    //you are not buyer and you've not offered
    DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:logged in user");
    [self performSegueWithModelJson:item.toJson:@"showBrowseItemNoMessage":self];
  }
    
}

- (IBAction)browseSegmentAction:(id)sender {
    DLog(@"BrowseTableViewController::(IBAction)browseSegmentAction");
    if ( ![VariableStore sharedInstance].recentBrowseListings || 
       ![VariableStore sharedInstance].priceBrowseListings || ![VariableStore sharedInstance].nearBrowseListings) {
      [self setupArray];
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
  
  searchText = [searchText stringByReplacingOccurrencesOfString:@" " withString:@"+"];
  
  if ([searchText length] <= 0) { return; }
  
  DLog(@"BrowseTableViewController::filterContentForSearchText:q=%@,s=%@", searchText, scope);
  
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
