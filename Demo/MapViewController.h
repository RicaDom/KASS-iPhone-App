//
//  MapViewController.h
//  Demo
//
//  Created by zhicai on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ListingMapAnnotaion.h"
#import "ListingImageAnnotationView.h"
#import "BrowseItemViewController.h"
#import "LocateMeDelegate.h"
#import "ViewHelper.h"

#define METERS_PER_MILE 1609.344

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *currentMap;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)backButtonAction:(id)sender;

@end
