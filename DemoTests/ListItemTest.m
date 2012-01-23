//
//  ListItemTest.m
//  Demo
//
//  Created by Qi He on 12-1-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ListItemTest.h"

@implementation ListItemTest

- (void)setUp
{
  [super setUp];
}

- (void)tearDown
{
  [super tearDown];
}

// All code under test must be linked into the Unit Test bundle
- (void)testListItem
{
  
  NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"i am an item", @"title",
                               @"i am a description", @"description",
                               @"50.0", @"price",
                               nil];
  
  listItem = [[ListItem alloc] initWithDictionary:dictionary];
  
  STAssertEqualObjects([listItem title], @"i am an item", nil);
  NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithDecimal:
                            [[NSNumber numberWithDouble:50.0] decimalValue]];
  
  STAssertEqualObjects([listItem askPrice], price, nil);
}

- (void)testInitWithData
{
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"listing" ofType:@"json"];  
  NSData *data = [NSData dataWithContentsOfFile:filePath];  
  
  //id mockString = [OCMockObject mockForClass:[KassApi class]];
  //[[[mockString stub] andReturn:data] getListing:@"modelId"];
  listItem = [[ListItem alloc] initWithData:data];
  STAssertEqualObjects([listItem title], @"Acrylic fish tank", nil);
}

@end
