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
  
  [TableViewRefreshPuller.currentPuller getPuller:NSStringFromClass(self.class)].reloading = YES;	
}

- (void)doneLoadingTableViewData{	
	//  model should call this when its done loading
	[TableViewRefreshPuller.currentPuller getPuller:NSStringFromClass(self.class)].reloading  = NO;
  [TableViewRefreshPuller.currentPuller finishedLoading:NSStringFromClass(self.class)];
}

/** 
 UIScrollViewDelegate Methods
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{		
  EGORefreshTableHeaderView *view = [TableViewRefreshPuller.currentPuller getPuller:NSStringFromClass(self.class)].view;
	[view egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{	
  EGORefreshTableHeaderView *view = [TableViewRefreshPuller.currentPuller getPuller:NSStringFromClass(self.class)].view;
	[view egoRefreshScrollViewDidEndDragging:scrollView];	
}


/**
  EGORefreshTableHeaderDelegate Methods
 */

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
  [self performSelector:@selector(refreshing) withObject:nil afterDelay:1.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{	
	return [TableViewRefreshPuller.currentPuller getPuller:NSStringFromClass(self.class)].reloading ; // should return if data source model is reloading	
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
  [TableViewRefreshPuller.currentPuller registerTableView:tableView:view:self:NSStringFromClass(self.class)];
  EGORefreshTableHeaderView *eview = [TableViewRefreshPuller.currentPuller getPuller:NSStringFromClass(self.class)].view;
	[eview refreshLastUpdatedDate];
}

- (void)unregisterTableViewRefreshPuller
{
  [TableViewRefreshPuller.currentPuller unregister:NSStringFromClass(self.class)];
}

@end
