//
//  BaseHelper.m
//  Demo
//
//  Created by Qi He on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseHelper.h"

@implementation BaseHelper

+ (NSString *) getTimeFromNowText:(NSDate *)fromDate:(NSDate *)toDate
{
  NSTimeInterval diff = [ toDate timeIntervalSinceDate: fromDate];
  
  if (diff / 86400 > 1) {
    return [[NSString alloc] initWithFormat:@"%d天", (int)(diff / 86400)];
  } else if ( diff / 3600 > 1 ) {
    return [[NSString alloc] initWithFormat:@"%d小时", (int)(diff / 3600)];
  } else if ( diff / 60 > 1 ) {
    return [[NSString alloc] initWithFormat:@"%d分钟", (int)(diff / 60)];
  } else if ( diff > 0 ) {
    return [[NSString alloc] initWithFormat:@"少于1分钟"];
  } else {
    return nil;
  }
}

@end
