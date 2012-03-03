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

NSMutableArray *currentItems;

- (IBAction)activityChanged:(id)sender {
  DLog(@"ActivityViewController::(IBAction)activityChanged");
  if ( [[VariableStore sharedInstance].myBuyingListings count] == 0 || [[VariableStore sharedInstance].mySellingListings count] == 0) {
    [self loadDataSource];
  }else{
    [self reloadTable];
  }
}

- (void) accountLoginFinished
{
  DLog(@"ActivityViewController::accountLoginFinished");
  [self loadDataSource];
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

- (void)reloadTable
{
  DLog(@"ActivityViewController::reloadTable");
  if ( 0 == self.activitySegment.selectedSegmentIndex) {
    currentItems = [VariableStore sharedInstance].myBuyingListings;
  } else {
    currentItems = [VariableStore sharedInstance].mySellingListings;
  }
  if (self.emptyRecordsImageView && [currentItems count] > 0) {
    [self.emptyRecordsImageView removeFromSuperview];
    self.emptyRecordsImageView = nil;
  }
  
  [self.tableView reloadData];
  [self stopLoading];
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
  if (![[self kassVS] isLoggedIn]) { return; }
  
  [self showLoadingIndicator];
  if ( 0 == self.activitySegment.selectedSegmentIndex) {
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
      BrowseItemViewController *bvc = [segue destinationViewController];
    
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
  [self loadDataSource];
  
  self.navigationController.navigationBar.tintColor = [UIColor brownColor];  
  
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
//  DLog(@"VariableStore=%@,userid=%@",[VariableStore sharedInstance], [VariableStore sharedInstance].user.userId);
    if ([[VariableStore sharedInstance] isLoggedIn]) {        
        [self.emptyRecordsImageView removeFromSuperview];
        self.emptyRecordsImageView = nil;
        [self reloadTable];
    } else {
        if (self.emptyRecordsImageView == nil || self.emptyRecordsImageView.image == nil) {
            self.emptyRecordsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
            [self.view addSubview:self.emptyRecordsImageView];
        }
    }
    
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
    if ( 0 == self.activitySegment.selectedSegmentIndex ) {
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
    if ( 0 == self.activitySegment.selectedSegmentIndex) {
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
- (void)refresh {
    [self performSelector:@selector(loadDataSource) withObject:nil afterDelay:2.0];
}

@end
