//
//  UIViewController+SegueActiveModel.m
//  Demo
//
//  Created by Qi He on 12-3-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+SegueActiveModel.h"

@implementation UIViewController (SegueActiveModel)

- (void)performSegueWithModelJson:(NSDictionary *)modelJson:(NSString *)identifier:(id)sender
{
  [self kassVS].modelJson = modelJson;          
  [self performSegueWithIdentifier:identifier sender:sender];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  UINavigationController *uvc = segue.destinationViewController;
  if ( [uvc isKindOfClass:UINavigationController.class]) {
    NSString *controllerName = NSStringFromClass(uvc.topViewController.class);
    [self kassAddToModelDict:controllerName:[self kassVS].modelJson];
  }
  
}

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
