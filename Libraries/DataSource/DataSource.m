//
//  DataSource.m
//  Demo
//
//  Created by Qi He on 12-3-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

@synthesize delegate = _delegate, expired = _expired, dataObject = _dataObject;

- (id)initWithDataObjectAndDelegate:(NSObject *)dataObject:(id<DataSourceDelegate>)delegate
{
  if (self = [super init]) {
    self.delegate   = delegate;
    self.dataObject = dataObject;
    self.expired    = TRUE; 
  }
  return self;
}

- (BOOL)isExpired
{
  return _expired;
}

- (void)unload
{
  self.dataObject = nil;
  self.expired = TRUE;
}

- (void)load
{
  if ( !self.isExpired ) { return; }
  
  if( [_delegate respondsToSelector:@selector(loadDataSource)] )
    [_delegate loadDataSource];
  
  self.expired = FALSE;
}

@end
