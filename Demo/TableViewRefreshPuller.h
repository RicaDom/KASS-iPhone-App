//
//  TableViewRefreshPuller.h
//  Demo
//
//  Created by Qi He on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGORefreshTableHeaderView.h"

@interface Puller : NSObject 

@property (strong, nonatomic) EGORefreshTableHeaderView * view;
@property (strong, nonatomic) UITableView *tableView;
@property BOOL reloading;

@end

@interface TableViewRefreshPuller : NSObject

+ (TableViewRefreshPuller *)currentPuller;

- (Puller *)getPuller:(NSString *)identifier;

- (void)registerTableView:(UITableView *)tableView:(UIView *)view:(id<EGORefreshTableHeaderDelegate>)delegate:(NSString *)identifier;

- (id<EGORefreshTableHeaderDelegate>)delegate:(NSString *)identifier;

- (void)finishedLoading:(NSString *)identifier;

- (void)unregister:(NSString *)identifier;

@end
