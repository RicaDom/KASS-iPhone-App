//
//  MainTabBarViewController.h
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ActivityIndicate.h"
#import "VariableStore.h"
#import "ActivityViewController.h"
#import "CustomImageViewPopup.h"

@interface MainTabBarViewController : UITabBarController <UIAlertViewDelegate, UITabBarControllerDelegate>{
  UITapGestureRecognizer *singleFingerTap;
  BOOL alreadyShowedIntro;
}

@end
