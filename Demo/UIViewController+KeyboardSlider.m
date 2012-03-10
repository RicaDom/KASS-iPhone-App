//
//  UIViewController+KeyboardSlide.m
//  Demo
//
//  Created by Qi He on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+KeyboardSlider.h"
#import "KeyboardSlider.h"
#import "Constants.h"

@implementation UIViewController (KeyboardSlider)

- (void)textViewDidChangeSelection:(UITextView *)textView
{
  [self hideKeyboardAndMoveViewDown];
}

- (void)showKeyboardAndMoveViewUp
{
  [[KeyboardSlider currentSlider] moveViewUp];
}

- (void)hideKeyboardAndMoveViewDown
{
  [[KeyboardSlider currentSlider] moveViewDown];
}

- (BOOL)registerKeyboardSlider:(IBOutlet UIView *)mainView:(IBOutlet UIScrollView *)scrollView:(IBOutlet UIView *)bottomView
{
  [[KeyboardSlider currentSlider] registerKeyboardSlider:self :mainView :scrollView :bottomView];
  return TRUE;
}

- (BOOL)registerKeyboardSliderRect:(CGRect)keyboardRect
{
  [[KeyboardSlider currentSlider] registerKeyboardRect:keyboardRect];
  return TRUE;
}

- (BOOL)registerKeyboardSliderTextView:(UITextView *)textView
{
  [textView setDelegate:self];
  return TRUE;
}


@end
