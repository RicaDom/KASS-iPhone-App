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
#import "SFHFKeychainUtils.h"
#import "WBConnect.h"

@interface SettingViewController : UIViewController<WBSessionDelegate,WBSendViewDelegate,WBRequestDelegate>{
  WeiBo* weibo;
}
@property (nonatomic,assign,readonly) WeiBo* weibo;

@property (weak, nonatomic) IBOutlet UILabel *welcomeMessageLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *authButton;
- (IBAction)authButtonAction:(id)sender;

- (void)login;
- (void)accountDidLogin:(NSData *)data;

@end
