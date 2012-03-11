//
//  RefreshViewPuller.h
//  Demo
//
//  Created by Qi He on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PullToRefreshView.h"

@interface ScrollViewRefreshPuller : NSObject{
  PullToRefreshView * _pull;
}

+ (ScrollViewRefreshPuller *)currentPuller;

- (void)registerScrollView:(UIScrollView *)scrollView:(id<PullToRefreshViewDelegate>)delegate;
- (void)finishedLoading;
- (id<PullToRefreshViewDelegate>)delegate;
- (void)unregister;

@end
