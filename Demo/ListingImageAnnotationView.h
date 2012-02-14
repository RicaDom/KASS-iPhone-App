//
//  ListingImageAnnotationView.h
//  Demo
//
//  Created by zhicai on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ListingImageAnnotationView : MKAnnotationView
{
	UIImageView* _imageView;
}

@property (nonatomic, strong) UIImageView* imageView;
@end
