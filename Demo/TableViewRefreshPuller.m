//
//  TableViewRefreshPuller.m
//  Demo
//
//  Created by Qi He on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TableViewRefreshPuller.h"

@implementation Puller
@synthesize tableView = _tableView;
@synthesize view = _view;
@synthesize reloading = _reloading;
@end

@implementation TableViewRefreshPuller

static NSMutableDictionary *rvps = nil;

static TableViewRefreshPuller *rvp = nil;

+ (TableViewRefreshPuller *)currentPuller
{
  if (rvp == nil) {
    rvp   = [[TableViewRefreshPuller alloc] init];
    rvps  = [[NSMutableDictionary alloc] init];
  }
  return rvp;
}

- (void)registerTableView:(UITableView *)tableView:(UIView *)view:(id<EGORefreshTableHeaderDelegate>)delegate:(NSString *)identifier;
{
  Puller *puller = [[Puller alloc] init];
  
  EGORefreshTableHeaderView * _view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tableView.bounds.size.height, view.frame.size.width, tableView.bounds.size.height)];
  
  _view.delegate = delegate;
  [tableView addSubview:_view];
  
  puller.tableView = tableView;
  puller.view      = _view;
  
  [rvps setObject:puller forKey:identifier ];
}

- (void)unregister:(NSString *)identifier
{
  Puller *puller = [self getPuller:identifier];
  puller.view = nil;
  puller.tableView = nil;
  puller = nil;
  [rvps removeObjectForKey:identifier];
}

- (Puller *)getPuller:(NSString *)identifier
{
  return [rvps valueForKey:identifier];
}

- (id<EGORefreshTableHeaderDelegate>)delegate:(NSString *)identifier
{
  return [self getPuller:identifier].view.delegate;
}

- (void)finishedLoading:(NSString *)identifier
{
  EGORefreshTableHeaderView *view = [self getPuller:identifier].view;
  UITableView *tableView = [self getPuller:identifier].tableView;
  
  [view egoRefreshScrollViewDataSourceDidFinishedLoading:tableView];
}

@end
