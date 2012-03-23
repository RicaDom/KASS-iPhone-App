//
//  ConfigViewController.h
//  kass
//
//  Created by Wesley Wang on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISwitch *pushNotificationSwitch;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
- (IBAction)leftButtonAction:(id)sender;
- (IBAction)pushNotificationAction:(id)sender;

@end
