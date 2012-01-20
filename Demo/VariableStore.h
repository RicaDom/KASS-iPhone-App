//
//  VariableStore.h
//  Demo
//
//  Created by zhicai on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListItem.h"

@interface VariableStore : NSObject
    // Global variables
    // Current Posting Process Cache
@property (strong, nonatomic) ListItem *currentPostingItem;

+ (VariableStore *) sharedInstance;
- (void) clearCurrentPostingItem;
@end
