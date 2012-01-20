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
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init]; 
  [request setURL:[NSURL URLWithString:url]]; 
  [request setHTTPMethod:@"GET"];
  NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  //NSLog(@"----- GET DATA ... ------ \n %@ ", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
  return data;
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
