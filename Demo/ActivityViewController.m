//
//  ActivityViewController.m
//  Demo
//
//  Created by zhicai on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ActivityViewController.h"


@implementation ActivityViewController
@synthesize emptyRecordsImageView = _emptyRecordsImageView;
@synthesize listingsTableView = _listingsTableView;

NSMutableArray *currentItems;

- (IBAction)activityChanged:(id)sender {
  [self reloadTable];
}

- (void) accountLoadData
{
  DLog(@"ActivityViewController::accountLoadData");
  [self setupArray];
}

- (void)reloadTable
{
  DLog(@"ActivityViewController::reloadTable");
  if ( 0 == activitySegment.selectedSegmentIndex) {
    currentItems = [VariableStore sharedInstance].myBuyingListings;
  } else {
    currentItems = [VariableStore sharedInstance].mySellingListings;
  }
  if (self.emptyRecordsImageView) {
    [self.emptyRecordsImageView removeFromSuperview];
    self.emptyRecordsImageView = nil;
  }
  
  [self.tableView reloadData];
}

- (void)getBuyingItems:(NSData *)data
{
  DLog(@"ActivityViewController::getBuyingItems");
  Listing *listing = [[Listing alloc] initWithData:data];
  [VariableStore sharedInstance].myBuyingListings = [listing listItems];
  [self reloadTable];
}


- (void)getSellingItems:(NSData *)data
{
  DLog(@"ActivityViewController::getSellingItems");
  Listing *listing = [[Listing alloc] initWithData:data];
  [VariableStore sharedInstance].mySellingListings = [listing listItems];
  [self reloadTable];
}

-(void)setupArray{
  // sample data
  KassApi *ka  = [[KassApi alloc]initWithPerformerAndAction:self:@"getBuyingItems:"];
  [ka getAccountListings];
  
  KassApi *ka2 = [[KassApi alloc]initWithPerformerAndAction:self:@"getSellingItems:"];
  [ka2 getAccountListings]; //TODO: this will change to get selling stuff
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
  
  self.navigationController.navigationBar.tintColor = [UIColor brownColor];  
  if ( ![VariableStore sharedInstance].user.delegate ) {
    [VariableStore sharedInstance].user.delegate = self;
  }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    activitySegment = nil;
    [self setEmptyRecordsImageView:nil];
    [self setListingsTableView:nil];
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
        [self accountLoadData];
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

// Reloading data
- (void)refresh {
    [self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
}

- (void)addItem {
    // TODO
    // Adding item to the list
    [self setupArray];
    [self stopLoading];
}

@end
