//
//  PostSummaryViewController.m
//  Demo
//
//  Created by zhicai on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PostSummaryViewController.h"

@implementation PostSummaryViewController
@synthesize postTitle = _postTitle;
@synthesize postDescription = _postDescription;
@synthesize postAskPrice = _postAskPrice;
@synthesize postDuration = _postDuration;

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


- (void)loadCurrentPostingData
{
  DLog(@"PostSummaryViewController::loadCurrentPostingData");
    self.postTitle.text = [VariableStore sharedInstance].currentPostingItem.title;
    self.postDescription.text = [VariableStore sharedInstance].currentPostingItem.description;
    self.postAskPrice.text = [NSString stringWithFormat:@"%@", [VariableStore sharedInstance].currentPostingItem.askPrice];

    if ([VariableStore sharedInstance].currentPostingItem.postDuration) {
        NSArray *keys = [[VariableStore sharedInstance].expiredTime 
                         allKeysForObject:[VariableStore sharedInstance].currentPostingItem.postDuration];
        if (keys) {
            NSString *selectedItem = [keys objectAtIndex:0];
            if ([selectedItem length] != 0) {
                self.postDuration.text = selectedItem;
            } else {
                self.postDuration.text = nil;
            }
        }
    }
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)locateMeFinished
{
  DLog(@"PostSummaryViewController::locateMeFinished ");
  [self loadCurrentPostingData];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  DLog(@"PostSummaryViewController::viewDidLoad ");
  [super viewDidLoad];
  VariableStore.sharedInstance.locateMeManager.delegate = self;
  [VariableStore.sharedInstance.locateMeManager locateMe];
}

- (void)viewDidUnload
{
    [self setPostTitle:nil];
    [self setPostDescription:nil];
    [self setPostAskPrice:nil];
    [self setPostDuration:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadCurrentPostingData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancelAction:(id)sender {
    [[VariableStore sharedInstance] clearCurrentPostingItem];
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

- (void)accountDidCreateListing:(NSDictionary *)dict
{
  DLog(@"PostSummaryViewController::accountDidCreateListing:dict=%@", dict);
}

- (IBAction)submitAction {
  DLog(@"PostSummaryViewController::(IBAction)submitAction:postingItem: \n");
  NSString *latlng = [NSString stringWithFormat:@"%+.6f,%+.6f", 
                      VariableStore.sharedInstance.location.coordinate.latitude, 
                      VariableStore.sharedInstance.location.coordinate.longitude]; 
  
  DLog(@"title=%@", [VariableStore sharedInstance].currentPostingItem.title);
  DLog(@"description=%@", [VariableStore sharedInstance].currentPostingItem.description);
  DLog(@"price=%@", [VariableStore sharedInstance].currentPostingItem.askPrice);
  DLog(@"duration=%@", [VariableStore sharedInstance].currentPostingItem.postDuration);
  DLog(@"latlng=%@", latlng);
  
  NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 [VariableStore sharedInstance].currentPostingItem.title, @"title",
                                 [VariableStore sharedInstance].currentPostingItem.description, @"description",
                                 [VariableStore sharedInstance].currentPostingItem.askPrice, @"price",
                                 [VariableStore sharedInstance].currentPostingItem.postDuration, @"time",
                                 latlng, @"latlng",nil];
  
  // submit listing
  [VariableStore.sharedInstance.user createListing:params];
  
  
    [[VariableStore sharedInstance].allListings addObject:[VariableStore sharedInstance].currentPostingItem];
    [[VariableStore sharedInstance] clearCurrentPostingItem];
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

@end
