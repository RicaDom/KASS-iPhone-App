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
@synthesize goodsTableView;
@synthesize serviceTableView;

NSArray *alertKeyWordsService;
NSArray *alertKeyWordsGoods;

- (void)loadSamepleData
{
    DLog(@"SellerAlertsAddAlertWhatViewController::AlertKeywordsService: %@", [VariableStore sharedInstance].settings.alertKeywordsServiceArray);
    DLog(@"SellerAlertsAddAlertWhatViewController::AlertKeywordsService: %@", [VariableStore sharedInstance].settings.alertKeywordsGoodsArray);
    alertKeyWordsService = [VariableStore sharedInstance].settings.alertKeywordsServiceArray;
    alertKeyWordsGoods = [VariableStore sharedInstance].settings.alertKeywordsGoodsArray;
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
  
    self.keywordTextField.text = !VariableStore.sharedInstance.currentAddAlert.isAll ?VariableStore.sharedInstance.currentAddAlert.keyword : TEXT_ALL_GOODS;
  
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
    [self setGoodsTableView:nil];
    [self setServiceTableView:nil];
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
    return (tableView == self.serviceTableView)? alertKeyWordsService.count : alertKeyWordsGoods.count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (aTableView == self.serviceTableView) {
        static NSString *CellIdentifier = @"AddAlertServiceTableCell";
        cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = [alertKeyWordsService objectAtIndex:indexPath.row];
    } else {
        static NSString *CellIdentifier = @"AddAlertGoodsTableCell";
        cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];    
        }
        cell.textLabel.text = [alertKeyWordsGoods objectAtIndex:indexPath.row];
    }

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *keyword = (tableView == self.serviceTableView) ? [alertKeyWordsService objectAtIndex:indexPath.row] : [alertKeyWordsGoods objectAtIndex:indexPath.row]; 
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
