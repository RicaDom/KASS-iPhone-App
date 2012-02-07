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

@interface SettingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *welcomeMessageLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *authButton;
- (IBAction)authButtonAction:(id)sender;

@end
