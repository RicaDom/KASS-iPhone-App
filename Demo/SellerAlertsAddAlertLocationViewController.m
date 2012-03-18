//
//  SellerAlertsAddAlertLocationViewController.m
//  Demo
//
//  Created by Wesley Wang on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SellerAlertsAddAlertLocationViewController.h"

@implementation SellerAlertsAddAlertLocationViewController
@synthesize locationTextField;
@synthesize radiusSlider;
@synthesize radiusLabel;
@synthesize leftButton;
@synthesize rightButton;
@synthesize mapView = _mapView;

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
    self.radiusLabel.text = [NSString stringWithFormat:@"%.0f", self.radiusSlider.value]; 
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  if (VariableStore.sharedInstance.location) {
    [ViewHelper buildMap:_mapView:VariableStore.sharedInstance.location];
  }
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customViewLoad];
}

- (void)viewDidUnload
{
    [self setLocationTextField:nil];
    [self setRadiusSlider:nil];
    [self setRadiusLabel:nil];
    [self setLeftButton:nil];
    [self setRightButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)rightButtonAction:(id)sender {
    if (self.locationTextField.text.length > 0) {
        [VariableStore sharedInstance].currentAddAlert.userSpecifyLocation = self.locationTextField.text;
    }
    
    [VariableStore sharedInstance].currentAddAlert.radius = self.radiusLabel.text;
    DLog(@"This is the radius: %@", [VariableStore sharedInstance].currentAddAlert.radius);
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)leftButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)radiusValueChanged:(id)sender {
    self.radiusLabel.text = [NSString stringWithFormat:@"%.0f", self.radiusSlider.value]; 
}
@end
