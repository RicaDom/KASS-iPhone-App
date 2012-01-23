//
//  LocationTest.m
//  Demo
//
//  Created by Qi He on 12-1-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LocationTest.h"

@implementation LocationTest


- (void)testInitWithDictionary
{
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"listings" ofType:@"json"];  
  NSData *data = [NSData dataWithContentsOfFile:filePath];  
  
  NSDictionary *dict = [KassApi parseData:data];  
  NSDictionary *locationDict = [dict objectForKey:@"location"];

  location = [[Location alloc] initWithDictionary:locationDict];
  
  NSDecimalNumber *longitude = [NSDecimalNumber decimalNumberWithDecimal:
                            [[NSNumber numberWithDouble:-118.113754] decimalValue]];
  
  NSDecimalNumber *latitude = [NSDecimalNumber decimalNumberWithDecimal:
                                 [[NSNumber numberWithDouble:33.971531] decimalValue]];
  
  STAssertEqualObjects([location city], @"Los Angeles", nil);
  STAssertEqualObjects([location latitude], latitude, nil);
  STAssertEqualObjects([location longitude], longitude, nil);
  
}

@end
