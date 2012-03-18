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

static CLLocationManager *locationManager;
static Boolean _locating;

- (void)locateMe
{
  DLog(@"LocateMeManager::locateMe");
  // Create the location manager if this object does not
  // already have one.
  if (nil == locationManager){
    locationManager = [[CLLocationManager alloc] init];
    _locating = false;
  }
  
  locationManager.delegate = self;
  locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
  
  // Set a movement threshold for new events.
  locationManager.distanceFilter = 50;
  
  if (!_locating) {
    _locating = true;
    DLog(@"LocateMeManager::locateMe:locating");
    [locationManager startUpdatingLocation];
  }
  
}

- (CLLocation *)location
{
  return locationManager == nil ? nil : locationManager.location;
}

- (BOOL) hasLocation
{
  return locationManager && locationManager.location;
}

- (void)locateFinished
{
  DLog(@"LocateMeManager::locateFinished");
  _locating = false;
  if( [self.delegate respondsToSelector:@selector(locateMeFinished)] )
    [self.delegate locateMeFinished];
}

@end
