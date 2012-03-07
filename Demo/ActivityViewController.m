//
//  ActivityViewController.m
//  Demo
//
//  Created by zhicai on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ActivityViewController.h"
#import "UIViewController+ActivityIndicate.h"
#import "ViewHelper.h"


@implementation ActivityViewController
@synthesize emptyRecordsImageView = _emptyRecordsImageView;
@synthesize listingsTableView = _listingsTableView;
@synthesize activitySegment = _activitySegment;
@synthesize userId = _userId;

NSMutableArray *currentItems;

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
    [self performSelector:@selector(loadDataSource) withObject:nil afterDelay:1.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{	
	return _reloading; // should return if data source model is reloading	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{	
	return [NSDate date]; // should return date data source was last changed	
}

- (void)accountLogoutFinished
{
  DLog(@"ActivityViewController::accountLogoutFinished");
  [self updateTableView];
}

- (void) accountLoginFinished
{
  DLog(@"ActivityViewController::accountLoginFinished");
  [self updateTableView];
}

- (void) accountDidGetListings:(NSDictionary *)dict
{
  DLog(@"ActivityViewController::accountDidGetListings:dict");
  [self getBuyingItems:dict];
}

- (void) accountDidGetOffers:(NSDictionary *)dict
{
  DLog(@"ActivityViewController::accountDidGetOffers:dict");
  [self getSellingItems:dict];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL) isBuyingTabSelected
{
  return 0 == self.activitySegment.selectedSegmentIndex;
}

- (BOOL) isSellingTabSelected
{
  return 1 == self.activitySegment.selectedSegmentIndex;
}

- (void)showBackground
{
  if (self.emptyRecordsImageView == nil || self.emptyRecordsImageView.image == nil) {
    self.emptyRecordsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:UI_IMAGE_ACTIVITY_BACKGROUND]];
    [self.view addSubview:self.emptyRecordsImageView];
  }
  [self hideIndicator];
}

- (void)reset
{
  [VariableStore sharedInstance].myBuyingListings = nil;
  [VariableStore sharedInstance].mySellingListings = nil;
}

- (void)hideBackground
{
  if( self.emptyRecordsImageView && [currentItems count] > 0){
    [self.emptyRecordsImageView removeFromSuperview];
    self.emptyRecordsImageView = nil;
  }
}

- (void)updateTableView
{
  if (![VariableStore.sharedInstance isLoggedIn]){
    [self showBackground];
  } else if (![VariableStore.sharedInstance isCurrentUser:_userId]) {     
    _userId = VariableStore.sharedInstance.user.userId;
    [self reset];
    [self loadDataSource];
  } else if ( (!VariableStore.sharedInstance.myBuyingListings && [self isBuyingTabSelected]) || 
              (!VariableStore.sharedInstance.mySellingListings && [self isSellingTabSelected]) ) {
    [self loadDataSource];
  } else {
    [self reloadTable];
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)activityChanged:(id)sender {
  DLog(@"ActivityViewController::(IBAction)activityChanged");
  [self updateTableView];
}

- (void)reloadTable
{
  DLog(@"ActivityViewController::reloadTable");
  if ( [self isBuyingTabSelected]) {
    currentItems = [VariableStore sharedInstance].myBuyingListings;
  } else {
    currentItems = [VariableStore sharedInstance].mySellingListings;
  }
  
  [self hideBackground];
  [self.tableView reloadData];
  //[self stopLoading];
  [self doneLoadingTableViewData];
  [self hideIndicator];
}

- (void)getBuyingItems:(NSDictionary *)dict
{
  DLog(@"ActivityViewController::getBuyingItems");
  Listing *listing = [[Listing alloc] initWithDictionary:dict];
  [VariableStore sharedInstance].myBuyingListings = [listing listItems];
  [self reloadTable];
}


- (void)getSellingItems:(NSDictionary *)dict
{
  DLog(@"ActivityViewController::getSellingItems");
  Offers *offers = [[Offers alloc] initWithDictionary:dict];
  [VariableStore sharedInstance].mySellingListings = [offers offers];
  [self reloadTable];
}

-(void)loadDataSource{
  if (![[self kassVS] isLoggedIn]) { 
    [self showBackground];
    return; 
  }
  
  if ( [self isBuyingTabSelected] ) {
    [self.currentUser getListings]; 
  } else {
    [self.currentUser getOffers];
  }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  NSIndexPath *path = [self.tableView indexPathForSelectedRow];
  int row = [path row];
  
    if ([segue.identifier isEqualToString:@"ActBuyingListToOffers"]) {
        UINavigationController *nc = [segue destinationViewController];
        ItemViewController *ivc = (ItemViewController *)nc.topViewController;
        
        ListItem *item = [currentItems objectAtIndex:row];
        ivc.currentItem = item;
      
    } else if ([segue.identifier isEqualToString:@"ActSellingListToMessageBuyer"]) {
      DLog(@"ActivityViewController::prepareForSegue:ActSellingListToMessageBuyer");
      UINavigationController *nc = [segue destinationViewController];
      BrowseItemViewController *bvc = (BrowseItemViewController *)nc.topViewController; 
    
      bvc.currentOffer = [currentItems objectAtIndex:row];
        
    } else if ([segue.identifier isEqualToString:@"ActBuyingListToPayView"]) {
      DLog(@"ActivityViewController::prepareForSegue:ActBuyingListToPayView");
      
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

//#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self reset];
  
  // navigation bar background color
  self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:NAVIGATION_BAR_BACKGROUND_COLOR_RED green:NAVIGATION_BAR_BACKGROUND_COLOR_GREEN blue:NAVIGATION_BAR_BACKGROUND_COLOR_BLUE alpha:NAVIGATION_BAR_BACKGROUND_COLOR_ALPHA];
  // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:NAVIGATION_BAR_BACKGROUND_IMAGE] forBarMetrics:UIBarMetricsDefault];
    
  [[NSNotificationCenter defaultCenter] addObserver:self
                                        selector:@selector(receivedFromOfferViewNotification:) 
                                        name:OFFER_TO_PAY_VIEW_NOTIFICATION
                                        object:nil];
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
        view.delegate = self;
        [self.tableView addSubview:view];
        _refreshHeaderView = view;
    }
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
    
}

- (void) receivedFromOfferViewNotification:(NSNotification *) notification
{
    // [notification name] should always be OFFER_TO_PAY_VIEW_NOTIFICATION
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:OFFER_TO_PAY_VIEW_NOTIFICATION]) {
        Offer *offer = (Offer *)[notification object];       
      if (offer) {
          DLog (@"ActivityViewController::receivedFromOfferViewNotification! %@", offer);
          [self kassAddToModelDict:@"BuyerPayViewController":offer.toJson];
          [self performSegueWithIdentifier:@"ActBuyingListToPayView" sender:self];
      }
    }
}

- (void)viewDidUnload
{
    self.activitySegment = nil;
    [self setEmptyRecordsImageView:nil];
    [self setListingsTableView:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:OFFER_TO_PAY_VIEW_NOTIFICATION object:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self updateTableView];
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
    // #warning Incomplete method implementation.
    // Return the number of rows in the section.

    return [currentItems count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"activityCell";
    ListingTableCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ListingTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIImage *rowBackground = [UIImage imageNamed:@"middleRow.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:rowBackground];
    cell.backgroundView = imageView;
    
    UIImage *selectedBackground = [UIImage imageNamed:@"middleRowSelected.png"];
    UIImageView *selectedImageView = [[UIImageView alloc] initWithImage:selectedBackground];
    cell.selectedBackgroundView = selectedImageView;
    
    int row = [indexPath row];
    for (UIView *view in cell.infoView.subviews) {
        [view removeFromSuperview];
    }
    // cell.infoView = [[UIView alloc] initWithFrame:CGRectMake(238, 6, 76, 76)];
    // customize table cell listing view
    
    // my buying list
    if ( [self isBuyingTabSelected] ) {
        ListItem *item = [currentItems objectAtIndex:row];
        cell.title.text = item.title;
        cell.subTitle.text = item.description;
        //item.acceptedPrice = [NSDecimalNumber decimalNumberWithDecimal:
        //                 [[NSNumber numberWithDouble:50] decimalValue]];
        // if user already accepted any offer, show pay now icon
        if (item.acceptedPrice != nil && item.acceptedPrice > 0) {
          [ViewHelper buildListItemPayNowCell:item:cell];            
        } else {
            int offersCount = [item.offers count];
            // if the listing has offers
            if (offersCount > 0) {
              [ViewHelper buildListItemHasOffersCell:item:cell];                
            } else { // otherwise show pending states                               
              [ViewHelper buildListItemNoOffersCell:item:cell];
            }
        }
    } 
    
    // my selling list
    else {
        Offer *item = [currentItems objectAtIndex:row];
        cell.title.text = item.title;
        cell.subTitle.text = item.description;

        
        // TODO
        // if my offer has been accepted by buyer
        DLog(@"Offer State: %@", item.state);
        if ([item.state isEqualToString: OFFER_STATE_ACCEPTED] ) {
          [ViewHelper buildOfferAcceptedCell:item:cell];
        } else {
            // TODO
            // if the listing is expired
            if (1 != 1) {
              [ViewHelper buildOfferExpiredCell:item:cell];
            } 
            // if the offer is pending
            else {
              [ViewHelper buildOfferExpiredCell:item:cell];
            }
            
        }
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
    // <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    // Buying list segue
    if ( [self isBuyingTabSelected] ) {
        int row = [indexPath row];
        ListItem *item = [currentItems objectAtIndex:row];
//        item.acceptedPrice = [NSDecimalNumber decimalNumberWithDecimal:
//                        [[NSNumber numberWithDouble:50] decimalValue]];
        // if listing already has accepted offer, got to pay page
        if (item.isAccepted) {
          
          ListItem *item = [currentItems objectAtIndex:row];
          [self kassAddToModelDict:@"BuyerPayViewController":item.acceptedOffer.toJson];          
          [self performSegueWithIdentifier:@"ActBuyingListToPayView" sender:self];
          
        } else {
            [self performSegueWithIdentifier:@"ActBuyingListToOffers" sender:self];
        }
    } 
    // Selling list segue
    else {
        [self performSegueWithIdentifier:@"ActSellingListToMessageBuyer" sender:self];
    }
    
}

// Reloading data
//- (void)refresh {
//    [self performSelector:@selector(loadDataSource) withObject:nil afterDelay:2.0];
//}

@end
