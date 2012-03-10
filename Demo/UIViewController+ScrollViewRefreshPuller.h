//
//  UIViewController+ScrollViewRefreshPuller.h
//  Demo
//
//  Created by Qi He on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollViewRefreshPuller.h"

@interface UIViewController (ScrollViewRefreshPuller) <PullToRefreshViewDelegate>

- (void)registerScrollViewRefreshPuller:(UIScrollView *)scrollView;
- (void)stopLoading;

@end