//
//  MainTabBarViewController.h
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VariableStore.h"
#import "KassApi.h"
#import "WBConnect.h"

@interface MainTabBarViewController : UITabBarController <UIAlertViewDelegate, UITabBarControllerDelegate, WBSessionDelegate,WBSendViewDelegate,WBRequestDelegate>{
  WeiBo *weibo;
}

@property (nonatomic,retain,readonly) WeiBo* weibo;

- (void)showMessage;
- (void) weiboLogin;

@end
