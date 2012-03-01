//
//  ListItem+ListItemHelper.h
//  Demo
//
//  Created by Qi He on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ListItem.h"

@interface ListItem (ListItemHelper)


- (NSString *) getTimeLeftText;
- (NSString *) getTimeLeftTextlong;
- (NSString *) getDistanceFromLocationText:(CLLocation *)loc;
- (NSString *) getTimeFromNowText:(NSDate *)fromDate:(NSDate *)toDate;

@end
