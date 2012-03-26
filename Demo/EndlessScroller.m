//
//  EndlessScrollView.m
//  kass
//
//  Created by Qi He on 12-3-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EndlessScroller.h"

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
  
  UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(5, _scrollView.frame.size.height+20, 24, 24)];
  [spinner setColor: [UIColor darkGrayColor]];
  [spinner startAnimating];
  [_scrollView addSubview:spinner];
  
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
    }
  }
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
    
    int i = 0;
    for (NSArray *count in data) {
      [tempArray addObject:[NSIndexPath indexPathForRow:i++ inSection:0]];
    }
    
    [_scrollView beginUpdates];
    [_scrollView insertRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationBottom];
    [_scrollView endUpdates];
    
  }
  else{  [self reachDataEnd]; }
  
  _loadingMore = FALSE;
  [self removeSpinner:_scrollView];
}



@end
