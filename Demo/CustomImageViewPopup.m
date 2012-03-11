//
//  CustomImageViewPopup.m
//  Demo
//
//  Created by Wesley Wang on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomImageViewPopup.h"

@implementation CustomImageViewPopup

- (id)initWithType:(NSString *)type
{
    UIImage *image = nil;
    
    if ([type isEqualToString:POPUP_IMAGE_NEW_POST_SUCCESS]) {
        image = [UIImage imageNamed:@"postsuccess.png"];
    }
    
    self = [super initWithImage:image];
    if (self) {
        // custom code
        if ([type isEqualToString:POPUP_IMAGE_NEW_POST_SUCCESS]) {
            self.frame = CGRectMake((320-image.size.width)/2, 80, image.size.width, image.size.height);
        }
    }
    return self;
}

@end
