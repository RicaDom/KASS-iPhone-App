//
//  SellerAlertsAddAlertWhatViewController.m
//  Demo
//
//  Created by Wesley Wang on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SellerAlertsAddAlertWhatViewController.h"

@implementation SellerAlertsAddAlertWhatViewController
@synthesize leftButton;
@synthesize rightButton;
@synthesize keywordTextField;

NSArray *alertKeyWords;
- (void)loadSamepleData
{
    DLog(@"SellerAlertsAddAlertWhatViewController::AlertKeywords: %@", [VariableStore sharedInstance].settings.alertKeywordsArray);
    alertKeyWords = [VariableStore sharedInstance].settings.alertKeywordsArray;
}

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
    [ViewHelper buildCancelButton:self.leftButton];
    [ViewHelper buildConfirmButton:self.rightButton];
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
    [self setKeywordTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadSamepleData];
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
    return [alertKeyWords count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if ([aTableView isEqual:self.searchDisplayController.searchResultsTableView]) {
            static NSString *CellIdentifier = @"AddAlertWhatTableCell";
            UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
    //        //set cell using data
    //        cell.textLabel.text = ((ListItem *)[self.filteredListContent objectAtIndex:indexPath.row]).title;
    //        //[cell buildCellByListItem:[self.currentListings objectAtIndex:indexPath.row]];
            cell.textLabel.text = [alertKeyWords objectAtIndex:indexPath.row];
            return cell;
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
    NSString *keyword = [alertKeyWords objectAtIndex:indexPath.row]; 
    if (keyword.length > 0) {
        [VariableStore sharedInstance].currentAddAlert.keyword = keyword;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)leftButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)rightButtonAction:(id)sender {
    if (self.keywordTextField.text.length > 0) {
        [VariableStore sharedInstance].currentAddAlert.keyword = self.keywordTextField.text;
    }

    [self.navigationController popViewControllerAnimated:YES];
}
@end
