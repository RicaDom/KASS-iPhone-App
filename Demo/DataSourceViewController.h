//
//  DataSourceViewController.h
//  Demo
//
//  Created by Qi He on 12-3-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSourceManager.h"

typedef enum {
  dstListItem,
  dstOffer,
  dstNone
} DataSourceType ;

@interface DataSourceViewController : UIViewController <DataSourceDelegate>

@property DataSourceType dType;
@property (nonatomic,strong) DataSource *dataSource;

- (void)unloadDataSource;

@end
