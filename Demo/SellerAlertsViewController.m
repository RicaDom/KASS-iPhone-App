//
//  SellerAlertsViewController.m
//  Demo
//
//  Created by Wesley Wang on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SellerAlertsViewController.h"

@implementation SellerAlertsViewController
@synthesize rightButton = _rightButton;
@synthesize leftButton = _leftButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

- (void)customViewLoad
{
    // navigation bar background color
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:NAVIGATION_BAR_BACKGROUND_COLOR_RED green:NAVIGATION_BAR_BACKGROUND_COLOR_GREEN blue:NAVIGATION_BAR_BACKGROUND_COLOR_BLUE alpha:NAVIGATION_BAR_BACKGROUND_COLOR_ALPHA];
    [ViewHelper buildBackButton:self.leftButton];
    [ViewHelper buildEditButton:self.rightButton];
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customViewLoad];
}

- (void)viewDidUnload
{
    [self setLeftButton:nil];
    [self setRightButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
//	if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
//	{
//        return [self.filteredListContent count];
//    }
//	else
//	{
//        return [self.currentListings count];
//    }    
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([aTableView isEqual:self.searchDisplayController.searchResultsTableView]) {
//        static NSString *CellIdentifier = @"browseListingTableCell";
//        UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
//        
//        //set cell using data
//        cell.textLabel.text = ((ListItem *)[self.filteredListContent objectAtIndex:indexPath.row]).title;
//        //[cell buildCellByListItem:[self.currentListings objectAtIndex:indexPath.row]];
//        return cell;
//    } else {
//        static NSString *CellIdentifier = @"browseListingTableCell";
//        ListingTableCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        
//        if (cell == nil) {
//            cell = [[ListingTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        }
//        
//        //set cell using data
//        
//        [cell buildCellByListItem:[self.currentListings objectAtIndex:indexPath.row]];
//        return cell;        
//    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    int row = [indexPath row];
//    
//    // check table view  
//    ListItem *item = ([tableView isEqual:self.searchDisplayController.searchResultsTableView])?
//    [self.filteredListContent objectAtIndex:row]:[self.currentListings objectAtIndex:row];
//    
//    [self performSegueByModel:item];
    
}

- (IBAction)leftButtonAction:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)rightButtonAction:(id)sender {
}
@end
