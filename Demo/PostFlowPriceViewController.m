//
//  PostFlowPriceViewController.m
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PostFlowPriceViewController.h"

@implementation PostFlowPriceViewController
@synthesize priceTextField = _priceTextField;
@synthesize postType = _postType;

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

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)loadCurrentPostingData
{
    if ([VariableStore sharedInstance].currentPostingItem.askPrice) {
        self.priceTextField.text = [NSString stringWithFormat:@"%@", [VariableStore sharedInstance].currentPostingItem.askPrice];
    }
}

- (void)saveCurrentPostingData
{
    [VariableStore sharedInstance].currentPostingItem.askPrice = [NSDecimalNumber decimalNumberWithString:self.priceTextField.text];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PostFlowPriceToSetDateView"]) {
        PostFlowSetDateViewController *pvc = segue.destinationViewController;
        pvc.postType = self.postType;
    } 
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadCurrentPostingData];
    [self.priceTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self saveCurrentPostingData];
}

- (void)viewDidUnload
{
    [self setPriceTextField:nil];
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
