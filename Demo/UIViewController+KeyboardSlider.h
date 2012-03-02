//
//  UIViewController+KeyboardSlide.h
//  Demo
//
//  Created by Qi He on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (KeyboardSlider)

- (void)showKeyboardAndMoveViewUp;
- (void)hideKeyboardAndMoveViewDown;

- (BOOL)registerKeyboardSlider:(IBOutlet UIView *)mainView:(IBOutlet UIScrollView *)scrollView
                              :(IBOutlet UIView *)bottomView;

- (BOOL)registerKeyboardRect:(CGRect)keyboardRect;


@end
