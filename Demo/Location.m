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

- (id) initWithDictionary:(NSDictionary *) theDictionary
{
  if (self = [super init]) {
    _city         = [theDictionary objectForKey:@"city"];
    _latitude     = [NSDecimalNumber decimalNumberWithDecimal:[[theDictionary objectForKey:@"latitude"] decimalValue]];
    _longitude    = [NSDecimalNumber decimalNumberWithDecimal:[[theDictionary objectForKey:@"longitude"] decimalValue]];
  }
  return self;
}

@end
