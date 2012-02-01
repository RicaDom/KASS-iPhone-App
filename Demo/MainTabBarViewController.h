//
//  MainTabBarViewController.h
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KassApi.h"

@interface MainTabBarViewController : UITabBarController <UIAlertViewDelegate, UITabBarControllerDelegate>

- (void)showMessage;
@end
