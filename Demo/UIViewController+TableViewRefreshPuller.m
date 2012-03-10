//
//  UIViewController+TableViewRefreshPuller.m
//  Demo
//
//  Created by Qi He on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+TableViewRefreshPuller.h"

@implementation UIViewController (TableViewRefreshPuller) 

- (void)reloadTableViewDataSource{	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
  TableViewRefreshPuller.currentPuller.reloading = YES;	
}

- (void)doneLoadingTableViewData{	
	//  model should call this when its done loading
	TableViewRefreshPuller.currentPuller.reloading  = NO;
  [TableViewRefreshPuller.currentPuller finishedLoading];
}

/** 
 UIScrollViewDelegate Methods
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{		
	[TableViewRefreshPuller.currentPuller.view egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{	
	[TableViewRefreshPuller.currentPuller.view egoRefreshScrollViewDidEndDragging:scrollView];	
}


/**
  EGORefreshTableHeaderDelegate Methods
 */

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
  [self performSelector:@selector(refreshing) withObject:nil afterDelay:1.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{	
	return TableViewRefreshPuller.currentPuller.reloading ; // should return if data source model is reloading	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{	
	return [NSDate date]; // should return date data source was last changed	
}

- (void)refreshing
{
  DLog(@"UIViewController+TableViewRefreshPuller:refreshingNotImplemented!!");
}

- (void)registerTableViewRefreshPuller:(UITableView *)tableView:(UIView *)view
{
  [TableViewRefreshPuller.currentPuller registerTableView:tableView:view:self];
  
	[TableViewRefreshPuller.currentPuller.view refreshLastUpdatedDate];
}

- (void)unregisterTableViewRefreshPuller
{
  [TableViewRefreshPuller.currentPuller unregister];
}

@end
