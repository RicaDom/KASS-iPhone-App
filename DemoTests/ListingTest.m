//
//  ListingTest.m
//  Demo
//
//  Created by Qi He on 12-1-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ListingTest.h"

@implementation ListingTest

- (void)setUp
{
  [super setUp];
  
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"listings" ofType:@"json"];  
  NSData *data = [NSData dataWithContentsOfFile:filePath];  
  
  //id mockString = [OCMockObject mockForClass:[KassApi class]];
  //[[[mockString stub] andReturn:data] getListings];
  listing = [[Listing alloc] initWithData:data];
}

- (void)tearDown
{
  [super tearDown];
}

// All code under test must be linked into the Unit Test bundle
- (void)testInitWithData
{
  ListItem *li = [[listing listItems] objectAtIndex:0];
  STAssertEqualObjects([li title], @"Deliver Champagne and Sing Kenny Chesney for Brother on His Birthday", nil);
  STAssertEqualObjects([[listing location] city], @"Los Angeles", nil);
}

@end
