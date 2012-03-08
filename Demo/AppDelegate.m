//
//  AppDelegate.m
//  Demo
//
//  Created by zhicai on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"

@implementation AppDelegate

@synthesize window    = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  DLog(@"AppDelegate::didFinishLaunchingWithOptions:rootViewController=%@", self.window.rootViewController);
  [VariableStore.sharedInstance loadAndStoreSettings:self];
  DLog(@"AppDelegate::doneLoading");
  
	// Let the device know we want to receive push notifications
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:
   (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
  
  return YES;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
  //save the token, before that, we need to trim the spaces and get the correct token
  NSString *str = [[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""]; 
  
  str = [str stringByReplacingOccurrencesOfString:@">" withString:@""]; 
  str = [str stringByReplacingOccurrencesOfString: @" " withString: @""];
  
  [[NSUserDefaults standardUserDefaults] setValue:str forKey:KassAppIphoneTokenKey];    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	[[NSUserDefaults standardUserDefaults] setValue:@"fake_device_token" forKey:KassAppIphoneTokenKey];    
}

- (void)settingsDidLoad:(NSDictionary *)dict
{
  DLog(@"AppDelegate::settingsDidLoad:dict");
  [VariableStore.sharedInstance storeSettings:dict];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  DLog(@"AppDelegate::applicationWillResignActive");
  
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  DLog(@"AppDelegate::applicationDidEnterBackground");
  bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
    // Clean up any unfinished task business by marking where you.
    // stopped or ending the task outright.
    [application endBackgroundTask:bgTask];
    bgTask = UIBackgroundTaskInvalid;
  }];
  
  // Start the long-running task and return immediately.
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    // Do the work associated with the task, preferably in chunks.
    
    [application endBackgroundTask:bgTask];
    bgTask = UIBackgroundTaskInvalid;
  });
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  DLog(@"AppDelegate::applicationWillEnterForeground");
  
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
  DLog(@"AppDelegate::handleOpenURL:url=%@", url);
  DLog(@"AppDelegate::openURL:weibo=%@", [VariableStore sharedInstance].user.weibo);
  if( [[VariableStore sharedInstance].user.weibo handleOpenURL:url] )
		return TRUE;
	return TRUE;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
  //MainTabBarViewController *viewController = (MainTabBarViewController *) self.window.rootViewController;
  DLog(@"AppDelegate::openURL:url=%@", url);
  DLog(@"AppDelegate::openURL:weibo=%@", [VariableStore sharedInstance].user.weibo);
  if( [[VariableStore sharedInstance].user.weibo handleOpenURL:url] )
		return TRUE;
	return TRUE;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  DLog(@"AppDelegate::applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
} 

@end
