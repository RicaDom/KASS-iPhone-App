//
//  DataSourceManager.h
//  Demo
//
//  Created by Qi He on 12-3-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSource.h"

@interface DataSourceManager : NSObject

@property (nonatomic,strong) NSMutableDictionary *dataSourceDictionary;

+ (DataSourceManager *) dsm;
- (void)registerDataSource:(id<DataSourceDelegate>)dsd:(DataSource *)dataSource;
- (void)unregisterDataSource:(id<DataSourceDelegate>)dsd;

- (DataSource *)dataSourceForClass:(NSString *)className;

- (void)expireDataSource:(NSString *)className;
- (void)setDataSourceObject:(NSString *)className:(NSObject *)obj;
- (void)loadDataSource:(NSString *)className;
- (void)unloadDataSource:(NSString *)className;

@end
