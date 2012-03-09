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

//- (void)showErrorAlert:(NSString *)message
//{
//  UIAlertView *alert = [[UIAlertView alloc] init];
//	[alert setTitle:UI_LABEL_ERROR];
//	[alert setMessage:message];
//  [alert setDelegate:self];
//  [alert addButtonWithTitle:UI_LABEL_CONFIRM];
//  [alert show];
//}
//
//- (void)showErrorMessageAlert:(NSDictionary *)errors
//{
//  NSString *errorMsgs = nil;
//  NSString *errorKey  = nil;
//  for (NSString *k in errors) {
//    errorKey  = k;
//    errorMsgs = [errors valueForKey:errorKey];
//    break;
//  }
//  
//  if ( !errorMsgs || !errorKey ) { return; }
//  
//  if ( [errorMsgs isKindOfClass:NSArray.class]) {
//    NSArray *errorArray = (NSArray *)errorMsgs;
//    if ([errorArray count] > 0) {
//      NSString *err = [[NSString alloc] initWithFormat:@"%@ %@", errorKey, [errorArray objectAtIndex:0]];
//      [self showErrorAlert:err]; 
//    }
//  }else if ( [errorMsgs isKindOfClass:NSString.class] ){ 
//    NSString *err = [[NSString alloc] initWithFormat:@"%@ %@", errorKey, errorMsgs];
//    [self showErrorAlert:err ]; 
//  }
//}

- (void)accountRequestFailed:(NSDictionary *)errors
{
  DLog(@"UIViewController (ActivityIndicate)::accountRequestFailed");
  [self hideIndicator];
  [ViewHelper showErrorMessageAlert:errors:self];
}

- (void)appRequestFailed:(NSDictionary *)errors
{
  DLog(@"UIViewController (ActivityIndicate)::appRequestFailed");
  [self hideIndicator];
  [ViewHelper showErrorMessageAlert:errors:self];
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
//  DLog(@"UIViewController (ActivityIndicate)::viewDidLoad:delegate=%@", self);
//  if( [self kassVS] && [[self kassVS] isLoggedIn ] )
//    [self currentUser].delegate = self;
}

@end
