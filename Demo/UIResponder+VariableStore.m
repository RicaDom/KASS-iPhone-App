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

- (User *) currentUser
{
//  DLog(@"UIResponder+VariableStore::currentUser:delegate=%@", NSStringFromClass(self.class));
  [self kassVS].user.delegate = self;
  return [self kassVS].user;
}

- (KassApp *) kassApp
{
//  DLog(@"UIResponder+VariableStore::kassApp:delegate=%@", NSStringFromClass(self.class));
  [self kassVS].kassApp.delegate = self;
  return [self kassVS].kassApp;
}

- (ListItem *) postingItem
{
  return [self kassVS].currentPostingItem;
}

- (Settings *) settings
{
  return [self kassVS].settings;
}

@end
