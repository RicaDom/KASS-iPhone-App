//
//  ProvideViewController.h
//  Demo
//
//  Created by Wesley Wang on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewHelper.h"

@interface ProvideViewController : UIViewController

@property (strong, nonatomic) NSString *remoteNotificationListingId;
@property (strong, nonatomic) IBOutlet UIButton *sellerAlertButton;
@property (strong, nonatomic) IBOutlet UIButton *browseButton;
@end
