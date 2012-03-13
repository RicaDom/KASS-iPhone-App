//
//  OfferChangingPriceViewController.m
//  Demo
//
//  Created by zhicai on 1/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OfferChangingPriceViewController.h"
#import "VariableStore.h"

@implementation OfferChangingPriceViewController

@synthesize currentPrice = _currentPrice;
@synthesize leftButton = _leftButton;
@synthesize offerPriceTextField = _offerPriceTextField;

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

- (void)loadPrice
{
  
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor brownColor];
  
    self.currentPrice = [NSString stringWithFormat:@"%d", VariableStore.sharedInstance.priceToModify];
  
    self.offerPriceTextField.placeholder = self.currentPrice;
    [self.offerPriceTextField becomeFirstResponder];
    
    // navigation bar background color
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:NAVIGATION_BAR_BACKGROUND_COLOR_RED green:NAVIGATION_BAR_BACKGROUND_COLOR_GREEN blue:NAVIGATION_BAR_BACKGROUND_COLOR_BLUE alpha:NAVIGATION_BAR_BACKGROUND_COLOR_ALPHA];
    [ViewHelper buildCancelButton:self.leftButton];
}


- (void)viewDidUnload
{
    [self setOfferPriceTextField:nil];
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

- (IBAction)doneChangingPriceAction:(id)sender {
    if (self.offerPriceTextField.text.length > 0) {
        [[NSNotificationCenter defaultCenter] 
         postNotificationName:CHANGED_PRICE_NOTIFICATION 
         object:self.offerPriceTextField.text];
    }
    
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

- (IBAction)leftButtonAction:(id)sender {
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}
@end
