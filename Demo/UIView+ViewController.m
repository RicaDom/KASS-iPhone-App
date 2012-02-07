//
//  UIView+ViewController.m
//  Demo
//
//  Created by Qi He on 12-2-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)
- (UIViewController *) firstAvailableUIViewController {
  // convenience function for casting and to "mask" the recursive function
  return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id) traverseResponderChainForUIViewController {
  id nextResponder = [self nextResponder];
  if ([nextResponder isKindOfClass:[UIViewController class]]) {
    return nextResponder;
  } else if ([nextResponder isKindOfClass:[UIView class]]) {
    return [nextResponder traverseResponderChainForUIViewController];
  } else {
    return nil;
  }
}
@end
