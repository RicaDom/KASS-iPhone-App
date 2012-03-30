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

- (void)removeAlertViews
{
  for(UIView *subview in [self subviews]) {
    if (subview.tag == ALERT_VIEW_TAG) {
      [subview removeAllSubviews];
      [subview removeFromSuperview];
    }
  }
}

- (void)removeAllSubviews
{
  for(UIView *subview in [self subviews]) {
    [subview removeFromSuperview];
  }
}

- (void)removeViewsWithTag:(int)tag
{
  for(UIView *subview in [self subviews]) {
    if (subview.tag == tag) {
      [subview removeFromSuperview];
    }
  }
}

- (void)removeAvatarViews
{
  for(UIView *subview in [self subviews]) {
    if (subview.tag == USER_AVATAR_VIEW_TAG) {
      [subview removeFromSuperview];
    }
  }
}

- (void)hideAllSubviews
{
  for(UIView *subview in [self subviews]) {
    subview.hidden = TRUE;
    if (subview.tag == BUTTON_STATUS_TAG) {
      [subview removeFromSuperview];
    }
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
