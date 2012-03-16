//
//  SellerAlertsAddAlertViewController.h
//  Demo
//
//  Created by Wesley Wang on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewHelper.h"
#import "VariableStore.h"

@interface SellerAlertsAddAlertViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UILabel *whatLabel;
@property (strong, nonatomic) IBOutlet UILabel *minPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *radiusLabel;

- (IBAction)AddAlertAction:(id)sender;
- (IBAction)leftButtonAction:(id)sender;
@end
