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

- (void)testNSDateTimeWithRubyTime
{
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:RUBY_DATETIME_FORMAT];
  NSDate *dateTime = [dateFormat dateFromString:@"2012-02-17T07:50:16+0800"];
  NSString *dateTimeString = [dateFormat stringFromDate:dateTime];
  
  STAssertEqualObjects(@"2012-02-17T07:50:16+0800", dateTimeString, nil);
}

- (void)testTimeFromText
{
  ListItem *li = [[ListItem alloc] initWithDictionary:[NSDictionary dictionaryWithObjectsAndKeys: @"i am an item", @"title",nil]];
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:RUBY_DATETIME_FORMAT];
  NSDate *fromTime = [dateFormat dateFromString:@"2012-02-17T07:50:16+0800"];
  NSDate *toTime = [dateFormat dateFromString:@"2012-02-18T07:50:16+0800"];
  
  STAssertEqualObjects(@"1天", [li getTimeFromNowText:fromTime:toTime], nil);
}

- (void)testGetTimeLeftText
{
  ListItem *li = [[ListItem alloc] initWithDictionary:[NSDictionary dictionaryWithObjectsAndKeys: @"i am an item", @"title",nil]];
  
  li.endedAt = [NSDate date];
  STAssertEqualObjects(@"少于1分钟", [li getTimeLeftText], nil);
}

// All code under test must be linked into the Unit Test bundle
- (void)testListItem
{
  NSArray *latlng = [[NSArray alloc] initWithObjects: @"30.645333", @"104.011199", nil];
  NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"i am an item", @"title",
                               @"i am a description", @"description",
                               @"2012-02-17T07:50:16+0800", @"time",
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
  [dateFormat setDateFormat:RUBY_DATETIME_FORMAT];
  NSString *dateTimeString = [dateFormat stringFromDate:listItem.endedAt];
  
  STAssertEqualObjects(@"2012-02-17T07:50:16+0800", dateTimeString, nil);
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
