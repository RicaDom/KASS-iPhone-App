//
//  ListItem+ListItemHelper.m
//  Demo
//
//  Created by Qi He on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ListItem+ListItemHelper.h"

@implementation ListItem (ListItemHelper)

- (NSString *) getPriceText
{
  return [NSString stringWithFormat:@"￥%@", self.askPrice];
}


- (NSString *) getTimeLeftText
{
  return [BaseHelper getTimeFromNowText:[NSDate date]:[self endedAt]];
}

- (NSString *) getTimeLeftTextlong
{
  return [[NSString alloc] initWithFormat:@"还有 %@", [self getTimeLeftText]];
}


- (NSString *) getDistanceFromLocationText:(CLLocation *)loc
{
  CLLocationDistance distance = [[[self location] toCLLocation] distanceFromLocation:loc];
  return [[NSString alloc] initWithFormat:@"%d米", (int)distance];
}

@end
