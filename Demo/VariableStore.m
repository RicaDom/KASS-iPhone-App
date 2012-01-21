//
//  VariableStore.m
//  Demo
//
//  Created by zhicai on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VariableStore.h"

@implementation VariableStore 

@synthesize currentPostingItem = _currentPostingItem;
@synthesize expiredTime = _expiredTime;

+ (VariableStore *) sharedInstance {
    // the instance of this class is stored here
    static VariableStore *myInstance;
    
    @synchronized(self){
        // check to see if an instance already exists
        if (nil == myInstance) {
            myInstance  = [[[self class] alloc] init];
            // initialize variables here
            myInstance.currentPostingItem = [[ListItem alloc] init];
            [myInstance initExpiredTime];
        }
        // return the instance of this class
        return myInstance;    
    }
}

- (void) clearCurrentPostingItem {
    self.currentPostingItem = [[ListItem alloc] init];
}

- (void) initExpiredTime {
    // convert to minutes
    self.expiredTime = [[NSDictionary alloc] initWithObjectsAndKeys:
                        [NSNumber numberWithInteger: 0], @"选择时间",
                        [NSNumber numberWithInteger: 3600], @"1 小时",
                        [NSNumber numberWithInteger: 7200], @"2 小时",
                        [NSNumber numberWithInteger: 21600], @"6 小时", 
                        [NSNumber numberWithInteger: 43200], @"12 小时",
                        [NSNumber numberWithInteger: 86400], @"24 小时",
                        [NSNumber numberWithInteger: 172800], @"2 天",
                        [NSNumber numberWithInteger: 259200], @"3 天",
                        [NSNumber numberWithInteger: 345600], @"4 天",
                        [NSNumber numberWithInteger: 432000], @"5 天",
                        [NSNumber numberWithInteger: 518400], @"6 天",
                        [NSNumber numberWithInteger: 604800], @"7 天",
                        nil];
}
@end
