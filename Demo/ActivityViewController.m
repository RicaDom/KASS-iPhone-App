//
//  ActivityViewController.m
//  Demo
//
//  Created by zhicai on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ActivityViewController.h"
#import "UIViewController+ActivityIndicate.h"
#import "UIViewController+SegueActiveModel.h"
#import "UIViewController+TableViewRefreshPuller.h"
#import "ViewHelper.h"


@implementation ActivityViewController

@synthesize tabImageView = _tabImageView;
@synthesize emptyImageView = _emptyImageView;
@synthesize indicatorImageView = _indicatorImageView;
@synthesize emptyRecordsImageView = _emptyRecordsImageView;
@synthesize listingsTableView = _listingsTableView;
@synthesize tableView = _tableView;
@synthesize activitySegment = _activitySegment;
@synthesize userId = _userId;

/**
 EGORefreshTableHeaderDelegate
 */
- (void)refreshing
{
  [self loadDataSource];
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
    return 0 == self.tabImageView.tag;
    //return 0 == self.activitySegment.selectedSegmentIndex;
}

- (BOOL) isSellingTabSelected
{
    return 1 == self.tabImageView.tag;
    //return 1 == self.activitySegment.selectedSegmentIndex;
}

- (void)reset
{
    [VariableStore sharedInstance].myBuyingListings = nil;
    [VariableStore sharedInstance].mySellingListings = nil;
}

- (void)updateTableView
{
    if (![VariableStore.sharedInstance isLoggedIn]){
      [self reset];
      [self reloadTable];
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

- (IBAction)pressBuyingListButton:(id)sender {
    DLog(@"MyActivityViewController::pressBuyingListButton");
    [self.tabImageView setImage:[UIImage imageNamed:@"buying.png"]];
    self.tabImageView.tag = 0;
    
    self.indicatorImageView.image = [UIImage imageNamed:UI_IMAGE_ACTIVITY_NOTE_POST];
    [self updateTableView];
}

- (IBAction)pressSellingListButton:(id)sender {
    DLog(@"MyActivityViewController::pressBuyingListButton");
    [self.tabImageView setImage:[UIImage imageNamed:@"selling.png"]];
    self.tabImageView.tag = 1;
    
    self.indicatorImageView.image = [UIImage imageNamed:UI_IMAGE_ACTIVITY_NOTE_BROWSE];
    [self updateTableView];
}
////////////////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)activityChanged:(id)sender {
    DLog(@"ActivityViewController::(IBAction)activityChanged");
    [self updateTableView];
}

- (void)reloadTable
{
    DLog(@"ActivityViewController::reloadTable");
    
    //[self hideBackground];
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
        [self reset];
        [self hideIndicator];
        return; 
    }
    
    if ( [self isBuyingTabSelected] ) {
        [self.currentUser getListings]; 
    } else {
        [self.currentUser getOffers];
    }
}

//- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    if ([segue.identifier isEqualToString:@"ActBuyingListToOffers"]) {
//    } else if ([segue.identifier isEqualToString:@"ActSellingListToMessageBuyer"]) {
//        DLog(@"ActivityViewController::prepareForSegue:ActSellingListToMessageBuyer");
//    } else if ([segue.identifier isEqualToString:@"ActBuyingListToPayView"]) {
//        DLog(@"ActivityViewController::prepareForSegue:ActBuyingListToPayView");
//    }
//}

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
  self.tableView.pagingEnabled = NO;
    
    // table footer should be clear in order to see the arrow 
    self.tableView.tableFooterView = self.emptyImageView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedFromOfferViewNotification:) 
                                                 name:OFFER_TO_PAY_VIEW_NOTIFICATION
                                               object:nil];
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
          NSDictionary *offerWithSuccess = [NSDictionary dictionaryWithObjectsAndKeys:[NSDictionary dictionaryWithObjectsAndKeys:offer.dbId, @"id", OFFER_STATE_ACCEPTED, OFFER_STATE_ACCEPTED, nil] , @"offer", nil];
          [self performSegueWithModelJson:offerWithSuccess:@"ActBuyingListToPayView":self];
      }
    }
}

- (void)viewDidUnload
{
    self.activitySegment = nil;
    [self setEmptyRecordsImageView:nil];
    [self setListingsTableView:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:OFFER_TO_PAY_VIEW_NOTIFICATION object:nil];
    [self setTableView:nil];
    [self setTabImageView:nil];
    [self setEmptyImageView:nil];
    [self setIndicatorImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self registerTableViewRefreshPuller:self.tableView:self.view];
  [self updateTableView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [self unregisterTableViewRefreshPuller];
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
    
  if ( [self isBuyingTabSelected]) {
    return [[VariableStore sharedInstance].myBuyingListings count];
  } else {
    return [[VariableStore sharedInstance].mySellingListings count];
  }
  
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"activityCell";
    ListingTableCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ListingTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    UIImage *rowBackground = [UIImage imageNamed:UI_IMAGE_TABLE_CELL_BG];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:rowBackground];
    cell.backgroundView = imageView;
    
    UIImage *selectedBackground = [UIImage imageNamed:UI_IMAGE_TABLE_CELL_BG_PRESS];
    UIImageView *selectedImageView = [[UIImageView alloc] initWithImage:selectedBackground];
    cell.selectedBackgroundView = selectedImageView;
    
    int row = [indexPath row];
    for (UIView *view in cell.infoView.subviews) {
        [view removeFromSuperview];
    }
    
    // set cell background for all
    [cell.infoView setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:UI_IMAGE_ACTIVITY_PRICE_BG]]];
    
    // my buying list
    if ( [self isBuyingTabSelected] ) {
        ListItem *item = [[VariableStore sharedInstance].myBuyingListings objectAtIndex:row];
        cell.title.text = item.title;
      
      [item buildStatusIndicationView:cell.infoView.superview];
      [item buildListingTableCell:cell];

    } 
    
    // my selling list
    else {
        Offer *item = [[VariableStore sharedInstance].mySellingListings objectAtIndex:row];
        cell.title.text = item.title;

      [item buildStatusIndicationView:cell.infoView.superview];
      [item buildListingTableCell:cell];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    // Buying list segue
    if ( [self isBuyingTabSelected] ) {
        
        ListItem *item = [[VariableStore sharedInstance].myBuyingListings objectAtIndex:[indexPath row]];
        
        // if listing already has accepted offer, got to pay page
        if (item.isAccepted || item.isPaid) {
          
          NSDictionary *offerJson;
          if (!item.acceptedOffer ) {
            NSDictionary *offer = [[NSDictionary alloc] initWithObjectsAndKeys:item.acceptedOfferId, @"id", nil];
            offerJson = [[NSDictionary alloc] initWithObjectsAndKeys:offer, @"offer", nil];
          }else {
            offerJson = item.acceptedOffer.toJson;
          }
          
          [self performSegueWithModelJson:offerJson:@"ActBuyingListToPayView":self];
        } else {
          [self performSegueWithModelJson:item.toJson:@"ActBuyingListToOffers":self];
        }
    } 
    // Selling list segue
    else { 
      Offer *offer = [[VariableStore sharedInstance].mySellingListings objectAtIndex:[indexPath row]];
      [self performSegueWithModelJson:offer.toJson:@"ActSellingListToMessageBuyer":self];
    }
    
}

@end
