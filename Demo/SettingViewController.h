//
//  SettingViewController.h
//  Demo
//
//  Created by zhicai on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VariableStore.h"
#import "Constants.h"
#import "MTPopupWindow.h"
#import "AccountActivityDelegate.h"

@interface SettingViewController : UIViewController <AccountActivityDelegate>

@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *welcomeMessageLabel;

- (IBAction)rightButtonAction:(id)sender;

@end
