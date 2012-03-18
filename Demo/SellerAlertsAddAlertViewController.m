//
//  SellerAlertsAddAlertViewController.m
//  Demo
//
//  Created by Wesley Wang on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SellerAlertsAddAlertViewController.h"
#import "UIResponder+VariableStore.h"

@implementation SellerAlertsAddAlertViewController

@synthesize leftButton = _leftButton;
@synthesize whatLabel = _whatLabel;
@synthesize minPriceLabel = _minPriceLabel;
@synthesize locationLabel = _locationLabel;
@synthesize radiusLabel = _radiusLabel;

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
    self.whatLabel.text = ([VariableStore sharedInstance].currentAddAlert.keyword.length > 0) ? [VariableStore sharedInstance].currentAddAlert.keyword : @"所有商品";
    self.minPriceLabel.text = ([VariableStore sharedInstance].currentAddAlert.minPrice.length > 0) ? [VariableStore sharedInstance].currentAddAlert.minPrice : @"没有最低价";

    self.locationLabel.text = ([VariableStore sharedInstance].currentAddAlert.userSpecifyLocation.length > 0) ? [VariableStore sharedInstance].currentAddAlert.userSpecifyLocation : @"Current location";
    
    if ([VariableStore sharedInstance].currentAddAlert.radius.length <= 0) {
        [VariableStore sharedInstance].currentAddAlert.radius = @"5";
    }
    self.radiusLabel.text = [VariableStore sharedInstance].currentAddAlert.radius;
}


- (void)locateMeFinished
{
    DLog(@"SellerAlertsAddAlertViewController::locateMeFinished ");
}

- (void)locateMe {
    VariableStore.sharedInstance.locateMeManager.delegate = self;
    [VariableStore.sharedInstance.locateMeManager locateMe];
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
    [self locateMe];
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

- (void)accountDidCreateAlert:(NSDictionary *)dict
{
    NSLog(@"Account: %@", dict);
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)AddAlertAction:(id)sender {
    DLog(@"SellerAlertsAddAlertViewController::(IBAction)AddAlertAction: \n");
    NSString *latlng = [NSString stringWithFormat:@"%+.6f,%+.6f", 
                        VariableStore.sharedInstance.location.coordinate.latitude, 
                        VariableStore.sharedInstance.location.coordinate.longitude]; 

    [[VariableStore sharedInstance] clearCurrentAddAlert];
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    
    [params setObject:@"" forKey:@"category_ids"];
    [params setObject:self.radiusLabel.text forKey:@"radius"];
    [params setObject:self.whatLabel.text forKey:@"query"];
    [params setObject:latlng forKey:@"latlng"];

    DLog(@"params = %@", params);
    
    [self.currentUser createAlert:params];
}
- (IBAction)leftButtonAction:(id)sender {
    [[VariableStore sharedInstance] clearCurrentAddAlert];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
