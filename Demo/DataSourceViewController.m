//
//  DataSourceViewController.m
//  Demo
//
//  Created by Qi He on 12-3-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataSourceViewController.h"

@implementation DataSourceViewController

@synthesize dataSource = _dataSource, dType = _dType;


- (void)viewWillAppear:(BOOL)animated
{
  DLog(@"DataSourceViewController::viewWillAppear:class=%@", NSStringFromClass(self.class));
  [DataSourceManager.dsm loadDataSource:NSStringFromClass(self.class)];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  DLog(@"DataSourceViewController::viewDidLoad");
  _dType = dstNone;
  if (!_dataSource) {
    _dataSource = [[DataSource alloc]initWithDataObjectAndDelegate:nil:self];
  }
  [DataSourceManager.dsm registerDataSource:self:_dataSource];
}

- (void)viewDidUnload
{
  [DataSourceManager.dsm unregisterDataSource:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
  DLog(@"DataSourceViewController::viewWillDisappear:class=%@", NSStringFromClass(self.class));
  [self unloadDataSource];
}

- (void)unloadDataSource
{
  [DataSourceManager.dsm unloadDataSource:NSStringFromClass(self.class)];
}

///////////////////////////////////////////////////////////////////////////////////

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

@end
