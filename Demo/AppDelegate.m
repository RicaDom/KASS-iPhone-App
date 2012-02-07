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

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  DLog(@"AppDelegate::didFinishLaunchingWithOptions:rootViewController=%@", self.window.rootViewController);
  // Globally set segment and bar button color;
  //[[UISegmentedControl appearance] setTintColor:[UIColor orangeColor]];
  //[[UIBarButtonItem appearance] setTintColor:[UIColor orangeColor]];
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
  MainTabBarViewController *viewController = (MainTabBarViewController *) self.window.rootViewController;
  DLog(@"AppDelegate::handleOpenURL:url=%@", url);
	DLog(@"AppDelegate::handleOpenURL:rootViewController=%@", viewController);
  DLog(@"AppDelegate::openURL:weibo=%@", viewController.weibo);
  if( [viewController.weibo handleOpenURL:url] )
		return TRUE;
	return TRUE;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
  MainTabBarViewController *viewController = (MainTabBarViewController *) self.window.rootViewController;
  DLog(@"AppDelegate::openURL:url=%@", url);
	DLog(@"AppDelegate::openURL:rootViewController=%@", viewController);
  DLog(@"AppDelegate::openURL:weibo=%@", viewController.weibo);
  if( [viewController.weibo handleOpenURL:url] )
		return TRUE;
	return TRUE;
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
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
