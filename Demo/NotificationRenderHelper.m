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
        // NSDictionary *aps = [notification objectForKey:@"aps"];
        
        DLog(@"Notification type=%@, offerDbId=%@, listItemDbId=%@, sellerOrBuyer=%@", type, offerDbId, listItemDbId, sellerOrBuyer);        
        DLog(@"Root controller type %@", [mainTabBarVC class]);
        DLog(@"Main tab selected index %d", mainTabBarVC.selectedIndex);
        
        // buyer/seller new message, new offer
        if ([type isEqualToString:REMOTE_NOTIFICATION_NEW_MESSAGE] || [type isEqualToString:REMOTE_NOTIFICATION_NEW_OFFER]) {
            [ViewHelper setMainTabBarSelected:mainTabBarVC selectedIndex:0 lastSelectedIndex:mainTabBarVC.selectedIndex isHightImage:NO];
            //mainTabBarVC.selectedIndex = 0;
            UINavigationController *actNC = (UINavigationController *)mainTabBarVC.selectedViewController;
            ActivityViewController *activityVC = (ActivityViewController *)actNC.topViewController;            
            
          if ([activityVC isKindOfClass:ActivityViewController.class]) {
            
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
          }
            
        } else if ([type isEqualToString:REMOTE_NOTIFICATION_NEW_LISTING]) {
            [ViewHelper setMainTabBarSelected:mainTabBarVC selectedIndex:2 lastSelectedIndex:mainTabBarVC.selectedIndex isHightImage:YES];
            // mainTabBarVC.selectedIndex = 2;
            
            UINavigationController *provideNC = (UINavigationController *)mainTabBarVC.selectedViewController;
            ProvideViewController *provideVC = (ProvideViewController *)provideNC.topViewController; 
            provideVC.remoteNotificationListingId = offerDbId;
          
            if ([provideVC isKindOfClass:ProvideViewController.class]) {
                [provideVC performSegueWithIdentifier:@"ProvideViewToBrowseTable" sender:provideVC];
            }   
        
        } else if ([type isEqualToString:REMOTE_NOTIFICATION_NEW_ACCEPTED]) {
            [ViewHelper setMainTabBarSelected:mainTabBarVC selectedIndex:0 lastSelectedIndex:mainTabBarVC.selectedIndex isHightImage:NO];
            // mainTabBarVC.selectedIndex = 0;
            UINavigationController *actNC = (UINavigationController *)mainTabBarVC.selectedViewController;
            ActivityViewController *activityVC = (ActivityViewController *)actNC.topViewController;   
            
            NSMutableDictionary* offerIdDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:offerDbId, @"id", nil];
            NSMutableDictionary* offerDict = [NSMutableDictionary dictionaryWithObjectsAndKeys: offerIdDict, @"offer", nil];
          
          if ([activityVC isKindOfClass:ActivityViewController.class]) {
            [activityVC performSegueWithModelJson:offerDict:@"ActSellingListToMessageBuyer":activityVC]; 
          }
        }    
    }
}

+(BOOL) isUnreadListing:(ListItem *)listing isBuyer:(BOOL)isBuyer {
    if (listing == nil) {
        return NO;
    }
    
    NSMutableArray *offers = listing.offers;
    if ([offers count] > 0) {
        for (Offer *offer in offers) {
            if ((isBuyer ? [offer.receiverUnreadMessagesCount intValue] : [offer.ownerUnreadMessagesCount intValue]) > 0) {
                return YES;
            }
        }
    }
    return NO;
}

+(int) getUnreadCountFromListings:(NSMutableArray *)listings isBuyer:(BOOL)isBuyer {
    if ([listings count] <= 0) {
        return 0;
    }
    
    int count = 0;
    for (id listing in listings) {
        if ([listing isKindOfClass:[ListItem class]]) {
            ListItem *item = (ListItem *) listing;
            
            NSMutableArray *offers = item.offers;
            DLog(@"Offer count... %d", [offers count]);
            if ([offers count] > 0) {
                for (Offer *offer in offers) {
                    DLog(@"receiverUnreadMessagesCount string: %@", offer.receiverUnreadMessagesCount);
                    DLog(@"ownerUnreadMessagesCount string: %@", offer.ownerUnreadMessagesCount);

                    if ((isBuyer ? [offer.receiverUnreadMessagesCount intValue] : [offer.ownerUnreadMessagesCount intValue]) > 0) {
                        count++;
                    }
                    
                }
            }
        } else if ([listing isKindOfClass:[Offer class]]) {
            Offer *offer = (Offer *) listing;
            if ((isBuyer ? [offer.receiverUnreadMessagesCount intValue] : [offer.ownerUnreadMessagesCount intValue]) > 0) {
                count++;
            }
        }
    }
    return count;
}

@end
