//
//  AppDelegate.h
//  Demo
//
//  Created by zhicai on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KassAppDelegate.h"
#import "AccountActivityDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, KassAppDelegate, AccountActivityDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) UIWindow *window;

- (BOOL)isSingleTask;
- (void)parseURL:(NSURL *)url application:(UIApplication *)application;


@end
