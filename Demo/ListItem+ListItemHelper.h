//
//  ListItem+ListItemHelper.h
//  Demo
//
//  Created by Qi He on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ListItem.h"
#import "BaseHelper.h"
#import <MapKit/MapKit.h>

@class ListingTableCell;

@interface ListItem (ListItemHelper)

- (NSString *) getTimeLeftText;
- (NSString *) getTimeLeftTextlong;
- (NSString *) getDistanceFromLocationText:(CLLocation *)loc;
- (NSString *) getPriceText;
- (NSString *) getUrl;
- (NSString *) getBaiduMapUrl;
- (UIColor *) getStateColor;
- (int) getStateWidthOffset;

- (void) buildUserImageView:(UIView *)view;
- (void) buildStatusIndicationView:(UIView *)view;
- (void) buildListingTableCell:(ListingTableCell *)cell;
- (void) buildMap:(MKMapView *)mapView;


@end
