//
//  VariableStore.h
//  Demo
//
//  Created by zhicai on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  WARNING: This is a class storing global variables
//  using the Singleton design pattern. 

#import <Foundation/Foundation.h>
#import "ListItem.h"

@interface VariableStore : NSObject
// Global variables
// Current Posting Process Cache
@property (strong, nonatomic) ListItem *currentPostingItem;
@property (strong, nonatomic) NSDictionary *expiredTime;

+ (VariableStore *) sharedInstance;
- (void) clearCurrentPostingItem;
- (void) initExpiredTime;
@end
