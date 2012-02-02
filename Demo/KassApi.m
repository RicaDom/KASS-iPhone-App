//
//  KassApi.m
//  MyZaarlyDemo
//
//  Created by Qi He on 12-1-17.
//  Copyright (c) 2012年 Heyook. All rights reserved.
//

#import "KassApi.h"

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
  NSString *responseString = [request responseString];
  DLog(@"KassApi::requestFinished::responseString %@", responseString);
  [_performer perform:(NSData *)[request responseData]:(NSString *) _method];
}

// When asynchronous call fails, log the error
- (void)requestFailed:(ASIHTTPRequest *)request
{
  NSError *error = [request error];
  DLog(@"KassApi::requestFailed %@", error);
}

- (void)postData:(NSString *)url:(NSDictionary *)dict
{
  id kassSelf = self;
  __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
  [request setCompletionBlock:^{ [kassSelf requestFinished:request]; }];
  [request setFailedBlock:^{[kassSelf requestFailed:request];}];
  [request setRequestMethod:@"POST"];
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
  [request startAsynchronous];
  DLog(@"KassApi::getData::startAsynchronous=%@", url);
}

- (void)getAccountListings
{
  _url = [NSString stringWithFormat:@"http://%@/v1/account/listings.json", HOST];
  [self getData:_url];
}

- (void)getListings:(NSDictionary *)dict
{
  _url = [NSString stringWithFormat:@"http://%@/v1/listings.json", HOST];
  NSString *params = @"";
  for (id key in dict){
    NSString *param = [NSString stringWithFormat:@"%@=%@", key, [dict objectForKey:key]];
    params = params == @"" ? param : [NSString stringWithFormat:@"%@&%@", params, param];
  }
  if(params != @""){ 
    _url = [NSString stringWithFormat:@"%@?%@", _url, params];
  }
  [self getData:_url];
}

- (void)login:(NSDictionary *)dict
{
  _url = [NSString stringWithFormat:@"http://%@/v1/auth.json", HOST];
  [self postData:_url:dict];
}

- (void)getListing:(NSString *)modelId
{
  _url = [NSString stringWithFormat:@"http://%@/v1/listings/%@.json", HOST, modelId];
}

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
//+ (NSData *)getData:(NSString *)url
//{
//  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
//  [request startSynchronous];
//  NSError *error = [request error];
//  if (!error) {
//    NSData *data = [request responseData];
//    DLog(@"----- GET DATA ... ------ \n %@ ", [request responseString]);
//    return data;
//  }else{
//    return nil;
//  }
//}

+ (NSDictionary *)parseData:(NSData *)data
{
  SBJsonParser *parser = [[SBJsonParser alloc] init];  
  NSDictionary *dict = [parser objectWithData:data]; 
  //DLog(@"----- PARSE DATA ... ------ \n %@ ", dict );
  return dict;
}

+ (void)logData:(NSDictionary *)dict
{
  for (id key in dict) {
    NSLog(@"key: %@ , value: %@", key, [dict objectForKey:key]);
  }
} 

@end
