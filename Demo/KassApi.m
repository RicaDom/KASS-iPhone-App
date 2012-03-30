//
//  KassApi.m
//  MyZaarlyDemo
//
//  Created by Qi He on 12-1-17.
//  Copyright (c) 2012年 Heyook. All rights reserved.
//

#import "KassApi.h"
#import "JSON.h"

@implementation KassApi

@synthesize method    = _method;
@synthesize url       = _url;
@synthesize response  = _response;
@synthesize performer = _performer;

// Initialize performer and action
- (id) initWithPerformerAndAction:(NSObject *)thePerformer:(NSString *)theAction
{
  if (self = [super init]) {
    _method     = theAction;
    _performer  = thePerformer;
  }
  return self;
}

// When asynchronous call finishes, we call the performer's method
// A method name is pass to the performer and performer is responsible 
// for working with the response data
- (void)requestFinished:(ASIHTTPRequest *)request
{
  DLog(@"KassApi::requestFinished::responseString %@", [request responseString]);  
  
  NSDictionary *result = [KassApi parseData:[request responseData]];

  if ([result isKindOfClass:[NSArray class]]){
    [_performer perform:(NSData *)[request responseData]:(NSString *) _method];
  }else if( [result isKindOfClass:[NSDictionary class]] ){
    NSDictionary *errors = [result objectForKey:@"errors"];
    if (errors) {
      [_performer requestFailed:errors];
    }else{
      [_performer perform:(NSData *)[request responseData]:(NSString *) _method];
    }
  }else{
    NSDictionary *errors = [[NSDictionary alloc]initWithObjectsAndKeys:@"Invalid Response", @"Request", nil];
    [_performer requestFailed:errors];
  }

}

// When asynchronous call fails, log the error
- (void)requestFailed:(ASIHTTPRequest *)request
{
  NSError *error = [request error];
  DLog(@"KassApi::requestFailed %@", [request error]);
  NSDictionary *errorDict = [[NSDictionary alloc]initWithObjectsAndKeys:
                              [NSString stringWithFormat:@"%d", [error code]], @"code",
                              (NSString *)_method, @"method",
                              [error description], @"description", nil];
  [_performer requestFailed:errorDict];
}

- (void)putData:(NSString *)url:(NSDictionary *)dict
{
  id kassSelf = self;
  __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
  [request setCompletionBlock:^{ [kassSelf requestFinished:request]; }];
  [request setFailedBlock:^{[kassSelf requestFailed:request];}];
  [request setRequestMethod:@"PUT"];
  [request setTimeOutSeconds:REQUEST_TIMEOUT];
  for (id key in dict){
    [request setPostValue:[dict objectForKey:key] forKey:key];
  }
  [request startAsynchronous];
  DLog(@"KassApi::putData::startAsynchronous=%@", url);
}

- (void)postData:(NSString *)url:(NSDictionary *)dict
{
  id kassSelf = self;
  __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
  [request setCompletionBlock:^{ [kassSelf requestFinished:request]; }];
  [request setFailedBlock:^{[kassSelf requestFailed:request];}];
  [request setRequestMethod:@"POST"];
  [request addRequestHeader:@"Content-Type" value:@"application/json"];
  [request setTimeOutSeconds:REQUEST_TIMEOUT];
  for (id key in dict){
    [request setPostValue:[dict objectForKey:key] forKey:key];
  }
  [request startAsynchronous];
  DLog(@"KassApi::postData::startAsynchronous=%@", url);
}

- (void)getData:(NSString *)url
{
  id kassSelf = self;
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
  [request setCompletionBlock:^{ [kassSelf requestFinished:request]; }];
  [request setFailedBlock:^{[kassSelf requestFailed:request];}];  
  [request setTimeOutSeconds:REQUEST_TIMEOUT];
  [request startAsynchronous];
  DLog(@"KassApi::getData::startAsynchronous=%@", url);
}

- (void)deleteData:(NSString *)url
{
  id kassSelf = self;
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
  [request setCompletionBlock:^{ [kassSelf requestFinished:request]; }];
  [request setFailedBlock:^{[kassSelf requestFailed:request];}]; 
  [request setRequestMethod:@"DELETE"]; 
  [request setTimeOutSeconds:REQUEST_TIMEOUT];
  [request startAsynchronous];
  DLog(@"KassApi::deleteData::startAsynchronous=%@", url);
}

- (void)deleteDataWithToken:(NSString *)url:(NSString*)token
{
  id kassSelf = self;
  __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
  [request setCompletionBlock:^{ [kassSelf requestFinished:request]; }];
  [request setFailedBlock:^{[kassSelf requestFailed:request];}];
  [request setRequestMethod:@"DELETE"];
  [request setPostValue:token forKey:@"device_token"];
  [request setTimeOutSeconds:REQUEST_TIMEOUT];
  [request startAsynchronous];
  DLog(@"KassApi::deleteDataWithToken::startAsynchronous=%@token=%@", url, token);
}

- (void)signUp:(NSDictionary *)dict
{
  DLog(@"KassApi::signUp:dict=%@", dict);
  _url = [NSString stringWithFormat:@"http://%s/v1/account", HOST];
  [self postData:_url:dict];  
}

- (void)deleteData:(NSString *)url:(NSString *)modelId
{
  id kassSelf = self;
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
  [request setCompletionBlock:^{ [kassSelf requestFinished:request]; }];
  [request setFailedBlock:^{[kassSelf requestFailed:request];}];
  [request setRequestMethod:@"DELETE"];
  [request setTimeOutSeconds:REQUEST_TIMEOUT];
  [request startAsynchronous];
  DLog(@"KassApi::deleteData::startAsynchronous=%@", url);
}

- (void)deleteListing:(NSString *)modelId
{
  DLog(@"KassApi::deleteListing:modelId=%@", modelId);
  _url = [NSString stringWithFormat:@"http://%s/v1/account/listings/%@", HOST, modelId];
  [self deleteData:_url:modelId];
}

- (BOOL)createListing:(NSDictionary *)dict
{
  DLog(@"KassApi::createListing:dict=%@", dict);
  _url = [NSString stringWithFormat:@"http://%s/v1/listings", HOST];
  
  //validity check
  NSString *title = [dict valueForKey:@"title"];
//  NSString *desc  = [dict valueForKey:@"description"];
  NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithDecimal:[[dict objectForKey:@"price"] decimalValue]];
  NSString *latlng = [dict valueForKey:@"latlng"];
  NSString *duration = [dict valueForKey:@"time"];
  
  if ( title && price && latlng && duration) {
    [self postData:_url:dict];
    return TRUE;
  }else{
    DLog(@"KassApi::createListing: invalid data!");
    return FALSE;
  }
}

- (void)loadSettings
{
  DLog(@"KassApi::loadSettings");
  _url = [NSString stringWithFormat:@"http://%s/v1/settings", HOST];
  [self getData:_url];  
}

- (void)modifyListing:(NSDictionary *)dict:(NSString *)modelId
{
  DLog(@"KassApi::modifyListing:id=%@,dict=%@", modelId, dict);
  _url = [NSString stringWithFormat:@"http://%s/v1/listings/%@", HOST, modelId];
  [self putData:_url:dict];  
}

- (void)modifyOffer:(NSDictionary *)dict:(NSString *)modelId
{
  DLog(@"KassApi::modifyOffer:id=%@,dict=%@", modelId, dict);
  _url = [NSString stringWithFormat:@"http://%s/v1/offers/%@", HOST, modelId];
  [self putData:_url:dict];  
}

- (void)acceptOffer:(NSDictionary *)dict:(NSString *)modelId
{
  DLog(@"KassApi::acceptOffer:id=%@,dict=%@", modelId, dict);
  _url = [NSString stringWithFormat:@"http://%s/v1/offers/%@/accept", HOST, modelId];
  [self postData:_url:dict];  
}

- (void)payOffer:(NSDictionary *)dict:(NSString *)modelId
{
  DLog(@"KassApi::payOffer:id=%@,dict=%@", modelId, dict);
  _url = [NSString stringWithFormat:@"http://%s/v1/offers/%@/pay", HOST, modelId];
  [self postData:_url:dict];  
}

- (void)confirmPaymentOffer:(NSDictionary *)dict:(NSString *)modelId
{
  DLog(@"KassApi::confirmPaymentOffer:id=%@,dict=%@", modelId, dict);
  _url = [NSString stringWithFormat:@"http://%s/v1/offers/%@/confirm_payment", HOST, modelId];
  [self postData:_url:dict]; 
}

- (void)createOfferMessage:(NSDictionary *)dict:(NSString *)offerId
{
  DLog(@"KassApi::createOfferMessage:id=%@,dict=%@", offerId, dict);
  _url = [NSString stringWithFormat:@"http://%s/v1/offers/%@/Messages", HOST, offerId];
  [self postData:_url:dict];
}

- (void)getOfferMessages:(NSString *)offerId
{
  DLog(@"KassApi::getOfferMessages:id=%@", offerId);
  _url = [NSString stringWithFormat:@"http://%s/v1/offers/%@/messages", HOST, offerId];
  [self getData:_url];  
}

- (BOOL)createOffer:(NSDictionary *)dict
{
  DLog(@"KassApi::createOffer:dict=%@", dict);
  _url = [NSString stringWithFormat:@"http://%s/v1/offers", HOST];
  
  //validity check
  NSString *message    = [dict valueForKey:@"message"];
  NSString *listingId  = [dict valueForKey:@"listing_id"];
  NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithDecimal:[[dict objectForKey:@"price"] decimalValue]];
  
  if ( message && listingId && price ) {
    [self postData:_url:dict];
    return TRUE;
  }else{
    DLog(@"KassApi::createOffer: invalid data!");
    return FALSE;
  }
  
}

- (void)getMember:(NSString *)memberId
{
  _url = [NSString stringWithFormat:@"http://%s/v1/users/%@", HOST, memberId];
  [self getData:_url];
}

- (void)getAccountListings
{
  _url = [NSString stringWithFormat:@"http://%s/v1/account/listings", HOST];
  [self getData:_url];
}

- (void)getAccountListing:(NSString *)modelId
{
  _url = [NSString stringWithFormat:@"http://%s/v1/account/listings/%@", HOST, modelId];
  [self getData:_url];
}

- (void)getAccountOffers
{
  _url = [NSString stringWithFormat:@"http://%s/v1/account/offers", HOST];
  [self getData:_url];
}

- (void)getAccountOffer:(NSString *)modelId
{
  _url = [NSString stringWithFormat:@"http://%s/v1/account/offers/%@", HOST, modelId];
  [self getData:_url];
}

+ (NSString *)getListingUrl:(NSDictionary *)dict
{
  NSString *url = [NSString stringWithFormat:@"http://%s/v1/listings", HOST];
  NSString *params = @"";
  for (id key in dict){
    NSString *param = [NSString stringWithFormat:@"%@=%@", key, [dict objectForKey:key]];
    params = params == @"" ? param : [NSString stringWithFormat:@"%@&%@", params, param];
  }
  if(params != @""){ 
    url = [NSString stringWithFormat:@"%@?%@", url, params];
  }
  return url;
}

- (void)getListings:(NSDictionary *)dict
{
  _url = [KassApi getListingUrl:dict];
  [self getData:_url];
}

//- (void)sendIphoneToken:(NSDictionary *)dict
//{
//  DLog(@"KassApi::sendIphoneToken:dict");
//  _url = [NSString stringWithFormat:@"http://%s/v1/account/iphone_token_set", HOST];
//  [self postData:_url:dict];
//}

- (void)login:(NSDictionary *)dict
{
  NSString *encodedData = [dict objectForKey:@"encode"];
  if (encodedData) {
    _url = [NSString stringWithFormat:@"http://%s/v1/weibo/auth", HOST];
  }else{
    _url = [NSString stringWithFormat:@"http://%s/v1/auth", HOST];
  }
  [self postData:_url:dict];
}

- (void)logout:(NSString *)token
{
  _url = [NSString stringWithFormat:@"http://%s/v1/auth?device_token=%@", HOST, token];
  [self deleteData:_url:nil];
}

- (void)getListing:(NSString *)modelId
{
  _url = [NSString stringWithFormat:@"http://%s/v1/listings/%@", HOST, modelId];
  [self getData:_url];
}

- (void)getAuth
{
  _url = [NSString stringWithFormat:@"http://%s/v1/auth", HOST];
  [self getData:_url];
}

- (void)getAlertListings:(NSString *)modelId
{
  _url = [NSString stringWithFormat:@"http://%s/v1/alerts/%@/listings", HOST, modelId];
  [self getData:_url];
}

- (BOOL)createAlert:(NSDictionary *)dict
{
  DLog(@"KassApi::createAlert:dict=%@", dict);
  _url = [NSString stringWithFormat:@"http://%s/v1/alerts", HOST];
  
  //validity check
//  NSString *category_ids    = [dict valueForKey:@"category_ids"];
//  NSString *radius          = [dict valueForKey:@"radius"];
  NSString *query           = [dict valueForKey:@"query"];
  NSString *latlng          = [dict valueForKey:@"latlng"];
  NSString *address         = [dict valueForKey:@"address"];
  
  if ( query && (latlng || address) ) {
    [self postData:_url:dict];
    return TRUE;
  }else{
    DLog(@"KassApi::createAlert: invalid data!");
    return FALSE;
  }
}

- (void)modifyAlert:(NSDictionary *)dict:(NSString *)modelId
{
  DLog(@"KassApi::modifyAlert:dict=%@", dict);
  _url = [NSString stringWithFormat:@"http://%s/v1/alerts/%@", HOST, modelId];
  [self putData:modelId:dict];
}

- (void)deleteAlert:(NSString *)modelId
{
  DLog(@"KassApi::deleteAlert:id=%@", modelId);
  _url = [NSString stringWithFormat:@"http://%s/v1/account/alerts/%@", HOST, modelId];
  [self deleteData:_url:modelId];
}

- (void)getAccountAlerts
{
  _url = [NSString stringWithFormat:@"http://%s/v1/account/alerts", HOST];
  [self getData:_url];
}

- (void)createStatusCall:(NSDictionary *)dict
{
  NSString *modelName        = [dict valueForKey:@"class"];
  NSString *modelId          = [dict valueForKey:@"dbId"];
  NSString *callerId         = [dict valueForKey:@"callerId"];
  NSString *calleeId         = [dict valueForKey:@"calleeId"];
  
  _url = [NSString stringWithFormat:@"http://%s/v1/status/%@/%@", 
            HOST, modelName, modelId];
  
  if ( callerId && calleeId ) {
    [self postData:_url:dict];
  }
  
}

//- (void)getPrivatePub
//{
//  _url = [NSString stringWithFormat:@"http://%s/private_pub.json", HOST];
//  [self getData:_url];
//}

/////// CLASS METHODS - SYNCHRONOUS CALLS ////////

//+ (NSData *)getListings:(NSString *)box{
//  NSString *url = [NSString stringWithFormat:@"http://%@/v1/listings.json?box=%@", HOST, box];
//  return [KassApi getData:url];
//}
//
//+ (NSData *)getListing:(NSString *)modelId{
//  NSString *url = [NSString stringWithFormat:@"http://%@/v1/listings/%@.json", HOST, modelId];
//  return [KassApi getData:url];
//}
//
//+ (NSData *)postData:(NSString *)url:(NSDictionary *)dict
//{
//  //  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];  
//  //  [request setUsername:@"kass@gmail.com"];
//  //  [request setPassword:@"1111111"];
//  //  [request appendPostData:[@"This is my data" dataUsingEncoding:NSUTF8StringEncoding]];
//  //  // Default becomes POST when you use appendPostData: / appendPostDataFromFile: / setPostBody:
//  //  [request setRequestMethod:@"POST"];
//  
//  ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
//  [request setRequestMethod:@"POST"];
//  [request setPostValue:@"kass@gmail.com" forKey:@"email"];
//  [request setPostValue:@"1111111" forKey:@"password"];
//  [request startSynchronous];
//  NSError *error = [request error];
//  if (!error) {
//    NSData *data = [request responseData];
//    DLog(@"----- POST DATA ... ------ \n %@ ", [request responseString]);
//    return data;
//  }else{
//    return nil;
//  }
//}
//
+ (NSData *)getData:(NSString *)url
{ 
  DLog(@"Request Data Url = %@", url);
  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
  [request setTimeOutSeconds:20];
  [request startSynchronous];
  NSError *error = [request error];
  if (!error) {
    NSData *data = [request responseData];
    DLog(@"----- GET DATA SYNCHRONOUSLY ------ \n %@ ", [request responseString]);
    return data;
  }else{
    return nil;
  }
}

+ (NSData *)loadSettings
{
  DLog(@"KassApiKlass::loadSettings");
  return [KassApi getData:[NSString stringWithFormat:@"http://%s/v1/settings", HOST]]; 
}

+ (NSData *)getListings:(NSDictionary *)dict
{
  NSString *url = [self getListingUrl:dict];
  return [self getData:url];
}

+ (NSDictionary *)parseData:(NSData *)data
{
  SBJSON *jsonParser = [[SBJSON alloc]init];
	NSString *sdata = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSError* parserError = nil;
	NSDictionary *dict = [jsonParser objectWithString:sdata error:&parserError];

  return dict;
}

+ (void)logData:(NSDictionary *)dict
{
  for (id key in dict) {
    NSLog(@"key: %@ , value: %@", key, [dict objectForKey:key]);
  }
} 

@end
