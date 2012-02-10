//
//  ListingMapAnnotaion.m
//  Demo
//
//  Created by zhicai on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListingMapAnnotaion.h"

@implementation ListingMapAnnotaion 

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize currentItem = _currentItem;

-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate 
                   title:(NSString*)title
                subTitle:(NSString*)subTitle
         listingItemData:(ListItem *)data
{
	self = [super init];
	_coordinate = coordinate;
    _title = title;
    _subtitle = subTitle;
    _currentItem = data;
	return self;
}

@end
