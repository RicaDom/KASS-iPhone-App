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
  NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"i am an item", @"title",
                               @"i am a description", @"description",
                               @"50.0", @"price",
                               nil];
  
  listItem = [[ListItem alloc] initWithDictionary:dictionary];

}

- (void)tearDown
{
  [super tearDown];
}

// All code under test must be linked into the Unit Test bundle
- (void)testListItem
{
  STAssertEqualObjects([listItem title], @"i am an item", nil);
  NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithDecimal:
                            [[NSNumber numberWithDouble:50.0] decimalValue]];
  
  STAssertEqualObjects([listItem askPrice], price, nil);
}


@end
