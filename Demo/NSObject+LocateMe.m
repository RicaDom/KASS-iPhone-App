//
//  UIResponder+LocateMe.m
//  Demo
//
//  Created by Qi He on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSObject+LocateMe.h"

@implementation NSObject (LocateMe)

- (void)locateFinished
{
  DLog(@"NSObject+LocateMe::locateFinished");
}

- (void)locateFailed
{
  DLog(@"NSObject+LocateMe::locateFailed");
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
  DLog(@"NSObject+LocateMe::didUpdateToLocation");
  // If it's a relatively recent event, turn off updates to save power
  NSDate* eventDate = newLocation.timestamp;
  NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
  if (abs(howRecent) < 15.0 )
  {
    DLog(@"NSObject+LocateMe::[%+.6f,%+.6f]\n",
         newLocation.coordinate.latitude,
         newLocation.coordinate.longitude);
    [self locateFinished];
  }
  // else skip the event and process the next one.
}


@end
