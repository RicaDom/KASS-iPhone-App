//
//  ProvideViewController.m
//  Demo
//
//  Created by Wesley Wang on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProvideViewController.h"
#import "BrowseTableViewController.h"

@implementation ProvideViewController
@synthesize sellerAlertButton = _sellerAlertButton;
@synthesize browseButton = _browseButton;
@synthesize remoteNotificationListingId = _remoteNotificationListingId;

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
    [ViewHelper buildProvideAlertButton:self.sellerAlertButton];
    [ViewHelper buildProvideBrowseButton:self.browseButton];
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
    [self setSellerAlertButton:nil];
    [self setBrowseButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// REMOTE_NOTIFICATION_NEW_LISTING

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ProvideViewToBrowseTable"]) {
        DLog(@"ProvideViewController::prepareForSegue:offerMessageSegue");
        BrowseTableViewController *bvc = [segue destinationViewController];
        bvc.remoteNotificationListingId = self.remoteNotificationListingId;
    } 
}
@end
