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

NSMutableArray *nearByItems, *recentItems, *priceItems, *currentItems;


- (void)reloadTable
{
  DLog(@"BrowseTableViewController::reloadTable");
  if ( 0 == self.browseSegment.selectedSegmentIndex ) {
    currentItems = nearByItems;
  } else if ( 1 == self.browseSegment.selectedSegmentIndex ){
    currentItems = recentItems;
  } else {
    currentItems = priceItems;
  }
  [self.tableView reloadData];
  [self stopLoading];
  [self hideIndicator];
}

- (void)getNearbyItems:(NSData *)data
{
  DLog(@"ActivityViewController::getNearbyItems");
  Listing *listing = [[Listing alloc] initWithData:data];
  nearByItems = [listing listItems];
  [self reloadTable];
}

- (void)getRecentItems:(NSData *)data
{
  DLog(@"ActivityViewController::getRecentItems");
  Listing *listing = [[Listing alloc] initWithData:data];
  recentItems = [listing listItems];
  [self reloadTable];
}

- (void)getMostPriceItems:(NSData *)data
{
  DLog(@"ActivityViewController::getMostPriceItems");
  Listing *listing = [[Listing alloc] initWithData:data];
  priceItems = [listing listItems];
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
        BrowseItemViewController *bvc = [segue destinationViewController];
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        int row = [path row];
        ListItem *item = [currentItems objectAtIndex:row];
        bvc.currentItem = item;
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

	//
	// Create a header view. Wrap it in a container to allow us to position
	// it better.
	//
//	UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 300, 60)];
//	UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
//	headerLabel.text = NSLocalizedString(@"Header for the table", @"");
//	headerLabel.textColor = [UIColor blackColor];
//	headerLabel.shadowColor = [UIColor grayColor];
//	headerLabel.shadowOffset = CGSizeMake(0, 1);
//	headerLabel.font = [UIFont boldSystemFontOfSize:22];
//	headerLabel.backgroundColor = [UIColor clearColor];
//	[containerView addSubview:headerLabel];
//	self.listingTableView.tableHeaderView = containerView;
    
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;];
    UIImage *tableHeaderViewImage = [UIImage imageNamed:@"tableHeader.png"];
    UIImageView *tableHeaderView = [[UIImageView alloc] initWithImage:tableHeaderViewImage];
    self.listingTableView.tableHeaderView = tableHeaderView;
    
    UIImage *tableFooterViewImage = [UIImage imageNamed:@"login.png"];
    UIImageView *tableFooterView = [[UIImageView alloc] initWithImage:tableFooterViewImage];
    self.listingTableView.tableFooterView = tableFooterView;
    self.navigationController.navigationBar.tintColor = [UIColor brownColor];
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
    // #warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [currentItems count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"listCell";
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
    
    // Configure the cell...
    ListItem *item = [currentItems objectAtIndex:indexPath.row];
    NSString *price = [[item askPrice] stringValue];

    cell.title.text = [item title];
    cell.subTitle.text = [item description];
    [cell.price setTitle:price forState:UIControlStateNormal];
    cell.price.enabled = NO;
    
    [cell.distance setTitle:@"888米" forState:UIControlStateNormal];
    cell.distance.enabled = NO;
    
    [cell.duration setTitle:@"7 天" forState:UIControlStateNormal];
    cell.duration.enabled = NO;
    return cell;
}

// Reloading data
- (void)refresh {
    [self performSelector:@selector(setupArray) withObject:nil afterDelay:1.0];
}

- (void)locateMe {
  VariableStore.sharedInstance.locateMeManager.delegate = self;
  [VariableStore.sharedInstance.locateMeManager locateMe];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  int row = [indexPath row];
  ListItem *item = [currentItems objectAtIndex:row];
    
    // if you are the buyer or you are one of the sellers
    // show your messages  
    
    // if not login
  if ( !VariableStore.sharedInstance.isLoggedIn ) {
    DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:not login");
    [self performSegueWithIdentifier:@"showBrowseItemUnlogin" sender:self];
  }else if ( VariableStore.sharedInstance.user.userId == item.userId ){
    //go to buyers listing page
    DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:you are buyer");
    [self performSegueWithIdentifier:@"showItem" sender:self];
  }else if ( [item.offererIds indexOfObject:VariableStore.sharedInstance.user.userId] != NSNotFound){
    //you've offered this listing, go to the offer page
    DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:you've offered!");
    [self performSegueWithIdentifier:@"showOffer" sender:self];
  }else{
    //you are not buyer and you've not offered
    DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:logged in user");
    [self performSegueWithIdentifier:@"showBrowseItem" sender:self];
  }
    
}

- (IBAction)browseSegmentAction:(id)sender {
  DLog(@"BrowseTableViewController::(IBAction)browseSegmentAction");
  if ( !recentItems || !priceItems || !nearByItems) {
    [self setupArray];
  }else{
    [self reloadTable]; //reload ui
  }
}

// call back from BrowseItemNoMsgViewController
- (void)switchBrowseItemView 
{
    [self performSegueWithIdentifier:@"showBrowseItem" sender:self];
}
@end
