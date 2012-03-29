//
//  AboutViewController.m
//  kass
//
//  Created by Wesley Wang on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"
#import "ViewHelper.h"

@implementation AboutViewController

@synthesize aboutArray = _aboutArray;
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

- (void)loadTableData
{
    self.aboutArray = [NSArray arrayWithObjects:@"街区视频", @"如何玩转街区", @"街区A&Q", @"评价街区", @"关注街区微博", @"关于我们",nil] ;
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
    [self loadTableData];
    [ViewHelper buildBackButton:self.leftButton];
}

- (void)viewDidUnload
{
    [self setLeftButton:nil];
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
    return self.aboutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"AboutTableCell";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //set cell using data
    cell.textLabel.text = [self.aboutArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:DEFAULT_FONT size:14];
    return cell;     
}


#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    NSString *displayName = ((SettingTable *)[settingArray objectAtIndex:indexPath.row]).displayName;
////    if (![VariableStore sharedInstance].isLoggedIn && ([displayName isEqualToString:@"注册或登陆"] || [displayName isEqualToString:@"设置"])) {
////        [MTPopupWindow showWindowWithUIView:self.tabBarController.view];
////        return;
////    }
////    [self performSegueWithIdentifier:((SettingTable *)[settingArray objectAtIndex:indexPath.row]).segueName sender:self];
//}
- (IBAction)leftButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
