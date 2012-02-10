//
//  ListingMapAnnotaion.h
//  Demo
//
//  Created by zhicai on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "ListItem.h"

@interface ListingMapAnnotaion : NSObject <MKAnnotation>
{
	CLLocationCoordinate2D _coordinate;
	NSString*              _title;
	NSString*              _subtitle;
}

@property (strong, nonatomic) ListItem *currentItem;

-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate 
                   title:(NSString*)title
                subTitle:(NSString*)subTitle
         listingItemData:(ListItem *)data;
@end
