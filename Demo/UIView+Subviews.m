//
//  UIView+Subviews.m
//  kass
//
//  Created by Qi He on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIView+Subviews.h"
#import "Constants.h"

@implementation UIView (Subviews)

- (void)removeAllSubviews
{
  for(UIView *subview in [self subviews]) {
    [subview removeFromSuperview];
  }
}

- (void)hideAllSubviews
{
  for(UIView *subview in [self subviews]) {
    subview.hidden = TRUE;
  }
}

- (void)showAllSubviews
{
  for(UIView *subview in [self subviews]) {
    subview.hidden = FALSE;
  }
}

- (void)setAllLabelsFonts
{
  for(UIView *subview in [self subviews]){
    if ([subview isKindOfClass:UILabel.class]) {
      UILabel *label = (UILabel *)subview;
      label.font = [UIFont fontWithName:DEFAULT_FONT size:20];
    }
  }
}

@end
