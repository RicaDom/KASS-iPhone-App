//
//  EndlessScrollView.m
//  kass
//
//  Created by Qi He on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EndlessScroller.h"
#import "Constants.h"
#import "VariableStore.h"

@implementation EndlessScroller

static int OFFSET_THRESHOLD = 20;

@synthesize delegate = _delegate;

- (id)initWithScrollViewAndDelegate:(UITableView *)scroll:(id<EndlessScrollerDelegate>)delegate
{
  if (self = [super init]) {
    _loadingMore    = FALSE;
    _noMoreData     = FALSE;
    _currentPage    = 1;
    _scrollView     = scroll;
    _delegate       = delegate;
  }
  return self;
}

- (BOOL)shouldLoadMore
{
  return ((_scrollView.contentSize.height - _scrollView.frame.size.height) - _scrollView.contentOffset.y) < OFFSET_THRESHOLD;
}

- (void)loadMore
{
  if ( ![self shouldLoadMore] ) { return; }
  if (_loadingMore) { return; }
  if (_noMoreData)  { return; }
  
  _currentPage = _currentPage + 1;
  
  CGFloat y = _scrollView.tableFooterView.frame.size.height/2;
  CGFloat x = _scrollView.tableFooterView.frame.size.width/2;
  
  UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(x-70, y-12, 24, 24)];
  [spinner setColor: [UIColor darkGrayColor]];
  [spinner startAnimating];
  
  UILabel *loadingLabel = [[UILabel alloc] init];
  [loadingLabel setText:@"下载更多..."];
  [loadingLabel setTextColor:[UIColor grayColor]];
  [loadingLabel setBackgroundColor:[UIColor clearColor]];
  loadingLabel.font = [UIFont fontWithName:DEFAULT_FONT size:13];
  loadingLabel.tag  = LOADING_LABEL_VIEW_TAG;
  loadingLabel.frame = CGRectMake(x-40, y-12, 90, 24);
  loadingLabel.textAlignment = UITextAlignmentCenter;
  
  [_scrollView.tableFooterView addSubview:spinner];
  [_scrollView.tableFooterView addSubview:loadingLabel];
  _scrollView.tableFooterView.hidden = FALSE;
  
  _loadingMore = TRUE;
  
  if( [_delegate respondsToSelector:@selector(loadData:)] )
    [_delegate loadData:_currentPage];
  
}

- (void)reachDataEnd
{
  _noMoreData = TRUE;
}

- (void)removeSpinner:(UIView *)view
{
  NSArray *subviews = view.subviews;
  for (UIView *subview in subviews) {
    if ([subview isKindOfClass:UIActivityIndicatorView.class]) {
      [subview removeFromSuperview];
    }else if ( subview.tag == LOADING_LABEL_VIEW_TAG ){
      [subview removeFromSuperview];
    }
  }
}

- (void)removeSpinner
{
  [self removeSpinner:_scrollView.tableFooterView];
  _scrollView.tableFooterView.hidden = TRUE;
}

- (void)reset
{
  [self resetCurrentPage];
  _noMoreData = FALSE;
}

- (void) resetCurrentPage
{
  _currentPage = 1;
}

- (BOOL)isLoadingMore
{
  return _loadingMore;
}

- (void)doneLoadingData:(NSMutableArray *)data
{
  if (data.count > 0) {
    
    [_delegate appendData:data];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    int i = (_currentPage-1) * VariableStore.sharedInstance.settings.default_per_page;
    
    for (int j=0; j < data.count; j++) {
      [tempArray addObject:[NSIndexPath indexPathForRow:i+j inSection:0]];
    }
    
    [_scrollView beginUpdates];
    [_scrollView insertRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationBottom];
    [_scrollView endUpdates];
    
  }
  
  if ( data.count < VariableStore.sharedInstance.settings.default_per_page) {
    [self reachDataEnd];
  }
  
  _loadingMore = FALSE;
  [self removeSpinner];
}



@end
