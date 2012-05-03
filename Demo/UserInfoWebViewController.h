//
//  UserInfoWebViewController.h
//  kass
//
//  Created by zhicai on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserSNSInfo.h"
#import "UIViewController+ActivityIndicate.h"

@interface UserInfoWebViewController : UIViewController

@property (strong, nonatomic) UserSNSInfo *userSNSInfo;
@property (strong, nonatomic) IBOutlet UIWebView *userInfoWebView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *goBackButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *stopButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (strong, nonatomic) IBOutlet UIButton *leftNavigationButton;
@property (strong, nonatomic) IBOutlet UIToolbar *webNavToolBar;
- (IBAction)leftNavigationButtonAction:(id)sender;
@end
