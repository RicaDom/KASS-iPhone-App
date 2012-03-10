//
//  UIViewController+ScrollViewRefreshPuller.m
//  Demo
//
//  Created by Qi He on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+ScrollViewRefreshPuller.h"

@implementation UIViewController (ScrollViewRefreshPuller)

- (void)registerScrollViewRefreshPuller:(UIScrollView *)scrollView
{
  [ScrollViewRefreshPuller.currentPuller registerScrollView:scrollView:self];
}

- (void)stopLoading
{
	[ScrollViewRefreshPuller.currentPuller finishedLoading];
}

// called when the user pulls-to-refresh
- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view
{
  [self performSelector:@selector(refreshing) withObject:nil afterDelay:2.0];	
}

- (void)refreshing
{
  DLog(@"UIViewController+ScrollViewRefreshPuller:refreshingNotImplemented!!");
}


@end
