//
//  UIResponder+VariableStore.h
//  Demo
//
//  Created by Qi He on 12-2-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VariableStore.h"

@interface UIResponder (VariableStore) <AccountActivityDelegate>

- (VariableStore *) kassVS;

- (void) kassAddToModelDict:(NSString *)controller:(NSDictionary *)model;
- (NSDictionary *) kassGetModelDict:(NSString *)modelName;
- (void) kassRemoveFromModelDict;

- (User *) currentUser;
- (ListItem *) postingItem;

@end
