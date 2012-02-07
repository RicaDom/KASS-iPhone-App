//
//  User.m
//  Demo
//
//  Created by zhicai on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"
#import "NSData+Crypto.h"
#import "NSString+Crypto.h"
#import "SFHFKeychainUtils.h"

@implementation User

@synthesize weibo, account;

@synthesize userId = _userId;
@synthesize name = _name;
@synthesize email = _email;
@synthesize phone = _phone;


- (void) accountLogin:(NSString *)email:(NSString *)password
{
  if (account) {account = nil; }
  account = [[Account alloc]initWithEmailAndPassword:email:password];
  account.delegate = self;
  DLog(@"User::accountLogin:account=%@", account);
  [account login];
}

- (void) accountWeiboLogin:(NSString *)encode
{
  if (account) {account = nil; }
  account = [[Account alloc]initWithWeiboEncodedData:encode];
  account.delegate = self;
  DLog(@"User::accountWeiboLogin:account=%@", account);
  [account login];
}

- (void) accountDidLogin
{
  DLog(@"User::accountDidLogin:username=%@", account.userName);

  _userId = account.userDbId;
  _name   = account.userName;
  _email  = account.email;
  _phone  = account.phone;
  
}

- (void) weiboLogin
{
  if( weibo ) { weibo = nil; }
  
  weibo = [[WeiBo alloc]initWithAppKey:SinaWeiBoSDKDemo_APPKey 
                         withAppSecret:SinaWeiBoSDKDemo_APPSecret];
  
  weibo.delegate = self;
  
  DLog(@"User::weiboLogin:weibo=%@", weibo);
  [weibo startAuthorize];
}

- (NSString*)stringFromDictionary:(NSDictionary*)info
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

- (void)weiboDidLogin
{
	DLog(@"User::weiboDidLogin:userID=%@", [weibo userID]);
	DLog(@"User::weiboDidLogin:Token=%@", [weibo accessToken]);
	DLog(@"User::weiboDidLogin:Secret=%@", [weibo accessTokenSecret]);
  // User logins in using weibo successfully
  
  NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 [weibo accessToken],@"oauth_access_token",
                                 [weibo accessTokenSecret],@"oauth_access_token_secret",
                                 [weibo userID],@"oauth_customer_id",
                                 @"AES",@"oauth_signature_method",
                                 [NSString stringWithFormat:@"%.0f",[[NSDate date]timeIntervalSince1970]],@"oauth_timestamp",nil];
	
	
	NSString* baseString = [self stringFromDictionary:params];
	NSString* keyString = [NSString stringWithFormat:@"%@&%@",[SinaWeiBoSDKDemo_APPKey URLEncodedString],[SinaWeiBoSDKDemo_APPSecret URLEncodedString]];
  
  //DLog(@"keyString=%@", keyString);
  
  NSData              *plain = [baseString dataUsingEncoding: NSUTF8StringEncoding];
  NSData              *key = [NSData dataWithBytes: [[keyString sha256] bytes] length: kCCKeySizeAES128];
  NSData              *cipher = [plain aesEncryptedDataWithKey: key];
  NSString            *base64 = [cipher base64Encoding];
  
  //DLog(@"Base 64 encoded = %@",base64);
  //[SFHFKeychainUtils storeUsername:[weibo userID] andPassword: forServiceName:KassServiceName updateExisting:YES error:nil];
  [self accountWeiboLogin:base64];
}

- (void)weiboLoginFailed:(BOOL)userCancelled withError:(NSError*)error
{
	DLog(@"User::weiboLoginFailed");
}


@end
