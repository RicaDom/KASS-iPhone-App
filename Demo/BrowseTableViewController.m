//
//  BrowseTableViewController.m
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BrowseTableViewController.h"

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
}

- (void)getNearbyItems:(NSData *)data
{
  DLog(@"ActivityViewController::getNearbyItems");
  Listing *listing = [[Listing alloc] initWithData:data];
  nearByItems = [listing listItems];
  [self reloadTable];
}

- (void)setupArray {
  // near by items
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getNearbyItems:"];
  
  NSString *latlng = [NSString stringWithFormat:@"%+.6f,%+.6f", 
                      locationManager.location.coordinate.latitude, 
                      locationManager.location.coordinate.longitude]; 
  
  NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                               latlng, @"center",
                               @"10", @"radius",
                               nil];
  [ka getListings:dictionary];
    
  // sample data
//  NSData *data = [NSData dataWithContentsOfFile:
//                  [[NSBundle mainBundle] pathForResource:@"listings" ofType:@"json"] ]; 
  
  ListItem *item = [ListItem new];
  
  // most recent items
  // recentItems = [NSMutableArray new];
  
  // TESTING DATA - GLOBAL ARRAY FOR USER SUBMITTING NEW LISTING
  recentItems = [VariableStore sharedInstance].allListings;
  
  // price sorted items
  priceItems = [NSMutableArray new];
  
  item = [ListItem new];
  [item setTitle:@"Professionally clean outdoor grill"];
  [item setDescription:@"Grand Turbo gas grill. Need someone to clean all parts of it to make it look like new"];
  item.askPrice = [NSDecimalNumber decimalNumberWithDecimal:
                   [[NSNumber numberWithFloat:59.75f] decimalValue]];
  
  [priceItems addObject:item];
  
  item = [ListItem new];
  [item setTitle:@"External harddrive 500GB"];
  [item setDescription:@"500GB"];
  item.askPrice = [NSDecimalNumber decimalNumberWithDecimal:
                   [[NSNumber numberWithFloat:18.55f] decimalValue]];
  
  [priceItems addObject:item];
  
  item = [ListItem new];
  [item setTitle:@"Samsung galaxy"];
  [item setDescription:@"I broke mine I need one that works!"];
  item.askPrice = [NSDecimalNumber decimalNumberWithDecimal:
                   [[NSNumber numberWithFloat:18.55f] decimalValue]];
  
  [priceItems addObject:item];
    
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

- (void)locateMe
{
  DLog(@"BrowseTableViewController::locateMe");
  // Create the location manager if this object does not
  // already have one.
  if (nil == locationManager)
    locationManager = [[CLLocationManager alloc] init];
  
  locationManager.delegate = self;
  locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
  
  // Set a movement threshold for new events.
  locationManager.distanceFilter = 50;
  
  [locationManager startUpdatingLocation];
}

- (void)locateFinished
{
  DLog(@"BrowseTableViewController::locateFinished");
  [self setupArray];
}

- (void)viewDidLoad
{
  DLog(@"BrowseTableViewController::viewDidLoad ");
  [super viewDidLoad];
  [self locateMe];

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
    [self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
}

- (void)addItem {
    // TODO
    // Adding item to the list
    
    [self.tableView reloadData];
    
    [self stopLoading];
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
    NSLog(@"didSelectRowAtIndexPath .... ");
    
    // TODO check whether is my post
    if(indexPath.row%2 == 0) {
        [self performSegueWithIdentifier:@"showBrowseItem" sender:self];
    } else {
        [self performSegueWithIdentifier:@"showBrowseItemNoMessage" sender:self];
    }
    
    //[self performSegueWithIdentifier:@"showMyItem" sender:self];
    
}

- (IBAction)browseSegmentAction:(id)sender {
  [self reloadTable];
}

// call back from BrowseItemNoMsgViewController
- (void)switchBrowseItemView 
{
    [self performSegueWithIdentifier:@"showBrowseItem" sender:self];
}
@end
