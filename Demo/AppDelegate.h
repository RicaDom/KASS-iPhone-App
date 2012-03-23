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

@interface AppDelegate : UIResponder <UIApplicationDelegate, KassAppDelegate, AccountActivityDelegate>{
  UIBackgroundTaskIdentifier bgTask;
}

@property (strong, nonatomic) UIWindow *window;

@end
