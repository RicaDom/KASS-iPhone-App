//
//  TableViewRefreshPuller.m
//  Demo
//
//  Created by Qi He on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TableViewRefreshPuller.h"

@implementation TableViewRefreshPuller

@synthesize reloading = _reloading;

static TableViewRefreshPuller *rvp = nil;

+ (TableViewRefreshPuller *)currentPuller
{
  if (rvp == nil) {
    rvp   = [[TableViewRefreshPuller alloc] init];
  }
  return rvp;
}

- (EGORefreshTableHeaderView *)view
{
  return _view;
}

- (void)registerTableView:(UITableView *)tableView:(UIView *)view:(id<EGORefreshTableHeaderDelegate>)delegate;
{
  _tableView = tableView;
  
  _view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tableView.bounds.size.height, view.frame.size.width, tableView.bounds.size.height)];
  
  _view.delegate = delegate;
  [_tableView addSubview:_view];
}

- (void)unregister
{
  _tableView = nil;
  _view      = nil;
  rvp        = nil;
}

- (id<EGORefreshTableHeaderDelegate>)delegate
{
  return _view.delegate;
}

- (void)finishedLoading
{
  [_view egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
}

@end
