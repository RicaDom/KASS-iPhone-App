//
//  DataSourceDelegate.h
//  Demo
//
//  Created by Qi He on 12-3-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataSourceDelegate <NSObject>

@optional
- (void)loadDataSource;

@end
