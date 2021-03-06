//
//  UIView+Subviews.h
//  kass
//
//  Created by Qi He on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Subviews)

- (void)removeAllSubviews;
- (void)hideAllSubviews;
- (void)showAllSubviews;
- (void)setAllLabelsFonts;
- (void)removeAvatarViews;
- (void)removeAlertViews;
- (void)removeViewsWithTag:(int)tag;
- (UIView *)getViewWithTag:(int)tag;

@end
