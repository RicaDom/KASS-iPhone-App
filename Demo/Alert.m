//
//  Alert.m
//  Demo
//
//  Created by Wesley Wang on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Alert.h"
#import "Constants.h"

@implementation Alert

@synthesize keyword = _keyword;
@synthesize minPrice = _minPrice;
@synthesize radius = _radius;
@synthesize userCurrentLocation = _userCurrentLocation;
@synthesize userSpecifyLocation = _userSpecifyLocation;

- (BOOL) isAll
{
  return _keyword.isBlank || [_keyword isEqualToString:TEXT_ALL_GOODS];
}

@end
