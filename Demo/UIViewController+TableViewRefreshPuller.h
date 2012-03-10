//
//  UIViewController+TableViewRefreshPuller.h
//  Demo
//
//  Created by Qi He on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewRefreshPuller.h"

@interface UIViewController (TableViewRefreshPuller) <EGORefreshTableHeaderDelegate, UITableViewDelegate>

- (void)registerTableViewRefreshPuller:(UITableView *)tableView:(UIView *)view;
- (void)unregisterTableViewRefreshPuller;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
