//
//  UIResponder+VariableStore.m
//  Demo
//
//  Created by Qi He on 12-2-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIResponder+VariableStore.h"

@implementation UIResponder (VariableStore)

- (VariableStore *) kassVS
{
  return VariableStore.sharedInstance;
}

- (void) kassAddToModelDict:(NSDictionary *)model
{
  DLog(@"UIResponder+VariableStore::kassAddToModelDict:controller=%@", NSStringFromClass(self.class));
  [[self kassVS] addToModelDict:NSStringFromClass(self.class):model];
}

- (NSDictionary *) kassGetModelDict:(NSString *)modelName
{
  DLog(@"UIResponder+VariableStore::kassGetModelDict:controller=%@", NSStringFromClass(self.class));
  return [[self kassVS] getModelDict:NSStringFromClass(self.class):modelName];
}

- (void) kassRemoveFromModelDict
{
  [[self kassVS] removeFromModelDict:NSStringFromClass(self.class)];
}

@end
