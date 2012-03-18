//
//  SellerAlertsListingsViewController.h
//  kass
//
//  Created by Wesley Wang on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellerAlertsListingsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *noListingsMessage;
@property(strong, nonatomic) NSString *alertId;
@property(strong, nonatomic) NSString *query;
@property(strong, nonatomic) NSMutableArray *alertListings;
@property (strong, nonatomic) IBOutlet UITableView *alertListingsTableView;

@end
