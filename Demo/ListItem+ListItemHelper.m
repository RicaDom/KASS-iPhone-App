//
//  ListItem+ListItemHelper.m
//  Demo
//
//  Created by Qi He on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ListItem+ListItemHelper.h"
#import "ListingMapAnnotaion.h"
#import "ListingImageAnnotationView.h"

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

- (NSString *) getUrl
{
  return [[NSString alloc] initWithFormat:@"http://%s/browse/%@", HOST, self.dbId];
}

- (NSString *) getDistanceFromLocationText:(CLLocation *)loc
{
  CLLocationDistance distance = [[[self location] toCLLocation] distanceFromLocation:loc];
  return [[NSString alloc] initWithFormat:@"%d米", (int)distance];
}

- (NSString *) toLabelStyle
{
  return [[NSString alloc] initWithFormat:@"%@,1,24,0xffff00,0x6699cc,1", self.title];
}

//api.map.baidu.com/staticimage?center=120.201864004745949,30.34708993343947&width=500&height=500
//api.map.baidu.com/staticimage?center=120.201864004745949,30.34708993343947&width=500&height=500&zoom=11&markers=120.201864004745949,30.34708993343947&markerStyles=l,&labels=120.201864004745949,30.34708993343947&labelStyles=%E6%B5%B7%E6%B7%80,1,24,0xffff00,0x6699cc,1
- (NSString *) getBaiduMapUrl
{
  return [[NSString alloc] initWithFormat:@"http://api.map.baidu.com/staticimage?center=%@&width=500&height=500&zoom=11&labels=%@&labelStyles=%@&markers=%@&markerStyles=l,", self.location.toString,  self.location.toString, self.toLabelStyle, self.location.toString];
}

- (void) buildMap:(MKMapView *)mapView
{
  CLLocationCoordinate2D userCoordinate;
  userCoordinate.latitude = [self.location.latitude doubleValue];
  userCoordinate.longitude = [self.location.longitude doubleValue];
  
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userCoordinate ,MAP_DISTANCE_LAT, MAP_DISTANCE_LNG);
  [mapView setRegion:region animated:YES];
  mapView.scrollEnabled = YES;
  mapView.zoomEnabled = YES;
  
  ListingMapAnnotaion *listingA = [[ListingMapAnnotaion alloc] initWithCoordinate:userCoordinate title:self.title subTitle:self.description listingItemData:self];
  [mapView addAnnotation:listingA];
}
@end
