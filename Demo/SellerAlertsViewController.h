//
//  SellerAlertsViewController.h
//  Demo
//
//  Created by Wesley Wang on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewHelper.h"

@interface SellerAlertsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
- (IBAction)leftButtonAction:(id)sender;
- (IBAction)rightButtonAction:(id)sender;

@end
