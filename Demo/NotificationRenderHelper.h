//
//  NotificationRenderHelper.h
//  kass
//
//  Created by Wesley Wang on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListItem.h"

@interface NotificationRenderHelper : NSObject

+(void) NotificationRender:(NSDictionary*)notification mainTabBarVC:(UITabBarController *)mainTabBarVC;
+(int) getUnreadCountFromListings:(NSMutableArray *)listings isBuyer:(BOOL)isBuyer;
+(BOOL) isUnreadListing:(ListItem *)listing isBuyer:(BOOL)isBuyer;

@end
