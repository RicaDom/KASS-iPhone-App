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

@synthesize delegate = _delegate, userDbId = _userDbId, userName = _userName;


- (void)loginFinished:(NSData *)data
{
  DLog(@"Account::loginFinished");
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"Account::loginFinished:dict %@", dict);
}

- (void)login
{
  DLog(@"Account::login");
  NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
  NSString *username = [standardDefaults stringForKey:KassAppUsernameKey];
  NSString *password = @"";
  
  if (username) {
    NSError *error = nil;
    password = [SFHFKeychainUtils getPasswordForUsername:username andServiceName:KassServiceName error:&error];
    
    DLog(@"Account::login:user=%@, password=%@", username, password);
    
  } else {
    // No username. Prompt the user to enter username & password and store it
    username = @"kass@gmail.com";
    password = @"1111111";
    
    [standardDefaults setValue:username forKey:KassAppUsernameKey];    
    
    NSError *error = nil;
    BOOL storeResult = [SFHFKeychainUtils storeUsername:username andPassword:password forServiceName:KassServiceName updateExisting:YES error:&error];
    
    DLog(@"Account::login:store=%@",  (storeResult ? @"YES" : @"NO"));
  }
  
  
  NSDictionary * userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                             username, @"email",
                             password, @"password",
                             nil];
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"loginFinished:"];
  [ka login:userInfo];
}

- (void)logout
{
  DLog(@"Account::logout");
//  //remove the info stored in the keychain.
//	NSString* serviceName = [[self urlSchemeString] stringByAppendingString:kKeyChainServiceNameForWeiBo];
//	[SFHFKeychainUtils deleteItemForUsername:kKeyChainUserIDForWeiBo andServiceName:serviceName error:nil];
//	[SFHFKeychainUtils deleteItemForUsername:kKeyChainAccessTokenForWeiBo andServiceName:serviceName error:nil];
//	[SFHFKeychainUtils deleteItemForUsername:kKeyChainAccessSecretForWeiBo andServiceName:serviceName error:nil];
//	
//	//remove the info in the memory.
//	if( _userID ){[_userID release];_userID=nil;}
//	if( _accessToken ){[_accessToken release];_accessToken=nil;}
//	if( _accessTokenSecret ){[_accessTokenSecret release];_accessTokenSecret=nil;}
  
  if( [_delegate respondsToSelector:@selector(accountDidLogout)] )
		[_delegate accountDidLogout];
}
- (BOOL)isUserLoggedIn
{
  return _userDbId && _userName;
}

@end
