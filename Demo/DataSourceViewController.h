//
//  DataSourceViewController.h
//  Demo
//
//  Created by Qi He on 12-3-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSourceManager.h"

@interface DataSourceViewController : UIViewController <DataSourceDelegate>

@property (nonatomic,strong) DataSource *dataSource;

- (void)unloadDataSource;

@end
