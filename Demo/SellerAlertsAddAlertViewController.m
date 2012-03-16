//
//  SellerAlertsAddAlertViewController.m
//  Demo
//
//  Created by Wesley Wang on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SellerAlertsAddAlertViewController.h"

@implementation SellerAlertsAddAlertViewController
@synthesize leftButton;
@synthesize whatLabel;
@synthesize minPriceLabel;
@synthesize locationLabel;
@synthesize radiusLabel;

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
    self.whatLabel.text = [VariableStore sharedInstance].currentAddAlert.keyword;
    self.minPriceLabel.text = [VariableStore sharedInstance].currentAddAlert.minPrice;
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
}

- (void)viewDidUnload
{
    [self setLeftButton:nil];
    [self setWhatLabel:nil];
    [self setMinPriceLabel:nil];
    [self setLocationLabel:nil];
    [self setRadiusLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self customViewLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)AddAlertAction:(id)sender {
    [[VariableStore sharedInstance] clearCurrentAddAlert];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)leftButtonAction:(id)sender {
    [[VariableStore sharedInstance] clearCurrentAddAlert];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
