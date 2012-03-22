//
//  SellerAlertsViewController.h
//  Demo
//
//  Created by Wesley Wang on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewHelper.h"

@interface SellerAlertsViewController : UIViewController <AccountActivityDelegate>{
  NSIndexPath *indexPathToDelete;
}
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UITableView *alertsTableView;
@property (strong, nonatomic) NSMutableArray *alerts;
@property (strong, nonatomic) IBOutlet UILabel *addAlertLabel;
@property (strong, nonatomic) IBOutlet UIView *alertTableFooter;

- (IBAction)leftButtonAction:(id)sender;
- (IBAction)rightButtonAction:(id)sender;
- (IBAction)AddAlertButtonAction:(id)sender;

@end
