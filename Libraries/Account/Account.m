//
//  Account.m
//  Demo
//
//  Created by Qi He on 12-2-6.
//  Copyright (c) 2012年 kass. All rights reserved.
//

#import "Account.h"
#import "SFHFKeychainUtils.h"
#import "KassApi.h"
#import "BaseHelper.h"

@implementation Account

@synthesize delegate = _delegate, userDbId = _userDbId, userName = _userName, password = _password, weiboId = _weiboId, email = _email, encode = _encode, phone = _phone, devices = _devices, city = _city, avatarUrl = _avatarUrl, encodeRenren = _encodeRenren;

- (id)initWithEmailAndPassword:(NSString*)email:(NSString *)password
{
	if (self = [super init]) {
		_email	= [[NSString alloc]initWithString:email];
		_password = [[NSString alloc]initWithString:password];
	}
	return self;
}

- (id)initWithWeiboEncodedData:(NSString*)encode
{
  if (self = [super init]) {
		_encode	= [[NSString alloc]initWithString:encode];
	}
	return self;
}

- (id)initWithRenrenEncodedData:(NSString*)encode
{
if (self = [super init]) {
  _encodeRenren	= [[NSString alloc]initWithString:encode];
}
return self;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
  if (self = [super init]) {
		_email    = [dict valueForKey:@"email"];
    _password = [dict valueForKey:@"password"];
    _phone    = [dict valueForKey:@"phone"];
    _userName = [dict valueForKey:@"name"];
	}
	return self;
}

- (void)requestFailed:(NSDictionary *)error
{
  DLog(@"Account::requestFailed:error=%@", error);
  if( [_delegate respondsToSelector:@selector(requestFailed:)] )
    [_delegate requestFailed:error];
}

- (void)storeLoginStatus:(Boolean *)loggedIn
{
  NSString *status = loggedIn ? LOGGED_IN : LOGGED_OFF;
  NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
  [standardDefaults setValue:status forKey:KassAppLoginStatusKey];
  
  DLog(@"Set login status = %@", status);
}

- (void)storeLoginTypeStatus:(NSString *)loginType:(NSString *)encode
{
  NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
  [standardDefaults setValue:loginType forKey:KassAppLoginTypeKey];
  [standardDefaults setValue:encode forKey:KassAppOauthEncodeKey];
}

- (void)clearLoginType
{
  NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
  [standardDefaults setValue:nil forKey:KassAppLoginTypeKey];
}

- (void)loginFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"Account::loginFinished:dict %@", dict);
  
  _userDbId = [dict objectForKey:@"id"];
  _userName = [dict objectForKey:@"name"];
  _email    = [dict objectForKey:@"email"];
  _phone    = [dict objectForKey:@"phone_number"];
  _devices  = [dict objectForKey:@"devices"];
  _city     = [dict objectForKey:@"city"];
  _avatarUrl= [dict objectForKey:@"timg_url"];
  
  if ( _userDbId ) {
    
    if ( _password && _email ) {
      NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
      [standardDefaults setValue:_email forKey:KassAppEmailKey]; 
      NSError *error = nil;
      BOOL storeResult = [SFHFKeychainUtils storeUsername:_email andPassword:_password forServiceName:KassServiceName updateExisting:YES error:&error];
      DLog(@"Account::loginFinished:storeEmail(%@)Password=(%@)=>%@", _email, _password, (storeResult ? @"YES" : @"NO"));
    }
    [self storeLoginStatus:TRUE];

    if( [_delegate respondsToSelector:@selector(accountDidLogin)] )
      [_delegate accountDidLogin];
  }else{
    [self storeLoginStatus:FALSE];
    if( [_delegate respondsToSelector:@selector(accountLoginFailed:)] ){
      NSDictionary *error = [[NSDictionary alloc] initWithObjectsAndKeys:@"没有找到此用户", @"description", nil];
      [_delegate accountLoginFailed:error];
    }
  }

}

- (NSString *)getEncodedDeviceToken
{
  NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:KassAppIphoneTokenKey];
  return deviceToken ? [BaseHelper getKassEncrypted:deviceToken] : @"";
}

- (void)signup
{
  DLog(@"Account::signup");
  NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                            _email, @"email",
                            _password, @"password",
                            _phone, @"phone_number",
                            _userName, @"name",
                            [self getEncodedDeviceToken],@"device_token",
                            nil];
  
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"signupFinished:"];
  [ka signUp:userInfo];
}

- (void)signupFinished:(NSData *)data
{
  [self loginFinished:data];
}

- (void)login
{
  DLog(@"Account::login");

  NSMutableDictionary * userInfo;
  NSString *deviceToken = [self getEncodedDeviceToken];
  
  if ( _encode ) {
    
    userInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys: 
                _encode, @"encode",
                deviceToken, @"device_token",
                nil];
    [self storeLoginTypeStatus:LOGIN_WITH_WEIBO:_encode];

  }else if( _encodeRenren ){
    userInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys: 
                _encodeRenren, @"encode_renren",
                deviceToken, @"device_token",
                nil];
    [self storeLoginTypeStatus:LOGIN_WITH_RENREN:_encodeRenren];
    
  }else{
    userInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                  _email, @"email",
                  _password, @"password",
                  deviceToken, @"device_token",
                nil];
    [self storeLoginTypeStatus:LOGIN_WITH_PASSWORD:@""];
  }
  DLog(@"Account::login:userInfo=%@", userInfo);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"loginFinished:"];
  [ka login:userInfo];
}

- (void)logoutFinished:(NSData *)data;
{
  DLog(@"Account::logoutFinished:delegate=%@",_delegate);
  [self storeLoginStatus:FALSE];
  [self clearLoginType];
  if( [_delegate respondsToSelector:@selector(accountDidLogout)] )
  	[_delegate accountDidLogout];
}

- (void)getAuth
{
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getAuthFinished:"];
  [ka getAuth];
}

- (void)getAuthFinished:(NSData *)data
{
  [self loginFinished:data];
}

- (void)logout
{
  DLog(@"Account::logout");
  
  // remove the info stored in the keychain.
  [SFHFKeychainUtils deleteItemForUsername:_email andServiceName:KassServiceName error:nil];
  
  // also need to logout server
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"logoutFinished:"];
  [ka logout:[self getEncodedDeviceToken]];
}

- (BOOL)isUserLoggedIn
{
  return _userName && _userDbId;
}

@end
