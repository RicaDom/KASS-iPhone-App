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
    
  [self reloadTable];
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

  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;];

}

- (void)viewDidUnload
{
    [self setBrowseSegment:nil];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"listCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    ListItem *item = [currentItems objectAtIndex:indexPath.row];
    NSString *price = [[item askPrice] stringValue];
    cell.textLabel.text = [[item title] stringByAppendingFormat:@" ¥%@", price];
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
}

- (IBAction)browseSegmentAction:(id)sender {
  [self reloadTable];
}
@end
