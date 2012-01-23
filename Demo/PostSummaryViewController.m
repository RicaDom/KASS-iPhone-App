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
@synthesize postDueDate = _postDueDate;

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
    self.postTitle.text = [VariableStore sharedInstance].currentPostingItem.title;
    self.postDescription.text = [VariableStore sharedInstance].currentPostingItem.description;
    self.postAskPrice.text = [NSString stringWithFormat:@"%@", [VariableStore sharedInstance].currentPostingItem.askPrice];
    //self.postDueDate.text = 
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
    [self loadCurrentPostingData];
}

- (void)viewDidUnload
{
    [self setPostTitle:nil];
    [self setPostDescription:nil];
    [self setPostAskPrice:nil];
    [self setPostDueDate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
