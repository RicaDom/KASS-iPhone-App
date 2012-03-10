//
//  RefreshViewPuller.m
//  Demo
//
//  Created by Qi He on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ScrollViewRefreshPuller.h"

@implementation ScrollViewRefreshPuller

static ScrollViewRefreshPuller *rvp = nil;

+ (ScrollViewRefreshPuller *)currentPuller
{
  if (rvp == nil) {
    rvp   = [[ScrollViewRefreshPuller alloc] init];
  }
  return rvp;
}

- (void)registerScrollView:(UIScrollView *)scrollView:(id<PullToRefreshViewDelegate>)delegate
{
  _pull = [[PullToRefreshView alloc] initWithScrollView:scrollView];
  [_pull setDelegate:delegate];
  [scrollView addSubview:_pull];
}

- (id<PullToRefreshViewDelegate>)delegate
{
  return _pull.delegate;
}

- (void)finishedLoading
{
  [_pull finishedLoading];
}

- (void)unregister
{
  _pull = nil;
  rvp   = nil;
}

@end
