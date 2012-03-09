//
//  UIViewController+ActivityIndicate.h
//  Demo
//
//  Created by Qi He on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountActivityDelegate.h"
#import "KassAppDelegate.h"

@interface UIViewController (ActivityIndicate) <AccountActivityDelegate, KassAppDelegate>

- (void) showLoadingIndicator;
- (void) showIndicator:(NSString *)msg;
- (void) hideIndicator;

- (void) viewDidLoad;

@end
