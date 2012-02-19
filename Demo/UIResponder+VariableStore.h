//
//  UIResponder+VariableStore.h
//  Demo
//
//  Created by Qi He on 12-2-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VariableStore.h"

@interface UIResponder (VariableStore)

- (VariableStore *) kassVS;

- (void) kassAddToModelDict:(NSDictionary *)model;
- (NSDictionary *) kassGetModelDict:(NSString *)modelName;
- (void) kassRemoveFromModelDict;

@end
