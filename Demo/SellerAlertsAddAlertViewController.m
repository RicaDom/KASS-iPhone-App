//
//  SellerAlertsAddAlertViewController.m
//  Demo
//
//  Created by Wesley Wang on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SellerAlertsAddAlertViewController.h"
#import "UIResponder+VariableStore.h"
#import "ListingMapAnnotaion.h"
#import "ListingImageAnnotationView.h"

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
  
    self.whatLabel.text = [VariableStore sharedInstance].currentAddAlert.isAll ? 
      TEXT_ALL_GOODS : [VariableStore sharedInstance].currentAddAlert.keyword;
    
    self.minPriceLabel.text = ([VariableStore sharedInstance].currentAddAlert.minPrice.length > 0) ? [VariableStore sharedInstance].currentAddAlert.minPrice : TEXT_ALL_PRICE;

    self.locationLabel.text = ([VariableStore sharedInstance].currentAddAlert.userSpecifyLocation.length > 0) ? [VariableStore sharedInstance].currentAddAlert.userSpecifyLocation : TEXT_YOUR_LOCATION;
    
    if ([VariableStore sharedInstance].currentAddAlert.radius.length <= 0) {
      [VariableStore sharedInstance].currentAddAlert.radius 
        = [[NSString alloc] initWithFormat:@"%d", DEFAULT_RADIUS];
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
   DLog(@"SellerAlertsAddAlertViewController::accountDidCreateAlert: %@", dict);
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)AddAlertAction:(id)sender {
    DLog(@"SellerAlertsAddAlertViewController::(IBAction)AddAlertAction: \n");
    NSString *latlng = [NSString stringWithFormat:@"%+.6f,%+.6f", 
                        VariableStore.sharedInstance.location.coordinate.latitude, 
                        VariableStore.sharedInstance.location.coordinate.longitude]; 
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
  
    NSString *query = [self.whatLabel.text isEqualToString:TEXT_ALL_GOODS] ? @"ALL" : self.whatLabel.text;
    
    [params setObject:@"" forKey:@"category_ids"];
    [params setObject:self.radiusLabel.text forKey:@"radius"];
    [params setObject:query forKey:@"query"];
    [params setObject:self.minPriceLabel.text forKey:@"min_price"];
  
    if([VariableStore sharedInstance].currentAddAlert.userSpecifyLocation.length > 0){
      [params setObject:self.locationLabel.text forKey:@"address"];
    }else{
      [params setObject:latlng forKey:@"latlng"];
    }
  
    [[VariableStore sharedInstance] clearCurrentAddAlert];
    DLog(@"SellerAlertsAddAlertViewController::addAlert:params = %@", params);
    
    [self.currentUser createAlert:params];
}

- (IBAction)leftButtonAction:(id)sender {
    [[VariableStore sharedInstance] clearCurrentAddAlert];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
