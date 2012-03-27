//
//  BaseHelper.m
//  Demo
//
//  Created by Qi He on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseHelper.h"
#import "WBConnect.h"
#import "NSData+Crypto.h"
#import "NSString+Crypto.h"
#import "NSString+ModelHelper.h"
#import "SFHFKeychainUtils.h"

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

+ (NSString *)stringFromDictionary:(NSDictionary*)info
{
  NSMutableArray* pairs = [NSMutableArray array];
	
	NSArray* keys = [info allKeys];
	keys = [keys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	for (NSString* key in keys) 
	{
		if( ([[info objectForKey:key] isKindOfClass:[NSString class]]) == FALSE)
			continue;
		
		[pairs addObject:[NSString stringWithFormat:@"%@=%@", key, [[info objectForKey:key]URLEncodedString]]];
	}
	
	return [pairs componentsJoinedByString:@"&"];
}

+ (NSString *)getKassEncrypted:(NSString *)baseString
{
  NSString* keyString = [NSString stringWithFormat:@"%@",KassSecretToken];

  NSData              *plain = [baseString dataUsingEncoding: NSUTF8StringEncoding];
  NSData              *key = [NSData dataWithBytes: [[keyString sha256] bytes] length: kCCKeySizeAES128];
  NSData              *cipher = [plain aesEncryptedDataWithKey: key];
  NSString            *base64 = [cipher base64Encoding];
  
  return base64;
}

+ (void)removeTaggedSubviews:(int)tag:(UIView *)sview
{
  for (UIView *subview in sview.subviews) {
    if (subview.tag == tag) {
      [subview removeFromSuperview];
    }
  }
}

@end
