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

- (id) initWithCLLocation:(CLLocation *)cl
{
  if (self = [super init]) {
    
    NSNumber *lat = [NSNumber numberWithDouble: cl.coordinate.latitude];
    NSNumber *lng = [NSNumber numberWithDouble: cl.coordinate.longitude];
    
    _latitude = [NSDecimalNumber decimalNumberWithDecimal:[lat decimalValue]];
    _longitude = [NSDecimalNumber decimalNumberWithDecimal:[lng decimalValue]];
  }
  return self;
}

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
