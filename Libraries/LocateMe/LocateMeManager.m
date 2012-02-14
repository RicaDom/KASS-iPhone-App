//
//  LocateMeManager.m
//  Demo
//
//  Created by Qi He on 12-2-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LocateMeManager.h"

@implementation LocateMeManager

@synthesize delegate = _delegate;

- (void)locateMe
{
  DLog(@"LocateMeManager::locateMe");
  // Create the location manager if this object does not
  // already have one.
  if (nil == locationManager)
    locationManager = [[CLLocationManager alloc] init];
  
  locationManager.delegate = self;
  locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
  
  // Set a movement threshold for new events.
  locationManager.distanceFilter = 50;
  
  [locationManager startUpdatingLocation];
}

- (CLLocation *)location
{
  return locationManager == nil ? nil : locationManager.location;
}

- (void)locateFinished
{
  DLog(@"LocateMeManager::locateFinished");
  if( [_delegate respondsToSelector:@selector(locateMeFinished)] )
    [_delegate locateMeFinished];
}

@end
