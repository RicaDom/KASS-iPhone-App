//
//  AppDelegate.m
//  Demo
//
//  Created by zhicai on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "NotificationRenderHelper.h"
#import "MTPopupWindow.h"
//#import "AlixPay.h"
//#import "AlixPayResult.h"
//#import "DataVerifier.h"
#import <sys/utsname.h>
#import "GANTracker.h"

@implementation AppDelegate

@synthesize window    = _window;

// Dispatch period in seconds
static const NSInteger kGANDispatchPeriodSec = 10;
static NSString* const kAnalyticsAccountId = @"UA-31469096-1";

- (BOOL)isSingleTask{
	struct utsname name;
	uname(&name);
	float version = [[UIDevice currentDevice].systemVersion floatValue];//判定系统版本。
	if (version < 4.0 || strstr(name.machine, "iPod1,1") != 0 || strstr(name.machine, "iPod2,1") != 0) {
		return YES;
	}
	else {
		return NO;
	}
}

- (void)parseURL:(NSURL *)url application:(UIApplication *)application {
  DLog(@"alipay will be added");
//	AlixPay *alixpay = [AlixPay shared];
//	AlixPayResult *result = [alixpay handleOpenURL:url];
//	if (result) {
//		//是否支付成功
//		if (9000 == result.statusCode) {
//			/*
//			 *用公钥验证签名
//			 */
//			id<DataVerifier> verifier = CreateRSADataVerifier([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA public key"]);
//			if ([verifier verifyString:result.resultString withSign:result.signString]) {
//				UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" 
//                                                             message:result.statusMessage 
//                                                            delegate:nil 
//                                                   cancelButtonTitle:@"确定" 
//                                                   otherButtonTitles:nil];
//				[alertView show];
//			}//验签错误
//			else {
//				UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" 
//                                                             message:@"签名错误" 
//                                                            delegate:nil 
//                                                   cancelButtonTitle:@"确定" 
//                                                   otherButtonTitles:nil];
//				[alertView show];
//			}
//		}
//		//如果支付失败,可以通过result.statusCode查询错误码
//		else {
//			UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" 
//                                                           message:result.statusMessage 
//                                                          delegate:nil 
//                                                 cancelButtonTitle:@"确定" 
//                                                 otherButtonTitles:nil];
//			[alertView show];
//		}
//		
//	}	
}

////////////////////////////////////// Helper Methods ///////////////////////////////////////////////

- (void)performByNotification:(NSDictionary *)notification
{
    [NotificationRenderHelper NotificationRender:notification mainTabBarVC:(UITabBarController *)self.window.rootViewController];
}

- (void)loadDataSource
{
  // WARNING - TODO
  if ([[VariableStore sharedInstance].remoteNotification count] > 0) {
    NSDictionary *copyDict = [NSDictionary dictionaryWithDictionary:[VariableStore sharedInstance].remoteNotification];
    [VariableStore sharedInstance].remoteNotification = nil;
    [self performByNotification:copyDict];
  }
}

- (void)settingsDidLoad:(NSDictionary *)dict
{
  DLog(@"AppDelegate::settingsDidLoad:dict=%@", dict);
  [VariableStore.sharedInstance storeSettings:dict];
}

- (void) accountLoginFinished
{
  DLog(@"AppDelegate::accountLoginFinished");
  [self loadDataSource];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
  if (alertView.tag == UPGRADE_ALERT_VIEW_TAG){
    [[UIApplication sharedApplication] 
     openURL:[NSURL URLWithString:@"http://www.jieqoo.com"]];
  } else if(alertView.tag == REMOTE_NOTIFICATION_ALERT_VIEW_TAG){
      if (buttonIndex == 1)
      {
          if ([VariableStore sharedInstance].isLoggedIn) {
              NSDictionary *copyDict = [NSDictionary dictionaryWithDictionary:[VariableStore sharedInstance].remoteNotification];
              [VariableStore sharedInstance].remoteNotification = nil;
              [self performByNotification:copyDict];
          } else {
              [MTPopupWindow showWindowWithUIView:self.window.rootViewController.view];
          }
      }
      else
      {
          [VariableStore sharedInstance].remoteNotification = nil;
      }
  }
}

- (void)setupGoogleAnalytics
{
  [[GANTracker sharedTracker] startTrackerWithAccountID:kAnalyticsAccountId
                                         dispatchPeriod:kGANDispatchPeriodSec
                                               delegate:nil];
  NSError *error;
  
  if (![[GANTracker sharedTracker] setCustomVariableAtIndex:1
                                                       name:@"iOS1"
                                                      value:@"iv1"
                                                  withError:&error]) {
    NSLog(@"error in setCustomVariableAtIndex");
  }
  
  if (![[GANTracker sharedTracker] trackEvent:@"Application iOS"
                                       action:@"Launch iOS"
                                        label:@"Example iOS"
                                        value:99
                                    withError:&error]) {
    NSLog(@"error in trackEvent");
  }
  
  if (![[GANTracker sharedTracker] trackPageview:@"/app_entry_point"
                                       withError:&error]) {
    NSLog(@"error in trackPageview");
  }

}

//////////////////////////////////// Application Life Cycle ///////////////////////////////////////////

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  DLog(@"AppDelegate::didFinishLaunchingWithOptions:rootViewController=%@,options=%@", self.window.rootViewController, launchOptions);
  VariableStore.sharedInstance.appDelegate = self;
  
  [self setupGoogleAnalytics];
  
  if (launchOptions != nil)
	{
    NSURL *url = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
    if(url) // the app was launched from a URL, so we might as well hand this off
    {
      return [self application:application handleOpenURL:url];
    }
    
		NSDictionary* dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
		if (dictionary != nil)
		{
			DLog(@"Launched from push notification: %@", dictionary);
            [self performByNotification:dictionary];
		}
	}
  
  [VariableStore.sharedInstance loadAndStoreSettings:self];
  DLog(@"AppDelegate::doneLoading");
  
  [VariableStore.sharedInstance loginIfPreviouslyLoggedIn];
  
	// Let the device know we want to receive push notifications
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:
   (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];

  [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
  
  if (VariableStore.sharedInstance.settings) {
    NSString* apv = [VariableStore.sharedInstance.settings.siteDict objectForKey:@"app_version"];
    float vs      = [apv floatValue];
    NSString*	version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    float vp      = [version floatValue];
    
    if (vp < vs) {
      [ViewHelper showAlertWithTag:@"版本过低" :@"您的应用软件需要升级":UPGRADE_ALERT_VIEW_TAG:self];
    }
  }
  
  return !!VariableStore.sharedInstance.settings;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
  //save the token, before that, we need to trim the spaces and get the correct token
  NSString *str = [[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""]; 
  
  str = [str stringByReplacingOccurrencesOfString:@">" withString:@""]; 
  str = [str stringByReplacingOccurrencesOfString: @" " withString: @""];
  
  DLog(@"AppDelegate::didRegisterForRemoteNotificationsWithDeviceToken:token=%@", str);
  [[NSUserDefaults standardUserDefaults] setValue:str forKey:KassAppIphoneTokenKey];    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	[[NSUserDefaults standardUserDefaults] setValue:@"dc348da7e9e52a6c632243f4a26c04e889b5ef59aab5e715e22923f5f9ae9510" forKey:KassAppIphoneTokenKey];    
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)notification
{
	NSLog(@"AppDelegate::didReceiveRemoteNotification: %@", notification);
    if ( application.applicationState == UIApplicationStateActive ) {
        NSDictionary *aps = [notification objectForKey:@"aps"];
        NSString *alert = [aps objectForKey:@"alert"];
        // [ViewHelper showAlert:UI_LABEL_ALERT:alert:self]; 
        
        // open a alert with an OK and cancel button
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:UI_LABEL_ALERT message:alert delegate:self cancelButtonTitle:UI_LABEL_DISMISS otherButtonTitles:UI_LABEL_VIEW, nil];
        alertView.tag = REMOTE_NOTIFICATION_ALERT_VIEW_TAG;
        [VariableStore sharedInstance].remoteNotification = notification;
        [alertView show];
        
    } else {
        if ([VariableStore sharedInstance].isLoggedIn) {
            [self performByNotification:notification];
        } else {
            [VariableStore sharedInstance].remoteNotification = notification;
            [MTPopupWindow showWindowWithUIView:self.window.rootViewController.view];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  DLog(@"AppDelegate::applicationWillEnterForeground");
  
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
  DLog(@"AppDelegate::handleOpenURL:url=%@,absoluteString=%@", url, url.absoluteString);
  
  if ( [url.absoluteString rangeOfString:@"://safepay/"].location != NSNotFound){
    [self parseURL:url application:application];
  }else {//callback?oauth_token=
    DLog(@"AppDelegate::openURL:weibo=%@", [VariableStore sharedInstance].user.weibo);
    return ( [[VariableStore sharedInstance].user.weibo handleOpenURL:url] );
  }
  
	return TRUE;
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//  //MainTabBarViewController *viewController = (MainTabBarViewController *) self.window.rootViewController;
//  DLog(@"AppDelegate::openURL:url=%@", url);
//  DLog(@"AppDelegate::openURL:weibo=%@", [VariableStore sharedInstance].user.weibo);
//  if( [[VariableStore sharedInstance].user.weibo handleOpenURL:url] )
//		return TRUE;
//	return TRUE;
//}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  DLog(@"AppDelegate::applicationDidBecomeActive");
  if ( !VariableStore.sharedInstance.settings || !VariableStore.sharedInstance.settings.siteDict) {
    [VariableStore.sharedInstance loadSettings:self];
  }

  if (VariableStore.sharedInstance.isLoggedIn ) {
    [VariableStore.sharedInstance getAuth];
  }else{
    [VariableStore.sharedInstance loginIfPreviouslyLoggedIn];
  }
}
//
//- (void)applicationWillTerminate:(UIApplication *)application
//{
//    /*
//     Called when the application is about to terminate.
//     Save data if appropriate.
//     See also applicationDidEnterBackground:.
//     */
//} 

@end
