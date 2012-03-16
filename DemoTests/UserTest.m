//
//  UserTest.m
//  Demo
//
//  Created by Qi He on 12-3-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserTest.h"
#import "NSData+Crypto.h"
#import "NSString+Crypto.h"

@implementation UserTest

// All code under test must be linked into the Unit Test bundle
- (void)testEncryption
{
  user = [[User alloc] init];
  
  NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 @"abc",@"apn_iphone_token",
                                 @"1",@"apn_user_id",
                                 @"AES",@"apn_signature_method",
                                 [NSString stringWithFormat:@"%.0f",[[NSDate date]timeIntervalSince1970]],@"apn_timestamp",nil];
	
	NSString* baseString = [user stringFromDictionary:params];
	NSString* keyString = [NSString stringWithFormat:@"%@",KassSecretToken];
  
  NSData              *plain = [baseString dataUsingEncoding: NSUTF8StringEncoding];
  NSData              *key = [NSData dataWithBytes: [[keyString sha256] bytes] length: kCCKeySizeAES128];
  NSData              *cipher = [plain aesEncryptedDataWithKey: key];
  NSString            *base64 = [cipher base64Encoding];
  
  DLog(@"UserTest::testEncryption:encodedData=%@", base64);
}

- (void)testEncryptionDeviceToken
{
  user = [[User alloc] init];
  
  NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 @"abc",@"device_token",nil];
	
	NSString* baseString = [user stringFromDictionary:params];
	NSString* keyString = [NSString stringWithFormat:@"%@",KassSecretToken];
  
  NSData              *plain = [baseString dataUsingEncoding: NSUTF8StringEncoding];
  NSData              *key = [NSData dataWithBytes: [[keyString sha256] bytes] length: kCCKeySizeAES128];
  NSData              *cipher = [plain aesEncryptedDataWithKey: key];
  NSString            *base64 = [cipher base64Encoding];
  
  DLog(@"UserTest::testEncryption:encodedData=%@", base64);
}

@end
