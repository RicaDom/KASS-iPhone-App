//
//  KassApiTest.m
//  Demo
//
//  Created by Qi He on 12-2-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KassApiTest.h"

@implementation KassApiTest


- (void)setUp
{
  [super setUp];
  
  id mockString = [OCMockObject mockForClass:[KassApi class]];
  [[[mockString stub] andReturn:nil] getData:@"url"];
  [[[mockString stub] andReturn:nil] postData:@"url":nil];
  
  kassApi = [[KassApi alloc] initWithPerformerAndAction:nil :@"action"];
}

- (void)tearDown
{
  [super tearDown];
}

- (void)testParseSettingsJson
{
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"json"];  
  NSData *data = [NSData dataWithContentsOfFile:filePath]; 
  NSDictionary *dict = [KassApi parseData:data];  
  
  NSDictionary *settings = [dict objectForKey:@"settings"];
  NSDictionary *duration = [settings objectForKey:@"duration"];
  DLog(@"duration=%@", duration);
  
  NSDictionary *secToString = [duration objectForKey:@"sec_string"];
  NSDictionary *secToText   = [duration objectForKey:@"sec_text"];
  
  NSMutableDictionary *secTime = [[NSMutableDictionary alloc]init ];
  for (id key in secToString) {
    [secTime setObject:[secToString objectForKey:key] forKey:[NSNumber numberWithInt:[key intValue]]];
  }
  
  NSMutableDictionary *secText = [[NSMutableDictionary alloc]init ];
  for (id key in secToText) {
    [secText setObject:[NSNumber numberWithInt:[key intValue]] forKey:[secToText objectForKey:key]];
  }
  
  
}

- (void)testGetListings
{
  NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"33.7715308509767,-118.31375383287669,34.17153085097671,-117.9137538328766", @"box",
                               nil];
  [kassApi getListings:dictionary];
  STAssertEqualObjects([kassApi url], @"http://localhost:3000/v1/listings?box=33.7715308509767,-118.31375383287669,34.17153085097671,-117.9137538328766", nil);
}

- (void)testGetListingsWithoutDictionary
{
  NSDictionary * dictionary = nil;
  [kassApi getListings:dictionary];
  STAssertEqualObjects([kassApi url], @"http://localhost:3000/v1/listings", nil);
}

- (void)testGetAccountListings
{
  [kassApi getAccountListings];
  STAssertEqualObjects([kassApi url], @"http://localhost:3000/v1/account/listings", nil);
}

- (void)testGetListing
{
  [kassApi getListing:@"abc"];
  STAssertEqualObjects([kassApi url], @"http://localhost:3000/v1/listings/abc", nil);
}

- (void)testLogin
{
  [kassApi login:nil];
  STAssertEqualObjects([kassApi url], @"http://localhost:3000/v1/auth", nil);
}

- (void)testLoginWeibo
{
  NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"abc", @"encode",
                               nil];
  [kassApi login:dictionary];
  STAssertEqualObjects([kassApi url], @"http://localhost:3000/v1/weibo/auth", nil);
}

@end
