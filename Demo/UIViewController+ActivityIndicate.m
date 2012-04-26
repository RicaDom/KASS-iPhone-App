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
#import "ViewHelper.h"

@implementation UIViewController (ActivityIndicate)

- (void) showLoadingIndicator
{
  [self showIndicator:@"加载中..."];
}

- (void) showIndicator:(NSString *)msg
{
//navigationController.navigationBar.superview
  [DejalBezelActivityView activityViewForView:self.view withLabel:msg width:100];
}

- (void) hideIndicator
{
  [DejalBezelActivityView removeViewAnimated:YES];
}

- (void)accountRequestFailed:(NSDictionary *)errors
{
  DLog(@"UIViewController (ActivityIndicate)::accountRequestFailed");
  [self hideIndicator];
  NSString *errorCode = [errors objectForKey:@"code"];
  NSString *method    = [errors objectForKey:@"method"];
  if ([errorCode isEqualToString:@"3"]) {
    if ( [method isEqualToString:@"loginFinished:"] ) {
      [ViewHelper showErrorAlert:@"登陆错误！":self];
    }else {
      [ViewHelper showErrorAlert:@"需要登陆！":self];
    }
  }if ([errorCode isEqualToString:@"1"]) {
    [ViewHelper showConnectionErrorAlert:self.view];
  }if ([errorCode isEqualToString:@"5"]) {
    [ViewHelper showConnectionErrorAlert:self.view];
  }else {
    [ViewHelper showErrorMessageAlert:errors:self];
  }
}

- (void)appRequestFailed:(NSDictionary *)errors
{
  DLog(@"UIViewController (ActivityIndicate)::appRequestFailed:errors=%@", errors);
  [self hideIndicator];
  NSString *errorCode = [errors objectForKey:@"code"];
  if ([errorCode isEqualToString:@"1"]) {
    [ViewHelper showConnectionErrorAlert:self.view];
  }if ([errorCode isEqualToString:@"5"]) {
    [ViewHelper showConnectionErrorAlert:self.view];
  }else {
    [ViewHelper showErrorMessageAlert:errors:self];
  }
}

- (void)accountRequestStarted
{
  DLog(@"UIViewController (ActivityIndicate)::accountRequestStarted");
  [self showLoadingIndicator];
}

//this ensures you have a delegate
- (void)viewWillAppear:(BOOL)animated
{
//  DLog(@"UIViewController (ActivityIndicate)::viewWillAppear:currentViewController=%@", self);
  VariableStore.sharedInstance.currentViewControllerDelegate = self;
  self.kassVS.user.delegate = self;
}

- (void)viewDidLoad
{
// this was to make sure that the indicator hides when it should
//  DLog(@"UIViewController (ActivityIndicate)::viewDidLoad:delegate=%@", self.class);
  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: UI_IMAGE_NAVIGATION_BACKGROUND]forBarMetrics:UIBarMetricsDefault];
  
  if( [self kassVS] && [[self kassVS] isLoggedIn ] )
    [self currentUser].delegate = self;
}

@end
