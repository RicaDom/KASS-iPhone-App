//
//  BaseHelper.h
//  Demo
//
//  Created by Qi He on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface BaseHelper : NSObject

+ (NSString *) getTimeFromNowText:(NSDate *)fromDate:(NSDate *)toDate;
+ (NSString*)stringFromDictionary:(NSDictionary*)info;
+ (NSString *)getKassEncrypted:(NSString *)str;
+ (void)removeTaggedSubviews:(int)tag:(UIView *)sview;

@end
