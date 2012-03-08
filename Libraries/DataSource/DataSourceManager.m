//
//  DataSourceManager.m
//  Demo
//
//  Created by Qi He on 12-3-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataSourceManager.h"

@implementation DataSourceManager

@synthesize dataSourceDictionary = _dataSourceDictionary;

+ (DataSourceManager *) dsm {
  // the instance of this class is stored here
  static DataSourceManager *myInstance;
  @synchronized(self){
    // check to see if an instance already exists
    if (nil == myInstance) {
      myInstance  = [[[self class] alloc] init];
      myInstance.dataSourceDictionary = [[NSMutableDictionary alloc] init];
    }
    return myInstance;    
  }
}

- (void)registerDataSource:(id<DataSourceDelegate>)dsd:(DataSource *)dataSource
{
  NSString *className = NSStringFromClass(dsd.class);
  DLog(@"DataSourceManager:registerDataSource=%@", className);
//  DataSource *ds = [_dataSourceDictionary objectForKey:className];
//  if ( !ds ) {
//    ds = [[DataSource alloc] initWithDataObjectAndDelegate:nil :dsd];
    [self.dataSourceDictionary setObject:dataSource forKey:className];
//  }
  [DataSourceManager.dsm loadDataSource:className];
}

- (void)unregisterDataSource:(id<DataSourceDelegate>)dsd
{
  DLog(@"DataSourceManager:unregisterDataSource=%@", NSStringFromClass(dsd.class));
  DataSource *ds = [_dataSourceDictionary objectForKey:NSStringFromClass(dsd.class)];
  if ( ds ) {
    [ds unload];
    [_dataSourceDictionary removeObjectForKey:NSStringFromClass(dsd.class)];
    ds = nil;
  }
}

- (void)loadDataSource:(NSString *)className
{
  DataSource *ds = [_dataSourceDictionary objectForKey:className];
  if ( ds ) {
    DLog(@"DataSourceManager::loadDataSource:class=%@", className);
    [ds load];
  }
}

- (void)unloadDataSource:(NSString *)className
{
  DataSource *ds = [_dataSourceDictionary objectForKey:className];
  if ( ds ) {
    DLog(@"DataSourceManager::unloadDataSource:class=%@", className);
    [ds unload];
  }
}

- (DataSource *)dataSourceForClass:(NSString *)className
{
  return [_dataSourceDictionary objectForKey:className];
}

- (void)setDataSourceObject:(NSString *)className:(ActiveModel *)obj
{
  DataSource *ds = [_dataSourceDictionary objectForKey:className];
  if ( ds ) {
    DLog(@"DataSourceManager::expire:dataObject=%@", obj);
    ds.dataObject = obj;
  }
}

- (void)expireDataSource:(NSString *)className
{
  DLog(@"DataSourceManager:expireDataSource=%@", className);
  DataSource *ds = [_dataSourceDictionary objectForKey:className];
  if ( ds ) {
    ds.expired = TRUE;
    DLog(@"DataSourceManager::expire:ds=%@", ds);
  }
}

@end
