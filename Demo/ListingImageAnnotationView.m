//
//  ListingImageAnnotationView.m
//  Demo
//
//  Created by zhicai on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListingImageAnnotationView.h"

#define kBorder 2

@implementation ListingImageAnnotationView
@synthesize imageView = _imageView;

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
	UIImage* image = [UIImage imageNamed:@"pin.png"];
	self.frame = CGRectMake(0, 0, image.size.width, image.size.height);
	//self.backgroundColor = [UIColor whiteColor];

	_imageView = [[UIImageView alloc] initWithImage:image];	
	//_imageView.frame = CGRectMake(kBorder, kBorder, kWidth - 2 * kBorder, kWidth - 2 * kBorder);
    _imageView.frame = CGRectMake(kBorder, kBorder, image.size.width, image.size.height);
	[self addSubview:_imageView];
	
	return self;
	
}

@end
