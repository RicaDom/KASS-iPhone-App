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

@implementation Account

@synthesize delegate = _delegate, userDbId = _userDbId, userName = _userName, 
            password = _password, weiboId = _weiboId, email = _email, encode = _encode, phone = _phone;

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

- (void)loginFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"Account::loginFinished:dict %@", dict);
  
  _userDbId = [dict objectForKey:@"id"];
  _userName = [dict objectForKey:@"name"];
  _email    = [dict objectForKey:@"email"];
  _phone    = [dict objectForKey:@"phone_number"];
  
  if ( _userDbId ) {
    
    if ( _password && _email ) {
      NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
      [standardDefaults setValue:_email forKey:KassAppEmailKey]; 
      NSError *error = nil;
      BOOL storeResult = [SFHFKeychainUtils storeUsername:_email andPassword:_password forServiceName:KassServiceName updateExisting:YES error:&error];
      DLog(@"Account::loginFinished:storeEmail(%@)Password=(%@)=>%@", _email, _password, (storeResult ? @"YES" : @"NO"));
    }

    if( [_delegate respondsToSelector:@selector(accountDidLogin)] )
      [_delegate accountDidLogin];
  }else{
    if( [_delegate respondsToSelector:@selector(accountLoginFailed:)] )
      [_delegate accountLoginFailed:nil];
  }

}

- (void)login
{
  DLog(@"Account::login");
//  NSError *error = nil;
//  NSString *password = [SFHFKeychainUtils getPasswordForUsername:_userName andServiceName:KassServiceName error:&error];
//  NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
//  NSString *username = [standardDefaults stringForKey:KassAppUsernameKey];
//  NSString *password = @"";
//  
//  if (username) {
//    NSError *error = nil;
//    password = [SFHFKeychainUtils getPasswordForUsername:username andServiceName:KassServiceName error:&error];
//    
//    DLog(@"Account::login:user=%@, password=%@", username, password);
//    
//  } else {
//    // No username. Prompt the user to enter username & password and store it
//    username = @"kass@gmail.com";
//    password = @"1111111";
//    
//    [standardDefaults setValue:username forKey:KassAppUsernameKey];    
//    
//    NSError *error = nil;
//    BOOL storeResult = [SFHFKeychainUtils storeUsername:username andPassword:password forServiceName:KassServiceName updateExisting:YES error:&error];
//    
//    DLog(@"Account::login:store=%@",  (storeResult ? @"YES" : @"NO"));
//  }
  
  
  NSDictionary * userInfo;
  
  if ( _encode ) {
    userInfo = [NSDictionary dictionaryWithObjectsAndKeys: _encode, @"encode", nil];

  }else{
    userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                  _email, @"email",
                  _password, @"password",
                  nil];
  }
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"loginFinished:"];
  [ka login:userInfo];
}

- (void)logout
{
  DLog(@"Account::logout");
  
  // remove the info stored in the keychain.
  [SFHFKeychainUtils deleteItemForUsername:_email andServiceName:KassServiceName error:nil];
  
  // remove the info in the memory.
  //
  if( [_delegate respondsToSelector:@selector(accountDidLogout)] )
		[_delegate accountDidLogout];
}

- (BOOL)isUserLoggedIn
{
  return _userName && _userDbId;
}

@end
