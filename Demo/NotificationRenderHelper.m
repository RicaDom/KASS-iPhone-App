//
//  NotificationRenderHelper.m
//  kass
//
//  Created by Wesley Wang on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NotificationRenderHelper.h"
#import "ActivityViewController.h"
#import "ProvideViewController.h"
#import "UIViewController+SegueActiveModel.h"
#import "Constants.h"

@implementation NotificationRenderHelper

+(void) NotificationRender:(NSDictionary*)notification mainTabBarVC:(UITabBarController *)mainTabBarVC
{
    if (mainTabBarVC == nil || notification == nil) {
        // error
    } else {
        
        // Depending on the notification, go to different controller
        NSDictionary *params = [notification objectForKey:@"custom"];
        NSString *type = [params objectForKey:@"e"];
        NSString *offerDbId = [params objectForKey:@"i"];
        NSString *listItemDbId = [params objectForKey:@"l"];
        NSString *sellerOrBuyer = [params objectForKey:@"x"]; // seller - buyer
        NSDictionary *aps = [notification objectForKey:@"aps"];
        
        DLog(@"Notification type=%@, offerDbId=%@, listItemDbId=%@, sellerOrBuyer=%@", type, offerDbId, listItemDbId, sellerOrBuyer);        
        DLog(@"Root controller type %@", [mainTabBarVC class]);
        DLog(@"Main tab selected index %d", mainTabBarVC.selectedIndex);
        
        // buyer/seller new message, new offer
        if ([type isEqualToString:REMOTE_NOTIFICATION_NEW_MESSAGE] || [type isEqualToString:REMOTE_NOTIFICATION_NEW_OFFER]) {
            mainTabBarVC.selectedIndex = 0;
            UINavigationController *actNC = (UINavigationController *)mainTabBarVC.selectedViewController;
            ActivityViewController *activityVC = (ActivityViewController *)actNC.topViewController;            
            
            // Activity view controller to browse item view
            if ([sellerOrBuyer isEqualToString:@"seller"]) {
                NSMutableDictionary* offerIdDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:offerDbId, @"id", nil];
                NSMutableDictionary* offerDict = [NSMutableDictionary dictionaryWithObjectsAndKeys: offerIdDict, @"offer", nil];
                [activityVC performSegueWithModelJson:offerDict:@"ActSellingListToMessageBuyer":activityVC]; 
                
            } else { // Activity view controller to activity offer message view
                NSMutableDictionary* dbIdDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:listItemDbId, @"id", type, @"flag", offerDbId, @"offerId", nil];
                NSMutableDictionary* listItemDict = [NSMutableDictionary dictionaryWithObjectsAndKeys: dbIdDict, @"listItem", nil];            
                [activityVC performSegueWithModelJson:listItemDict:@"ActBuyingListToOffers":activityVC];        
            }
            
        } else if ([type isEqualToString:REMOTE_NOTIFICATION_NEW_LISTING]) {
            mainTabBarVC.selectedIndex = 2;
            UINavigationController *provideNC = (UINavigationController *)mainTabBarVC.selectedViewController;
            ProvideViewController *provideVC = (ProvideViewController *)provideNC.topViewController; 
            provideVC.remoteNotificationListingId = offerDbId;
          
          if ([provideNC isKindOfClass:ProvideViewController.class]) {
            [provideVC performSegueWithIdentifier:@"ProvideViewToBrowseTable" sender:provideVC];
          }   
        
        } else if ([type isEqualToString:REMOTE_NOTIFICATION_NEW_ACCEPTED]) {
            mainTabBarVC.selectedIndex = 0;
            UINavigationController *actNC = (UINavigationController *)mainTabBarVC.selectedViewController;
            ActivityViewController *activityVC = (ActivityViewController *)actNC.topViewController;   
            
            NSMutableDictionary* offerIdDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:offerDbId, @"id", nil];
            NSMutableDictionary* offerDict = [NSMutableDictionary dictionaryWithObjectsAndKeys: offerIdDict, @"offer", nil];
            [activityVC performSegueWithModelJson:offerDict:@"ActSellingListToMessageBuyer":activityVC]; 
            
        }
        NSString *alert = [aps objectForKey:@"alert"];
        [ViewHelper showAlert:UI_LABEL_ALERT:alert:self];     
    }
}

@end
