//
//  UIViewController+ActivityIndicate.m
//  Demo
//
//  Created by Qi He on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+ActivityIndicate.h"
#import "DejalActivityView.h"
#import "UIResponder+VariableStore.h"

@implementation UIViewController (ActivityIndicate)

- (void) showLoadingIndicator
{
  [self showIndicator:@"Loading..."];
}

- (void) showIndicator:(NSString *)msg
{
  [DejalBezelActivityView activityViewForView:self.navigationController.navigationBar.superview withLabel:msg width:100];
}

- (void) hideIndicator
{
  [DejalBezelActivityView removeViewAnimated:YES];
}

- (void)accountRequestFailed:(NSDictionary *)errors
{
  DLog(@"UIViewController (ActivityIndicate)::accountRequestFailed");
  [self hideIndicator];
}

- (void)accountRequestStarted
{
  DLog(@"UIViewController (ActivityIndicate)::accountRequestStarted");
  [self showLoadingIndicator];
}

//this ensures you have a delegate
- (void)viewWillAppear:(BOOL)animated
{
  DLog(@"UIViewController (ActivityIndicate)::viewWillAppear:currentViewController=%@", self);
  VariableStore.sharedInstance.currentViewControllerDelegate = self;
}

- (void)viewDidLoad
{
// this was to make sure that the indicator hides when it should
//  DLog(@"UIViewController (ActivityIndicate)::viewDidLoad:delegate=%@", self);
//  if( [self kassVS] && [[self kassVS] isLoggedIn ] )
//    [self currentUser].delegate = self;
}

@end
