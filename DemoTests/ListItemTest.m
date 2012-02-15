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
  NSArray *latlng = [[NSArray alloc] initWithObjects: @"30.645333", @"104.011199", nil];
  NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"i am an item", @"title",
                               @"i am a description", @"description",
                               @"2012-02-17T07:50:16+00:00", @"time",
                               latlng, @"latlng",
                               @"50.0", @"price",
                               nil];
  
  listItem = [[ListItem alloc] initWithDictionary:dictionary];
  
  STAssertEqualObjects([listItem title], @"i am an item", nil);
  NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithDecimal:
                            [[NSNumber numberWithDouble:50.0] decimalValue]];
  
  STAssertEqualObjects([listItem askPrice], price, nil);
  
  NSDecimalNumber *lat = [NSDecimalNumber decimalNumberWithDecimal:
                            [[NSNumber numberWithDouble:30.645333] decimalValue]];
  
  STAssertEqualObjects(listItem.location.latitude, lat, nil);
  
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
  NSString *dateTimeString = [dateFormat stringFromDate:listItem.endedAt];
  
  STAssertEqualObjects(@"2012-02-17T07:50:16+00:00", dateTimeString, nil);
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
