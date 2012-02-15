//
//  UIViewController+ActivityIndicate.h
//  Demo
//
//  Created by Qi He on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ActivityIndicate)

- (void) showLoadingIndicator;
- (void) showIndicator:(NSString *)msg;
- (void) hideIndicator;

@end
