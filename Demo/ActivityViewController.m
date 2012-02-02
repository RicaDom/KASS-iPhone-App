//
//  ActivityViewController.m
//  Demo
//
//  Created by zhicai on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ActivityViewController.h"


@implementation ActivityViewController

NSMutableArray *buyingItems, *sellingItems, *currentItems;

- (IBAction)activityChanged:(id)sender {
  [self reloadTable];
}

- (void)reloadTable
{
  if ( 0 == activitySegment.selectedSegmentIndex) {
    currentItems = buyingItems;
  } else {
    currentItems = sellingItems;
  }
  [self.tableView reloadData];
  DLog(@"ActivityViewController::reloadTable");
}

- (void)perform:(NSData *)data:(NSString *)method
{
  DLog(@"ActivityViewController::perform");
  SEL theSelector = NSSelectorFromString(method);
  if ([self respondsToSelector:theSelector]) 
  {
    DLog(@"ActivityViewController::perform:%@", method);
    [self performSelector:theSelector withObject:data];
  }
}

- (void)getBuyingItems:(NSData *)data
{
  DLog(@"ActivityViewController::getBuyingItems");
  Listing *listing = [[Listing alloc] initWithData:data];
  buyingItems = [listing listItems];
  [self reloadTable];
}

- (void)startStandardUpdates
{
  DLog(@"ActivityViewController::startStandardUpdates");
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

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
  DLog(@"ActivityViewController::didUpdateToLocation");
  // If it's a relatively recent event, turn off updates to save power
  NSDate* eventDate = newLocation.timestamp;
  NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
  if (abs(howRecent) < 15.0 )
  {
    DLog(@"ActivityViewController::latitude %+.6f, longitude %+.6f\n",
         newLocation.coordinate.latitude,
         newLocation.coordinate.longitude);
    [self setupArray];
  }
  // else skip the event and process the next one.
}

-(void)setupArray{
    
  // buying items

  // sample data
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getBuyingItems:"];
  NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"33.7715308509767,-118.31375383287669,34.17153085097671,-117.9137538328766", @"box",
                               nil];
  [ka getListings:dictionary];
  
  
  ListItem *item = [ListItem new];
  // selling items
  sellingItems = [NSMutableArray new];

  item = [ListItem new];
  [item setTitle:@"gently used kindle"];
  [item setDescription:@"good condition with wifi"];
  item.askPrice = [NSDecimalNumber decimalNumberWithDecimal:
                   [[NSNumber numberWithFloat:89.75f] decimalValue]];
  
  [sellingItems addObject:item];
  
  item = [ListItem new];
  [item setTitle:@"games for ps3"];
  [item setDescription:@"any shooting games"];
  item.askPrice = [NSDecimalNumber decimalNumberWithDecimal:
                   [[NSNumber numberWithFloat:18.55f] decimalValue]];
  
  [sellingItems addObject:item];
  
  if ( 0 == activitySegment.selectedSegmentIndex) {
      currentItems = buyingItems;
  } else {
      currentItems = sellingItems;
  }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowItem"]) {
        ItemViewController *ivc = [segue destinationViewController];
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        int row = [path row];
        ListItem *item = [currentItems objectAtIndex:row];
        ivc.currentItem = item;
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
  
  [self startStandardUpdates];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    activitySegment = nil;
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
    static NSString *CellIdentifier = @"activityCell";
    
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

@end
