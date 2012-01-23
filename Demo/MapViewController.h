//
//  MapViewController.h
//  Demo
//
//  Created by zhicai on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#define METERS_PER_MILE 1609.344

@interface MapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *currentMap;
- (void) loadMapDemo;
@end
