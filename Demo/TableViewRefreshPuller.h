//
//  TableViewRefreshPuller.h
//  Demo
//
//  Created by Qi He on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGORefreshTableHeaderView.h"

@interface TableViewRefreshPuller : NSObject{
  EGORefreshTableHeaderView * _view;
  UITableView *_tableView;
}

@property BOOL reloading;

+ (TableViewRefreshPuller *)currentPuller;

- (EGORefreshTableHeaderView *)view;

- (void)registerTableView:(UITableView *)tableView:(UIView *)view:(id<EGORefreshTableHeaderDelegate>)delegate;

- (id<EGORefreshTableHeaderDelegate>)delegate;

- (void)finishedLoading;

- (void)unregister;

@end
