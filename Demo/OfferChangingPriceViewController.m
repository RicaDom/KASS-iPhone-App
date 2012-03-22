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
@synthesize confirmButton = _confirmButton;

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
  
    self.currentPrice = [NSString stringWithFormat:@"%d", VariableStore.sharedInstance.priceToModify];
  
    self.offerPriceTextField.placeholder = self.currentPrice;
    [self.offerPriceTextField becomeFirstResponder];

    [ViewHelper buildCancelButton:self.leftButton];
    [ViewHelper buildConfirmButton:self.confirmButton];
}


- (void)viewDidUnload
{
    [self setOfferPriceTextField:nil];
    [self setLeftButton:nil];
    [self setConfirmButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)leftButtonAction:(id)sender {
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

- (IBAction)confirmButtonAction:(id)sender {
    if (self.offerPriceTextField.text.length > 0) {
        [[NSNotificationCenter defaultCenter] 
         postNotificationName:CHANGED_PRICE_NOTIFICATION 
         object:self.offerPriceTextField.text];
    }
    
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}
@end
