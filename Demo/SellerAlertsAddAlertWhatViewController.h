//
//  SellerAlertsAddAlertWhatViewController.h
//  Demo
//
//  Created by Wesley Wang on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VariableStore.h"
#import "ViewHelper.h"

@interface SellerAlertsAddAlertWhatViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UITextField *keywordTextField;
@property (strong, nonatomic) IBOutlet UITableView *goodsTableView;
@property (strong, nonatomic) IBOutlet UITableView *serviceTableView;

- (IBAction)leftButtonAction:(id)sender;
- (IBAction)rightButtonAction:(id)sender;

@end
