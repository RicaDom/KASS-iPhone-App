//
//  KassApi.m
//  MyZaarlyDemo
//
//  Created by Qi He on 12-1-17.
//  Copyright (c) 2012年 Heyook. All rights reserved.
//

#import "KassApi.h"

@implementation KassApi

+ (NSData *)getData:(NSString *)url
{
  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
  [request startSynchronous];
  NSError *error = [request error];
  if (!error) {
    NSData *data = [request responseData];
    //NSLog(@"----- GET DATA ... ------ \n %@ ", [request responseString]);
    return data;
  }else{
    return nil;
  }
}

+ (NSDictionary *)parseData:(NSData *)data
{
  SBJsonParser *parser = [[SBJsonParser alloc] init];  
  NSDictionary *dict = [parser objectWithData:data]; 
  //NSLog(@"----- PARSE DATA ... ------ \n %@ ", dict );
  return dict;
}

+ (void)logData:(NSDictionary *)dict
{
  for (id key in dict) {
    NSLog(@"key: %@ , value: %@", key, [dict objectForKey:key]);
  }
} 

@end
