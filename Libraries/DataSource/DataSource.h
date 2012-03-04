//
//  DataSource.h
//  Demo
//
//  Created by Qi He on 12-3-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSourceDelegate.h"

@interface DataSource : NSObject

@property (nonatomic) BOOL expired;
@property (nonatomic,assign) NSObject* dataObject;
@property (nonatomic,assign) id<DataSourceDelegate> delegate;

- (id)initWithDataObjectAndDelegate:(NSObject *)dataObject:(id<DataSourceDelegate>)delegate;
- (BOOL)isExpired;
- (void)load;
- (void)unload;

@end
