//
//  Location.m
//  Demo
//
//  Created by Qi He on 12-1-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Location.h"

@implementation Location

@synthesize latitude    = _latitude;
@synthesize longitude   = _longitude;
@synthesize city        = _city;

- (id) initWithArray:(NSArray *)latlng
{
  if (self = [super init]) {
    _latitude  = [NSDecimalNumber decimalNumberWithDecimal:[[latlng objectAtIndex:0] decimalValue]];
    _longitude = [NSDecimalNumber decimalNumberWithDecimal:[[latlng objectAtIndex:1] decimalValue]];
  }
  return self;
}

- (id) initWithDictionary:(NSDictionary *) theDictionary
{
  if (self = [super init]) {
    _city         = [theDictionary objectForKey:@"city"];
    _latitude     = [NSDecimalNumber decimalNumberWithDecimal:[[theDictionary objectForKey:@"latitude"] decimalValue]];
    _longitude    = [NSDecimalNumber decimalNumberWithDecimal:[[theDictionary objectForKey:@"longitude"] decimalValue]];
  }
  return self;
}

- (CLLocation *) toCLLocation
{
  return [[CLLocation alloc] initWithLatitude:[_latitude doubleValue]longitude:[_longitude doubleValue]];
}

- (NSString *) toString
{
  return [[NSString alloc] initWithFormat:@"%@,%@", _longitude, _latitude];
}

@end
