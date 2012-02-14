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

@synthesize weibo, account, delegate = _delegate;

@synthesize userId = _userId;
@synthesize name = _name;
@synthesize email = _email;
@synthesize phone = _phone;

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

- (void)createListingFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::createListingFinished:dict%@", dict);
  
  if( [_delegate respondsToSelector:@selector(accountDidCreateListing:)] )
    [_delegate accountDidCreateListing:dict];
}

- (void)createListing:(NSDictionary *)dict
{
  DLog(@"User::createListing:dict=%@", dict);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"createListingFinished:"];
  [ka createListing:dict];
}

- (void) accountLogin:(NSString *)email:(NSString *)password
{
  if (account) {account = nil; }
  account = [[Account alloc]initWithEmailAndPassword:email:password];
  account.delegate = self;
  DLog(@"User::accountLogin:account=%@", account);
  [account login];
}

- (void) accountWeiboLoginRequest:(NSString *)encode
{
  if (account) {account = nil; }
  account = [[Account alloc]initWithWeiboEncodedData:encode];
  account.delegate = self;
  DLog(@"User::accountWeiboLogin:account=%@", account);
  [account login];
}

- (void) accountWeiboLogin:(NSDictionary*)userInfo
{
  NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 [userInfo objectForKey:@"screen_name"], @"name",
                                 [userInfo objectForKey:@"profile_image_url"], @"image",
                                 [userInfo objectForKey:@"id"], @"uid",
                                 [userInfo objectForKey:@"location"], @"location",
                                 [userInfo objectForKey:@"name"], @"real_name",
                                 [userInfo objectForKey:@"gender"], @"gender",
                                 [userInfo objectForKey:@"description"], @"description", 
                                 [weibo accessToken],@"oauth_access_token",
                                 [weibo accessTokenSecret],@"oauth_access_token_secret",
                                 [weibo userID],@"oauth_customer_id",
                                 @"AES",@"oauth_signature_method",
                                 [NSString stringWithFormat:@"%.0f",[[NSDate date]timeIntervalSince1970]],@"oauth_timestamp",nil];
	
	DLog(@"account weibo %@", params);
	NSString* baseString = [self stringFromDictionary:params];
    DLog(@"account baseString %@", baseString);
	NSString* keyString = [NSString stringWithFormat:@"%@&%@",[SinaWeiBoSDKDemo_APPKey URLEncodedString],[SinaWeiBoSDKDemo_APPSecret URLEncodedString]];
    DLog(@"account keyString %@", keyString);
//  DLog(@"baseString=%@", baseString);
  
  NSData              *plain = [baseString dataUsingEncoding: NSUTF8StringEncoding];
  NSData              *key = [NSData dataWithBytes: [[keyString sha256] bytes] length: kCCKeySizeAES128];
  NSData              *cipher = [plain aesEncryptedDataWithKey: key];
  NSString            *base64 = [cipher base64Encoding];
  
  [self accountWeiboLoginRequest:base64];
  
//  DLog(@"Base 64 encoded = %@",base64);
  //[SFHFKeychainUtils storeUsername:[weibo userID] andPassword: forServiceName:KassServiceName updateExisting:YES error:nil];
}


- (void) accountDidLogin
{
  DLog(@"User::accountDidLogin:username=%@,delegate=%@", account.userName, _delegate);

  _userId = account.userDbId;
  _name   = account.userName;
  _email  = account.email;
  _phone  = account.phone;
  
  if( [_delegate respondsToSelector:@selector(accountLoadData)] )
    [_delegate accountLoadData];
  
}

- (void)accountLoginFailed:(NSError*)error
{
  DLog(@"User::accountLoginFailed:error=%@", error);
  [self logout];
}

- (void) logout
{
  DLog(@"User::logout:weibo=%@,account=%@", self.weibo, self.account);
  if (self.weibo)    { [self.weibo LogOut]; }
  if (self.account)  { [self.account logout]; }
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

- (void)weiboDidLogin
{
  DLog(@"User::weiboDidLogin:userID=%@", [weibo userID]);
	DLog(@"User::weiboDidLogin:Token=%@", [weibo accessToken]);
	DLog(@"User::weiboDidLogin:Secret=%@", [weibo accessTokenSecret]);
  
  //get user info users/show/#{uid}.json?source=#{@api_key}
  NSString* showUserString = [NSString stringWithFormat:@"users/show/%@.json", [weibo userID] ];
  
  NSMutableDictionary* showUserparams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 [SinaWeiBoSDKDemo_APPKey URLEncodedString],@"source",nil];
  
  WBRequest* wbRequest = [weibo requestWithMethodName:showUserString 
                  andParams:showUserparams 
                 andHttpMethod:@"GET" 
                   andDelegate:self];
  
  DLog(@"User::weiboDidLogin:wbRequestUserInfo:%@", wbRequest);
}


//Received weibo request result
- (void)request:(WBRequest *)request didLoad:(id)result
{
//  DLog(@"User::didLoad:result=%@", result);
  
  if( [result isKindOfClass:[NSDictionary class]] && [result objectForKey:@"screen_name"] && [result objectForKey:@"id"]){
    [self accountWeiboLogin:result];
  }
  else{
    [self logout];
  }
}

- (void)weiboLoginFailed:(BOOL)userCancelled withError:(NSError*)error
{
	DLog(@"User::weiboLoginFailed");
}

- (void)weiboDidLogout
{
  DLog(@"User::weiboDidLogout");
}

- (void)accountDidLogout
{
  DLog(@"User::accountDidLogout");
}

@end
