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
  [[[mockString stub] andReturn:nil] postData:@"url"];
  
  kassApi = [[KassApi alloc] initWithPerformerAndAction:nil :@"action"];
}

- (void)tearDown
{
  [super tearDown];
}


- (void)testGetListings
{
  NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"33.7715308509767,-118.31375383287669,34.17153085097671,-117.9137538328766", @"box",
                               nil];
  [kassApi getListings:dictionary];
  STAssertEqualObjects([kassApi url], @"http://localhost:3000/v1/listings.json?box=33.7715308509767,-118.31375383287669,34.17153085097671,-117.9137538328766", nil);
}

- (void)testGetListing
{
  [kassApi getListing:@"abc"];
  STAssertEqualObjects([kassApi url], @"http://localhost:3000/v1/listings/abc.json", nil);
}

@end
