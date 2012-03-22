//
//  UIView+Subviews.m
//  kass
//
//  Created by Qi He on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIView+Subviews.h"

@implementation UIView (Subviews)

- (void)removeAllSubviews
{
  for(UIView *subview in [self subviews]) {
    [subview removeFromSuperview];
  }
}

@end
