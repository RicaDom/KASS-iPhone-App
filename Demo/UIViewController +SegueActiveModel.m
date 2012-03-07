//
//  UIViewController+SegueActiveModel.m
//  Demo
//
//  Created by Qi He on 12-3-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+SegueActiveModel.h"

@implementation UIViewController (SegueActiveModel)


- (void) kassAddToModelDict:(NSString *)controller:(NSDictionary *)model
{
  DLog(@"UIResponder+VariableStore::kassAddToModelDict:controller=%@", controller);
  [[self kassVS] addToModelDict:controller:model];
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
