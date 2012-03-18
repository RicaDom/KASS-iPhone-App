//
//  SellerAlertsAddAlertLocationViewController.h
//  Demo
//
//  Created by Wesley Wang on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewHelper.h"
#import "VariableStore.h"

@interface SellerAlertsAddAlertLocationViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *locationTextField;
@property (strong, nonatomic) IBOutlet UISlider *radiusSlider;
@property (strong, nonatomic) IBOutlet UILabel *radiusLabel;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;

- (IBAction)rightButtonAction:(id)sender;
- (IBAction)leftButtonAction:(id)sender;
- (IBAction)radiusValueChanged:(id)sender;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
