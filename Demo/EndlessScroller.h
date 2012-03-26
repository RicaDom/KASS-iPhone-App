//
//  EndlessScrollView.h
//  kass
//
//  Created by Qi He on 12-3-26.
//  Copyright (c) 2012年 heyook. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EndlessScrollerDelegate;

@interface EndlessScroller : NSObject{
  BOOL _loadingMore;
  BOOL _noMoreData;
  int _currentPage;
  UITableView *_scrollView;
}

@property (nonatomic, unsafe_unretained) id<EndlessScrollerDelegate> delegate;

- (void)loadMore;
- (void)reset;
- (void)resetCurrentPage;
- (BOOL)isLoadingMore;
- (void)reachDataEnd;
- (void)doneLoadingData:(NSMutableArray *)data;
- (id)initWithScrollViewAndDelegate:(UIScrollView *)scroll
                                   :(id<EndlessScrollerDelegate>)delegate;

@end

@protocol EndlessScrollerDelegate <NSObject>

@optional

- (void)loadData:(int)page;
- (void)appendData:(NSMutableArray *)data;

@end

