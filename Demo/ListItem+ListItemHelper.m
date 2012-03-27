//
//  ListItem+ListItemHelper.m
//  Demo
//
//  Created by Qi He on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ListItem+ListItemHelper.h"
#import "ViewHelper.h"
#import "ListingTableCell.h"
#import "ListingMapAnnotaion.h"
#import "ListingImageAnnotationView.h"

@implementation ListItem (ListItemHelper)

- (NSString *) getPriceText
{
  return [NSString stringWithFormat:@"￥%@", self.askPrice];
}


- (NSString *) getTimeLeftText
{
  NSString *timeLeftText = [BaseHelper getTimeFromNowText:[NSDate date]:[self endedAt]];
  return timeLeftText ? timeLeftText : @"已经过期";
}

- (NSString *) getTimeLeftTextlong
{
  NSString *timeLeftText = [BaseHelper getTimeFromNowText:[NSDate date]:[self endedAt]];
  return timeLeftText ? [[NSString alloc] initWithFormat:@"还有 %@", timeLeftText] : @"已经过期";
}

- (NSString *) getUrl
{
  return [[NSString alloc] initWithFormat:@"http://%s/browse/%@", HOST, self.dbId];
}

- (NSString *) getDistanceFromLocationText:(CLLocation *)loc
{
  CLLocationDistance distance = [[[self location] toCLLocation] distanceFromLocation:loc];
  int d = (int)distance;
  if ( d >= 1000 ){
    return [[NSString alloc] initWithFormat:@"%.1f公里", (float)distance / 1000.0];
  }else{
    return [[NSString alloc] initWithFormat:@"%d米", d];
  }
}

- (void) buildUserImageView:(UIView *)view
{
  CGRect frame = CGRectMake(10,10,50,50);
  
  if (self.userImageUrl.isPresent) {
    [ViewHelper buildCustomImageViewWithFrame:view:self.userImageUrl:frame];
  }else{
//    [ViewHelper buildDefaultImageViewWithFrame:view:UI_IMAGE_MESSAGE_DEFAULT_USER:frame];
  }
}

- (int) getStateWidthOffset
{
  if (!self.isActive) {
    return 0;
  }else if (self.isPaid){
    return 5;
  }else{
    // if the listing has offers
    if (self.offers.count > 0) {
      return 10;                
    } else { // otherwise show pending states  
      return 0;
    }
  }
}

- (UIColor *) getStateColor
{
  if (!self.isActive) {
    return [UIColor lightGrayColor];
  }else if (self.isAccepted) {
    return [UIColor greenColor];
  }else if (self.isPaid){
    return [UIColor orangeColor];
  }else{
    // if the listing has offers
    if (self.offers.count > 0) {
      return [UIColor blueColor];                
    } else { // otherwise show pending states  
      return [UIColor lightGrayColor];
    }

  }
}

- (void) buildListingTableCell:(ListingTableCell *)cell
{
  if( [self isAccepted]) {
    [ViewHelper buildListItemPayNowCell:self:cell];   
  } else if ( self.isPaid) {
    [ViewHelper buildListItemPaidCell:self:cell];
  } else if (self.isIdle && self.isExpired) {
    [ViewHelper buildListItemExpiredCell:self:cell];
  }
  else {
    // if the listing has offers
    if ([self.offers count] > 0) {
      [ViewHelper buildListItemHasOffersCell:self:cell];                
    } else { // otherwise show pending states                               
      [ViewHelper buildListItemNoOffersCell:self:cell];
    }
  }
}

- (void) buildStatusIndicationView:(UIView *)sview
{
  [BaseHelper removeTaggedSubviews:CELL_INDICATION_VIEW_TAG:sview];
  UIView *indView = [[UIView alloc] initWithFrame:CGRectMake(1, 1, 20 + [self getStateWidthOffset], sview.frame.size.height-2)];
  indView.backgroundColor = [[self getStateColor] colorWithAlphaComponent:0.50];
  indView.tag = CELL_INDICATION_VIEW_TAG;
  [sview addSubview:indView]; 
  
  if ( self.isActive ) {
    UILabel *offerCount = [[UILabel alloc] init];
    [offerCount setTextColor:[UIColor whiteColor]];
    offerCount.backgroundColor = [UIColor clearColor];
    offerCount.frame = CGRectMake(1, 1, indView.frame.size.width-1, indView.frame.size.height-1);
    offerCount.textAlignment = UITextAlignmentCenter;
    offerCount.font = [UIFont fontWithName:DEFAULT_FONT size:20];
    offerCount.text = [[NSString alloc] initWithFormat:@"%d", self.offers.count];
    [indView addSubview:offerCount]; 
  }
  
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
  mapView.layer.cornerRadius = 5;
  mapView.layer.masksToBounds = YES;
  
  ListingMapAnnotaion *listingA = [[ListingMapAnnotaion alloc] initWithCoordinate:userCoordinate title:self.title subTitle:self.description listingItemData:self];
  [mapView addAnnotation:listingA];
}
@end
