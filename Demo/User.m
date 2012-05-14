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
#import "NSString+ModelHelper.h"
#import "SFHFKeychainUtils.h"
#import "ListItem+ListItemHelper.h"
#import "VariableStore.h"
#import "NotificationRenderHelper.h"
#import "ROError.h"
#import "ViewHelper.h"
#import "ROUserResponseItem.h"
//#import "Alipay.h"

//#import "FayeClient.h"

@implementation User

@synthesize weibo, renren, account, delegate = _delegate;
@synthesize userId = _userId;
@synthesize name = _name;
@synthesize email = _email;
@synthesize phone = _phone;
@synthesize avatarUrl = _avatarUrl;
@synthesize city = _city;
@synthesize emailVerified = _emailVerified, renrenVerified = _renrenVerified, weiboVerified = _weiboVerified, phoneVerified = _phoneVerified;

- (id) initWithDelegate:(id<AccountActivityDelegate>)delegate
{
  if (self = [super init]) {
    self.delegate = delegate;
    self.renren = [Renren sharedRenren];
  }
  return self;
}

- (NSString*)stringFromDictionary:(NSDictionary*)info
{
	return [BaseHelper stringFromDictionary:info];
}

// ########################### API ##############################
- (void)getOfferMessages:(NSString *)offerId
{
  DLog(@"User::acceptOffer:id=%@", offerId);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getOfferMessagesFinished:"];
  [ka getOfferMessages:offerId];
}

- (void)getOfferMessagesFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::getOfferMessagesFinished:dict");
  
  if( [_delegate respondsToSelector:@selector(accountDidGetOfferMessages:)] )
    [_delegate accountDidGetOfferMessages:dict];
}

- (void)acceptOffer:(NSString *)modelId;
{
  DLog(@"User::acceptOffer:id=%@", modelId);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"acceptOfferFinished:"];
  [ka acceptOffer:nil:modelId];
}

- (void)acceptOfferFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::acceptOfferFinished:dict");
  
  if( [_delegate respondsToSelector:@selector(accountDidAcceptOffer:)] )
    [_delegate accountDidAcceptOffer:dict];
}

- (void)confirmPaymentOffer:(NSString *)offerId
{
  DLog(@"User::confirmPaymentOffer:id=%@", offerId);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"confirmPaymentOfferFinished:"];
  [ka confirmPaymentOffer:nil:offerId];
}

- (void)confirmPaymentOfferFinished:(NSData *)data;
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::confirmPaymentOfferFinished:dict");
  
  if( [_delegate respondsToSelector:@selector(accountDidConfirmPaymentOffer:)] )
    [_delegate accountDidConfirmPaymentOffer:dict];
}

- (void)payOffer:(NSString *)offerId
{
  DLog(@"User::payOffer:id=%@", offerId);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"payOfferFinished:"];
  [ka payOffer:nil:offerId];
}

- (void)payOfferFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::payOfferFinished:dict");
  
  if( [_delegate respondsToSelector:@selector(accountDidPayOffer:)] )
    [_delegate accountDidPayOffer:dict];
}

- (void)createOfferMessage:(NSDictionary *)dict:(NSString *)offerId
{
  DLog(@"User::createOfferMessage:dict=%@", dict);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"createOfferMessageFinished:"];
  [ka createOfferMessage:dict:offerId];
}

- (void)createOfferMessageFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::createOfferMessageFinished:dict");
  
  if( [_delegate respondsToSelector:@selector(accountDidCreateOfferMessage:)] )
    [_delegate accountDidCreateOfferMessage:dict];
}

- (void)modifyListing:(NSDictionary *)dict:(NSString *)modelId
{
  DLog(@"User::modifyListing:id=%@,dict=%@", modelId, dict);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"modifyListingFinished:"];
  [ka modifyListing:dict:modelId];
}

- (void)modifyListingFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::modifyListingFinished:dict");
  
  if( [_delegate respondsToSelector:@selector(accountDidModifyListing:)] )
    [_delegate accountDidModifyListing:dict];
}


- (void)modifyOffer:(NSDictionary *)dict:(NSString *)modelId
{
  DLog(@"User::modifyOffer:id=%@,dict=%@", modelId, dict);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"modifyOfferFinished:"];
  [ka modifyOffer:dict:modelId];
}

- (void)modifyOfferFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::modifyOfferFinished:dict");
  
  if( [_delegate respondsToSelector:@selector(accountDidModifyOffer:)] )
    [_delegate accountDidModifyOffer:dict];
}

- (void)createOffer:(NSDictionary *)dict
{
  DLog(@"User::createOffer:dict=%@", dict);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"createOfferFinished:"];
  if (![ka createOffer:dict]) {
    
    NSDictionary *errorDict = [[NSDictionary alloc]initWithObjectsAndKeys:
                               @"Invalid data", @"description", nil];
    
    [_delegate accountRequestFailed:errorDict];
  }
}

- (void)createOfferFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::createOfferFinished:dict");
  
  if( [_delegate respondsToSelector:@selector(accountDidCreateOffer:)] )
    [_delegate accountDidCreateOffer:dict];
}

- (void)getOffers
{
  DLog(@"User::getOffers");
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getOffersFinished:"];
  [ka getAccountOffers];
}

- (void)getOffersFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::getOffersFinished:dict");
  
  if( [_delegate respondsToSelector:@selector(accountDidGetOffers:)] )
    [_delegate accountDidGetOffers:dict];
}

- (void)getOffer:(NSString *)dbId
{
  DLog(@"User::getOffer:dbId=%@", dbId);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getOfferFinished:"];
  [ka getAccountOffer:dbId];
}

- (void)getOfferFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::getOffer:dict");
  
  if( [_delegate respondsToSelector:@selector(accountDidGetOffer:)] )
    [_delegate accountDidGetOffer:dict];
}

- (void)deleteListing:(NSString *)dbId
{
  DLog(@"User::deleteListing:dbId=%@", dbId);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"deleteListingFinished"];
  [ka deleteListing:dbId];
}

- (void)deleteListingFinished
{
  DLog(@"User::deleteListingFinished");
  if( [_delegate respondsToSelector:@selector(accountDidDeleteListing)] )
    [_delegate accountDidDeleteListing];
}

- (void)getListing:(NSString *)dbId
{
  DLog(@"User::getListing:dbId=%@", dbId);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getListingFinished:"];
  [ka getAccountListing:dbId];
}

- (void)getListingFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::getListingFinished:dict");
  
  if( [_delegate respondsToSelector:@selector(accountDidGetListing:)] )
    [_delegate accountDidGetListing:dict];
}

- (void)getListings
{
  DLog(@"User::getListings");
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getListingsFinished:"];
  [ka getAccountListings];
}

- (void)getListingsFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::getListingsFinished:dict");
  
  if( [_delegate respondsToSelector:@selector(accountDidGetListings:)] )
    [_delegate accountDidGetListings:dict];
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
  if (![ka createListing:dict]) {
    
    NSDictionary *errorDict = [[NSDictionary alloc]initWithObjectsAndKeys:
                               @"Invalid data", @"description", nil];
    
    [_delegate accountRequestFailed:errorDict];
  }
}

- (void)getAlertListings:(NSString *)alertId
{
  DLog(@"User::getAlertListings");
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getAlertListingsFinished:"];
  [ka getAlertListings:alertId];
}

- (void)getAlertListingsFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::getAlertListingsFinished:dict%@", dict);
  
  if( [_delegate respondsToSelector:@selector(accountDidGetAlertListings:)] )
    [_delegate accountDidGetAlertListings:dict];
}

- (void)createAlert:(NSDictionary *)dict
{
  DLog(@"User::createAlert:dict=%@", dict);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"createAlertFinished:"];
  if (![ka createAlert:dict]) {
    
    NSDictionary *errorDict = [[NSDictionary alloc]initWithObjectsAndKeys:
                               @"Invalid data", @"description", nil];
    
    [_delegate accountRequestFailed:errorDict];
  }
}

- (void)createAlertFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::createAlertFinished:dict%@", dict);
  
  if( [_delegate respondsToSelector:@selector(accountDidCreateAlert:)] )
    [_delegate accountDidCreateAlert:dict];
}

- (void)modifyAlert:(NSDictionary *)dict:(NSString *)modelId
{
  DLog(@"User::modifyAlert:modelId=%@,dict=%@", modelId, dict);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"modifyAlertFinished:"];
  [ka modifyAlert:dict:modelId];
}

- (void)modifyAlertFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::modifyAlertFinished:dict%@", dict);
  
  if( [_delegate respondsToSelector:@selector(accountDidModifyAlert:)] )
    [_delegate accountDidModifyAlert:dict];
}

- (void)deleteAlert:(NSString *)modelId
{
  DLog(@"User::deleteAlert:dbId=%@", modelId);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"deleteAlertFinished"];
  [ka deleteAlert:modelId];
}

- (void)deleteAlertFinished
{
  DLog(@"User::deleteListingFinished");
  if( [_delegate respondsToSelector:@selector(accountDidDeleteAlert)] )
    [_delegate accountDidDeleteAlert];
}

- (void)getAlerts
{
  DLog(@"User::getAlerts");
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getAlertsFinished:"];
  [ka getAccountAlerts];
}

- (void)getAlertsFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::getAlertsFinished:dict");
  
  if( [_delegate respondsToSelector:@selector(accountDidGetAlerts:)] )
    [_delegate accountDidGetAlerts:dict];
}

- (void)requestFailed:(NSDictionary *)errors
{
  DLog(@"User::requestFailed:delegate=%@", _delegate); 
  if( [_delegate respondsToSelector:@selector(accountRequestFailed:)] )
    [_delegate accountRequestFailed:errors];
}
 
// ########################### API ##############################

- (void) accountLogin:(NSString *)email:(NSString *)password
{
  if (account) {account = nil; }
  account = [[Account alloc]initWithEmailAndPassword:email:password];
  account.delegate = self;
  DLog(@"User::accountLogin:account=%@,delegate=%@", account, _delegate);
  if( [_delegate respondsToSelector:@selector(accountRequestStarted)] )
    [_delegate accountRequestStarted];
  [account login];
}

- (void) accountSignUp:(NSDictionary *)dict
{
  if (account) {account = nil; }
  account = [[Account alloc]initWithDictionary:dict];
  account.delegate = self;
  DLog(@"User::accountLogin:account=%@,delegate=%@", account, _delegate);
  if( [_delegate respondsToSelector:@selector(accountRequestStarted)] )
    [_delegate accountRequestStarted];
  [account signup];
}

- (void)createStatusCall:(NSDictionary *)dict
{
  DLog(@"User::createStatusCall:dict=%@", dict);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"createStatusCallFinished:"];
  [ka createStatusCall:dict];
}

- (void)createStatusCallFinished:(NSData *)data
{
  //don't care
}

- (void) accountWeiboLoginRequest:(NSString *)encode
{
  if (account) {account = nil; }
  account = [[Account alloc]initWithWeiboEncodedData:encode];
  account.delegate = self;
  DLog(@"User::accountWeiboLogin:account=%@", account);
  
  [account login];
}

- (NSString *) getEncryptedString:(NSDictionary *)params:(NSString *)keyString
{
  NSString* baseString = [self stringFromDictionary:params];
  NSData    *plain     = [baseString dataUsingEncoding: NSUTF8StringEncoding];
  NSData    *key       = [NSData dataWithBytes: [[keyString sha256] bytes] length: kCCKeySizeAES128];
  NSData    *cipher    = [plain aesEncryptedDataWithKey: key];
  return [cipher base64Encoding];
}

- (void) accountWeiboLogin:(NSDictionary*)userInfo
{
  _avatarUrl = [userInfo objectForKey:@"profile_image_url"];
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
	

	NSString* keyString = [NSString stringWithFormat:@"%@&%@",[SinaWeiBoSDKDemo_APPKey URLEncodedString],[SinaWeiBoSDKDemo_APPSecret URLEncodedString]];
  
  NSString *base64 = [self getEncryptedString:params:keyString];
  
  [self accountWeiboLoginRequest:base64];
  
}

//- (void)sendIphoneToken
//{
//  if (!_iphoneToken || [_iphoneToken isBlank]) { return; }
//  
//  NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                 _iphoneToken,@"apn_iphone_token",
//                                 _userId,@"apn_user_id",
//                                 @"AES",@"apn_signature_method",
//                                 [NSString stringWithFormat:@"%.0f",[[NSDate date]timeIntervalSince1970]],@"apn_timestamp",nil];
//	
//	NSString *keyString     = [NSString stringWithFormat:@"%@",KassSecretToken];
//  NSString *base64        = [self getEncryptedString:params:keyString];
//  NSDictionary *tokenInfo = [NSDictionary dictionaryWithObjectsAndKeys: base64, @"encode", nil];
//
//  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"sendIphoneTokenFinished:"];
//  [ka sendIphoneToken:tokenInfo];
//
//}
//
//- (void)sendIphoneTokenFinished:(NSData *)data
//{
//  NSDictionary *dict = [KassApi parseData:data];
//  DLog(@"User::sendIphoneTokenFinished:dict=%@", dict);
//}

- (void)performRemoteNotification
{
    // WARNING - TODO
    if ([[VariableStore sharedInstance].remoteNotification count] > 0) {
        NSDictionary *copyDict = [NSDictionary dictionaryWithDictionary:[VariableStore sharedInstance].remoteNotification];
        [VariableStore sharedInstance].remoteNotification = nil;
        
        if (VariableStore.sharedInstance.currentViewControllerDelegate != nil) {
            [NotificationRenderHelper NotificationRender:copyDict mainTabBarVC:(UITabBarController *)((UIViewController *)VariableStore.sharedInstance.currentViewControllerDelegate).tabBarController];
        }
    }
}

- (void) accountDidLogin:(NSDictionary *)dict
{
  DLog(@"User::accountDidLogin:username=%@,delegate=%@", account.userName, _delegate);
  
  _userId = account.userDbId;
  _name   = account.userName;
  _email  = account.email;
  _phone  = account.phone;
  _city   = account.city;
  _avatarUrl = account.avatarUrl;
  
  VariableStore.sharedInstance.isAutoLogin = FALSE;
  
  NSDictionary *veri = [dict objectForKey:@"verification"];
  NSArray *sources = [veri objectForKey:@"sources"];
  
  for (NSDictionary *source in sources) {
    if (!source || ![source isKindOfClass:NSDictionary.class]) { continue; }
    
    NSString *type = [source objectForKey:@"type"];
    if ([type isEqualToString:@"email"]) {
      
      NSString *emailV = [NSString stringWithFormat:@"%@",[source objectForKey:@"verified"]];
      _emailVerified = [emailV isEqualToString:@"1"];
//      _email_address = [NSString stringWithFormat:@"%@",[source objectForKey:@"email"]];
      
    }else if ([type isEqualToString:@"tsina"]) {
      
      NSString *weiboV = [NSString stringWithFormat:@"%@",[source objectForKey:@"verified"]];
      _weiboVerified = [weiboV isEqualToString:@"1"];
//      _weibo_id = [NSString stringWithFormat:@"%@",[source objectForKey:@"uid"]];
    }else if ([type isEqualToString:@"renren"]) {
      
      NSString *renrenV = [NSString stringWithFormat:@"%@",[source objectForKey:@"verified"]];
      _renrenVerified = [renrenV isEqualToString:@"1"];
//      _renren_id = [NSString stringWithFormat:@"%@",[source objectForKey:@"uid"]];
    } else if ([type isEqualToString:@"phone"]) {
      
      NSString *phoneV = [NSString stringWithFormat:@"%@",[source objectForKey:@"verified"]];
      _phoneVerified = [phoneV isEqualToString:@"1"];
//      _phone_number  = [source objectForKey:@"phone"];
      
    }
  }
  
  
  if( [_delegate respondsToSelector:@selector(accountLoginFinished)] )
    [_delegate accountLoginFinished];
    
  [self performRemoteNotification];
}

- (void)getAuth
{
  if (!account) {
    account = [[Account alloc]init];
    account.delegate = self;
  }
  [account getAuth];
}

- (void)accountLoginFailed:(NSDictionary *)error
{
  DLog(@"User::accountLoginFailed:error=%@", error);
  [self logout];
}

- (void) logout
{
  DLog(@"User::logout:weibo=%@,account=%@,delegate=%@", self.weibo, self.account, _delegate);
  if (self.weibo)    { [self.weibo LogOut]; }
  if (self.renren)   { [self.renren logout:self]; }
  if (self.account)  { [self.account logout]; }
}

- (void) weiboLogin
{
  if( weibo ) { weibo = nil; }
  
  weibo = [[WeiBo alloc]initWithAppKey:SinaWeiBoSDKDemo_APPKey 
                         withAppSecret:SinaWeiBoSDKDemo_APPSecret];
  
  weibo.delegate = self;
  
  DLog(@"User::weiboLogin:weibo=%@,delegate=%@", weibo, _delegate);
  if( [_delegate respondsToSelector:@selector(accountRequestStarted)] )
    [_delegate accountRequestStarted];
  [weibo startAuthorize];
}

- (BOOL)isWeiboLogin
{
  return weibo && weibo.userID;
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
  
  wAction = wLogin;
  WBRequest* wbRequest = [weibo requestWithMethodName:showUserString 
                  andParams:showUserparams 
                 andHttpMethod:@"GET" 
                   andDelegate:self];
  
  DLog(@"User::weiboDidLogin:wbRequestUserInfo:%@", wbRequest);
}

- (NSString *)getSharedStatus:(ListItem *)listItem
{
  NSString *who = [self hasListItem:listItem] ? @"我" : @"有人";
  
  NSString *siteName = [VariableStore.sharedInstance.settings.siteDict valueForKey:@"name"];
  NSString *statusSample = [VariableStore.sharedInstance.settings.weiboShareDict valueForKey:@"share_status"];
  NSString *description = !listItem.description.isBlank ? listItem.description : listItem.title;
  
  NSString *status = [statusSample stringByReplacingOccurrencesOfString:@"[[site]]" withString: siteName];
  status = [status stringByReplacingOccurrencesOfString:@"[[user]]" withString: who];
  status = [status stringByReplacingOccurrencesOfString:@"[[title]]" withString: listItem.title];
  status = [status stringByReplacingOccurrencesOfString:@"[[price]]" withString: listItem.getPriceText];
  status = [status stringByReplacingOccurrencesOfString:@"[[time]]" withString: listItem.getTimeLeftText];
  status = [status stringByReplacingOccurrencesOfString:@"[[description]]" withString: description];
  status = [status stringByReplacingOccurrencesOfString:@"[[url]]" withString: listItem.getUrl];
  
  return status;
}

- (NSMutableDictionary *)getSharedString:(ListItem *)listItem
{
  NSString *shareImg = [VariableStore.sharedInstance.settings.weiboShareDict valueForKey:@"share_img"];
  NSMutableDictionary* updateStatusParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                             [self getSharedStatus:listItem], @"status",
                                             shareImg, @"url",
                                             [SinaWeiBoSDKDemo_APPKey URLEncodedString],@"source",nil];
  
  return updateStatusParams;
}

- (void)renrenShare:(ListItem *)listItem
{
  if ( !self.isRenrenLogin  ) { return; }
  DLog(@"User::renrenShare:listItem=%@", [listItem title]);
  NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:10];
  [params setObject:@"status.set" forKey:@"method"];
  [params setObject:[self getSharedStatus:listItem] forKey:@"status"];
  [self.renren requestWithParams:params andDelegate:self];
}
   
- (void)renrenDidShare
{
}

- (void)weiboShare:(ListItem *)listItem
{
  if ( !self.isWeiboLogin  ) { return; }
  DLog(@"User::weiboShare:listItem=%@", [listItem title]);
  
  // statuses/update.json?source=#{@api_key}
  NSString* updateStatusString = [NSString stringWithFormat:@"statuses/upload_url_text.json"];
  
  NSMutableDictionary* updateStatusParams = [self getSharedString:listItem];
  
  wAction = wUpdate;
  WBRequest* wbRequest = [weibo requestWithMethodName:updateStatusString 
                                            andParams:updateStatusParams 
                                        andHttpMethod:@"POST" 
                                          andDelegate:self];
  
  DLog(@"User::weiboShare:wbRequestUserInfo:%@", wbRequest);
}

- (void)weiboDidShare
{
  DLog(@"User::weiboDidShare");
  if( [_delegate respondsToSelector:@selector(accountWeiboShareFinished)] )
    [_delegate accountWeiboShareFinished];
}

- (BOOL)isShareResult:(id)result
{
  return [result isKindOfClass:[NSDictionary class]] && [result objectForKey:@"id"];
}

- (BOOL)isLoginResult:(id)result
{
  return [result isKindOfClass:[NSDictionary class]] && [result objectForKey:@"screen_name"] && [result objectForKey:@"id"];
}

- (void)request:(WBRequest *)request didFailWithError:(NSError *)error
{
  DLog(@"User::didFailWithError:request=%@,error=%@", request.url, error);
}

//Received weibo request result
- (void)request:(WBRequest *)request didLoad:(id)result
{
  DLog(@"User::didLoad:request=%@,result=%@", request.url, result);
  WeiboAction mAction = wAction;
  wAction = wIdle; 
  
  if( mAction == wLogin) {
    if( [self isLoginResult:result] ){
      [self accountWeiboLogin:result];
    }else{
      [self logout];
    }
  }
  else if ( mAction == wUpdate ){
    if( [self isShareResult:result] ){
      [self weiboDidShare];
    }else{
      
    }
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

- (void)alipayOffer:(Offer *)offer
{
  DLog(@"Alipay Offer will be added!");
//  [Alipay payOffer:offer]; 
}

- (void)phoneNotify
{
  DLog(@"User::phoneNotify!");
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"phoneNotifyFinished:"];
  [ka phoneNotify];
}

- (void)phoneNotifyFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::phoneNotifyFinished:dict%@", dict);
  
  if( [_delegate respondsToSelector:@selector(accountPhoneNotifyFinished:)] )
    [_delegate accountPhoneNotifyFinished:dict];
}

- (void)phoneVerify:(NSString *)token
{
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"phoneVerifyFinished:"];
  [ka phoneVerify:token];
}

- (void)phoneVerifyFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"User::phoneVerifyFinished:dict%@", dict);
  
  if( [_delegate respondsToSelector:@selector(accountPhoneVerifyFinished:)] )
    [_delegate accountPhoneVerifyFinished:dict];
}

- (void)renrenLogin
{
  self.renren = [Renren sharedRenren];
  
  NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	NSArray* graphCookies = [cookies cookiesForURL:
                           [NSURL URLWithString:@"http://graph.renren.com"]];
	
	for (NSHTTPCookie* cookie in graphCookies) {
		[cookies deleteCookie:cookie];
	}
	NSArray* widgetCookies = [cookies cookiesForURL:[NSURL URLWithString:@"http://widget.renren.com"]];
	
	for (NSHTTPCookie* cookie in widgetCookies) {
		[cookies deleteCookie:cookie];
	}
  if (![self.renren isSessionValid]){ 
    DLog(@"session invalid, regetting renren = %@", self.renren);
    
    NSArray *permissions = [[NSArray alloc] initWithObjects:@"publish_feed", @"status_update", @"email", @"read_user_status", nil];    
    [self.renren authorizationInNavigationWithPermisson:permissions andDelegate:self];
  } else {
    DLog(@"session is valid, login using renren");
    [self renrenDidLogin:self.renren];
  }
}

- (BOOL)isRenrenLogin
{
  return renren && renren.getUserId;
}

- (void) accountRenrenLoginRequest:(NSString *)encode
{
  if (account) {account = nil; }
  account = [[Account alloc]initWithRenrenEncodedData:encode];
  account.delegate = self;
  DLog(@"User::accountRenrenLoginRequest:encode=%@", encode);
  
  [account login];
}

- (void) accountRenrenLogin:(ROUserResponseItem *)userInfo
{
  _avatarUrl = userInfo.headUrl;
  NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 userInfo.name, @"name",
                                 userInfo.headUrl, @"image",
                                 userInfo.userId, @"uid",
                                 renren.accessToken,@"oauth_access_token",
                                 renren.getUserId,@"oauth_customer_id",
                                 @"AES",@"oauth_signature_method",
                                 [NSString stringWithFormat:@"%.0f",[[NSDate date]timeIntervalSince1970]],@"oauth_timestamp",nil];
	
  DLog(@"User::accountRenrenLogin:params = %@", params);
  
  //Renren here uses sinaweiboappkey and id to encode
	NSString* keyString = [NSString stringWithFormat:@"%@&%@",[SinaWeiBoSDKDemo_APPKey URLEncodedString],[SinaWeiBoSDKDemo_APPSecret URLEncodedString]];
  
  NSString *base64 = [self getEncryptedString:params:keyString];
  
  [self accountRenrenLoginRequest:base64];
  
}

#pragma mark - RenrenDelegate methods

/**
 * 接口请求成功，第三方开发者实现这个方法
 */
- (void)renren:(Renren *)renren requestDidReturnResponse:(ROResponse*)response
{
  WeiboAction mAction = wAction;
  wAction = wIdle; 
  
  if( mAction == wLogin) {
    NSArray *usersInfo = (NSArray *)(response.rootObject);
    
    ROUserResponseItem *item = [usersInfo objectAtIndex:0];
    [self accountRenrenLogin:item];
  }
}

#pragma mark - RenrenDelegate methods

-(void)renrenDidLogin:(Renren *)newRenren{
  DLog(@"User::renrenDidLogin:userID=%@", [newRenren getUserId]);
  
  
  ROUserInfoRequestParam *requestParam = [[ROUserInfoRequestParam alloc] init] ;
	requestParam.fields = [NSString stringWithFormat:@"uid,name,sex,birthday,headurl,mainurl,email_hash"];
	
  wAction = wLogin;
	[self.renren getUsersInfo:requestParam andDelegate:self];
  
}

- (void)renren:(Renren *)renren loginFailWithError:(ROError*)error{
	NSString *title = [NSString stringWithFormat:@"Error code:%d", [error code]];
	NSString *description = [NSString stringWithFormat:@"%@", [error localizedDescription]];
	UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:title message:description delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
	[alertView show];
}

//- (void)renren:(Renren *)renren requestDidReturnResponse:(ROResponse*)response{
//	NSDictionary* params = (NSDictionary *)response.rootObject;
//  if (params!=nil) {
//    NSString *msg=nil;
//    NSMutableString *result = [[NSMutableString alloc] initWithString:@""];
//    for (id key in params)
//		{
//			msg = [NSString stringWithFormat:@"key: %@ value: %@    ",key,[params objectForKey:key]];
//      [result appendString:msg];
//		}
//		[ViewHelper showAlert:@"renren":result:self];
//	}
//}

- (void)renren:(Renren *)renren requestFailWithError:(ROError*)error{
	//Demo Test
  NSString* errorCode = [NSString stringWithFormat:@"Error:%d",error.code];
  NSString* errorMsg = [error localizedDescription];
  
  UIAlertView * alert = [[UIAlertView alloc] initWithTitle:errorCode message:errorMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
  [alert show];
}


//- (void)getPrivatePub
//{
//  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getPrivatePubFinished:"];
//  [ka getPrivatePub];
//}
//
//- (void)getPrivatePubFinished:(NSData *)data
//{
//  NSArray *privatePubs = (NSArray *)[KassApi parseData:data];
//  DLog(@"User::getPrivatePubFinished:privatePubs=%@", privatePubs);
//  
//  if (ppClient) { [ppClient clear];  ppClient = nil; }
//  
//  ppClient = [[PrivatePubClient alloc] initWithDelegate:self];
//  
//  for(int i = 0; i < [privatePubs count]; i++){
//    NSDictionary *dict = [privatePubs objectAtIndex:i];
//    [ppClient addClient:dict];
//  }
//  
//  [ppClient connectClients];
//}
//
//
/////FAYE will be removed once APN is set
//- (void) messageReceived:(NSDictionary *)messageDict {
//  DLog(@"message recieved %@", messageDict);  
//  NSDictionary *data = [messageDict valueForKey:@"data"];
//
//  UIAlertView *alert = [[UIAlertView alloc] init];
//	[alert setTitle:  [VariableStore.sharedInstance.settings getTextForMessageType:[data valueForKey:@"event"]]];
//	[alert setMessage:[data valueForKey:@"full_message"]];
//	[alert setDelegate:self];
//	[alert addButtonWithTitle:@"Dismiss"];
//	[alert addButtonWithTitle:@"View"];
//	[alert show];
//  
//}
//
//- (void)connectedToServer {
//  DLog(@"Connected");
////  self.connected = YES;
//}
//
//- (void)disconnectedFromServer {
//  DLog(@"Disconnected at %@", [NSDate date]);
////  self.connected = NO;
//}


- (void)clear
{
  weibo   = nil;
  account = nil;
  self.userId = nil;
  self.name   = nil;
  self.email  = nil;
  self.phone  = nil;
  self.city   = nil;
}

- (void)accountDidLogout
{
  DLog(@"User::accountDidLogout:delegate=%@", _delegate);
  [self clear];
  if( [_delegate respondsToSelector:@selector(accountLogoutFinished)] )
    [_delegate accountLogoutFinished];
  
//  [ppClient disconnectClients];
//  ppClient = nil;
}

///////////////////////// model helper methods ///////////////////////////////////////
- (BOOL)hasListItem:(ListItem *)listItem
{
  return [self.userId isPresent] && 
    listItem && [listItem.userId isPresent] && [self.userId isEqualToString:listItem.userId];
}

- (BOOL) isSameUser:(NSString *)userId
{
  return userId != nil && [userId isEqualToString:self.userId];
}

+ (BOOL) isEmailValid: (NSString *) candidate {
  NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
  NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
  
  return [emailTest evaluateWithObject:candidate];
}

+ (BOOL)isNameValid:(NSString *)name
{
  return [name length] >= VALIDE_USER_NAME_LENGTH_MIN && [name length] <= VALIDE_USER_NAME_LENGTH_MAX;
}

+ (BOOL)isPhoneValid:(NSString *)phone
{
  return [phone length] == VALIDE_USER_PHONE_LENGTH;
}

@end
