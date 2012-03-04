//
//  BrowseTableViewController.m
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BrowseTableViewController.h"
#import "UIViewController+ActivityIndicate.h"

@implementation BrowseTableViewController
@synthesize browseSegment = _browseSegment;
@synthesize listingTableView = _listingTableView;
@synthesize currentListings = _currentListings;
@synthesize filteredListContent = _filteredListContent;


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

- (void)reloadTable
{
  DLog(@"BrowseTableViewController::reloadTable");
  if ( 0 == self.browseSegment.selectedSegmentIndex ) {
    self.currentListings = [VariableStore sharedInstance].nearBrowseListings;
  } else if ( 1 == self.browseSegment.selectedSegmentIndex ){
    self.currentListings = [VariableStore sharedInstance].recentBrowseListings;
  } else {
    self.currentListings = [VariableStore sharedInstance].priceBrowseListings;
  }
  [self.tableView reloadData];
  [self doneLoadingTableViewData];
//  [self stopLoading];
  [self hideIndicator];
}

- (void)getNearbyItems:(NSData *)data
{
  DLog(@"ActivityViewController::getNearbyItems");
  Listing *listing = [[Listing alloc] initWithData:data];
  [VariableStore sharedInstance].nearBrowseListings = [listing listItems];
  [self reloadTable];
}

- (void)getRecentItems:(NSData *)data
{
  DLog(@"ActivityViewController::getRecentItems");
  Listing *listing = [[Listing alloc] initWithData:data];
  [VariableStore sharedInstance].recentBrowseListings = [listing listItems];
  [self reloadTable];
}

- (void)getMostPriceItems:(NSData *)data
{
  DLog(@"ActivityViewController::getMostPriceItems");
  Listing *listing = [[Listing alloc] initWithData:data];
  [VariableStore sharedInstance].priceBrowseListings = [listing listItems];
  [self reloadTable];
}

// we need to locate user position before getting data
- (void)setupArray {
  DLog(@"BrowseTableViewController::setupArray");
  [self showLoadingIndicator];
  [self locateMe];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showBrowseItem"]) {
      
    
        
    } else if ([segue.identifier isEqualToString:@"BrowseListingToBuyerOffers"]) {
        UINavigationController *nc = [segue destinationViewController];
        ItemViewController *ivc = (ItemViewController *)nc.topViewController;
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        int row = [path row];
        ListItem *item = [self.currentListings objectAtIndex:row];
        ivc.currentItem = item;
        
    } else if ([segue.identifier isEqualToString:@"showBrowseItemUnlogin"]) {
        BrowseItemNoMsgViewController *bvc = [segue destinationViewController];
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        int row = [path row];
        ListItem *item = [self.currentListings objectAtIndex:row];
        bvc.currentItem = item;
        
    } else if ([segue.identifier isEqualToString:@"showBrowseItemNoMessage"]) {
        BrowseItemNoMsgViewController *bvc = [segue destinationViewController];
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        int row = [path row];
        ListItem *item = [self.currentListings objectAtIndex:row];
        bvc.currentItem = item;
        
    } else if ([segue.identifier isEqualToString:@"BrowseListingToBuyerPay"]) {
        
      
    }
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

#pragma mark - View lifecycle
- (void)locateMeFinished
{
  DLog(@"BrowseTableViewController::locateMeFinished ");
  NSString *latlng = [NSString stringWithFormat:@"%+.6f,%+.6f", 
                      VariableStore.sharedInstance.location.coordinate.latitude, 
                      VariableStore.sharedInstance.location.coordinate.longitude]; 
  
  NSMutableDictionary * dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:latlng, @"center",
                                      @"10", @"radius",
                                      nil];
  
  if ( 0 == _browseSegment.selectedSegmentIndex) {
    KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getNearbyItems:"];
    [ka getListings:dictionary];
    
  } else if ( 1 == _browseSegment.selectedSegmentIndex) {
    [dictionary setObject:@"ended_at" forKey:@"sort"];
    KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getRecentItems:"];
    [ka getListings:dictionary];
  } else {
    [dictionary setObject:@"price" forKey:@"sort"];
    KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getMostPriceItems:"];
    [ka getListings:dictionary];
  }

}

- (void)viewDidLoad
{
    DLog(@"BrowseTableViewController::viewDidLoad ");
    [super viewDidLoad];

    [self setupArray];

//    UIImage *tableHeaderViewImage = [UIImage imageNamed:@"tableHeader.png"];
//    UIImageView *tableHeaderView = [[UIImageView alloc] initWithImage:tableHeaderViewImage];
//    self.listingTableView.tableHeaderView = tableHeaderView;
    
//    UIImage *tableFooterViewImage = [UIImage imageNamed:@"login.png"];
//    UIImageView *tableFooterView = [[UIImageView alloc] initWithImage:tableFooterViewImage];
//    self.listingTableView.tableFooterView = tableFooterView;
//    self.navigationController.navigationBar.tintColor = [UIColor brownColor];
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
        view.delegate = self;
        [self.tableView addSubview:view];
        _refreshHeaderView = view;
    }
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
}

- (void)viewDidUnload
{
    [self setBrowseSegment:nil];
    [self setListingTableView:nil];
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
	if (tableView == self.searchDisplayController.searchResultsTableView)
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
    static NSString *CellIdentifier = @"browseListingTableCell";
    ListingTableCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
    if (cell == nil) {
        cell = [[ListingTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    DLog(@"Cell: %@", cell);
    DLog(@"Index Path: %d", indexPath.row);
    //set cell using data
    if (aTableView == self.searchDisplayController.searchResultsTableView) {
        [cell buildCellByListItem:[self.filteredListContent objectAtIndex:indexPath.row]];
    } else {
        [cell buildCellByListItem:[self.currentListings objectAtIndex:indexPath.row]];
    }

    return cell;
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
  ListItem *item = [self.currentListings objectAtIndex:row];

    // if not login
  if ( ![self kassVS].isLoggedIn ) {
    DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:not login");
    [self performSegueWithIdentifier:@"showBrowseItemUnlogin" sender:self];
  }else if ( [[self kassVS ].user hasListItem:item] ){
    
    //if you are the buyer and you already accepted it
    if (item.isAccepted) {
      DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:you already accepted! ");
      
      [self kassAddToModelDict:@"BuyerPayViewController":item.acceptedOffer.toJson];
      [self performSegueWithIdentifier:@"BrowseListingToBuyerPay" sender:self];
      
    }else{
      //if you are the buyer go to buyers listing page
      DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:you are buyer");
      [self performSegueWithIdentifier:@"BrowseListingToBuyerOffers" sender:self];
    }
  }else if ( [item hasOfferer:[self currentUser]]){
    
    Offer *offer = [item getOfferFromOfferer:[self currentUser]];
    [self kassAddToModelDict:@"BrowseItemViewController":offer.toJson];

    //you've offered this listing, go to the offer page
    DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:you've offered!");
    [self performSegueWithIdentifier:@"showBrowseItem" sender:self];
  

  }else{
    //you are not buyer and you've not offered
    DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:logged in user");
    [self performSegueWithIdentifier:@"showBrowseItemNoMessage" sender:self];
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
}

// call back from BrowseItemNoMsgViewController
- (void)switchBrowseItemView 
{
  DLog(@"BrowseTableViewController::switchBrowseItemView");
  [self performSegueWithIdentifier:@"showBrowseItem" sender:self];
}

#pragma mark -
#pragma mark Content Filtering

//Loading sample data, for TESTING ONLY!
- (void) initListingsData {
    ListItem *item = [ListItem new];
    
    item = [ListItem new];
    [item setTitle:@"求购2012年东方卫视跨年演唱会门票"];
    [item setDescription:@"听说有很多明星，阵容强大啊，求门票啊~~ 听说有很多明星，阵容强大啊，求门票啊~~ 听说有很多明星，阵容强大啊，求门票啊~~"];
    item.askPrice = [NSDecimalNumber decimalNumberWithDecimal:
                     [[NSNumber numberWithFloat:89.75f] decimalValue]];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:22];
    [comps setMonth:1];
    [comps setYear:2012];
    item.postedDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    item.postDuration = [NSNumber numberWithInt:172800];
    [self.filteredListContent addObject:item];
    
    item = [ListItem new];
    [item setTitle:@"什么都不想吃了……给我找辆车让我回家吧"];
    [item setDescription:@"什么都不想吃了……给我找辆车让我回家吧 什么都不想吃了……给我找辆车让我回家吧 什么都不想吃了……给我找辆车让我回家吧"];
    
    [comps setDay:29];
    [comps setMonth:1];
    [comps setYear:2012];
    item.postedDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    item.postDuration = [NSNumber numberWithInt:43200];
    item.askPrice = [NSDecimalNumber decimalNumberWithDecimal:
                     [[NSNumber numberWithFloat:18.55f] decimalValue]];
    
    [self.filteredListContent addObject:item];
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
	[self initListingsData];
    [self.tableView reloadData];
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
//	for (Product *product in listContent)
//	{
//		if ([scope isEqualToString:@"All"] || [product.type isEqualToString:scope])
//		{
//			NSComparisonResult result = [product.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
//            if (result == NSOrderedSame)
//			{
//				[self.filteredListContent addObject:product];
//            }
//		}
//	}
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
