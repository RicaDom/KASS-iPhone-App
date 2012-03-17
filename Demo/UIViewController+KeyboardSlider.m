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

- (BOOL)registerKeyboardSliderWithConfirmView:(UIView *)mainView:(UIScrollView *)scrollView:(UIView *)bottomView:(UIView *)confirmView
{
  [[KeyboardSlider currentSlider] registerKeyboardSliderWithConfirmView:self:mainView:scrollView:bottomView:confirmView];
  // register for keyboard notifications
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) 
                                               name:UIKeyboardWillShowNotification object:self.view.window];
  return TRUE;
}


- (BOOL)registerKeyboardSlider:(UIView *)mainView:(UIScrollView *)scrollView:(UIView *)bottomView
{
  [[KeyboardSlider currentSlider] registerKeyboardSlider:self :mainView :scrollView :bottomView];
  
  // register for keyboard notifications
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) 
                                               name:UIKeyboardWillShowNotification object:self.view.window];
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

- (void)unregisterKeyboardSlider
{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 
  [KeyboardSlider.currentSlider unregiser];
}

- (BOOL)shouldKeyboardViewMoveUp
{
  DLog(@"UIViewController+KeyboardSlider::shouldKeyboardShow");
  return YES;
}

- (void)keyboardWillShow:(NSNotification *)notification
{
  //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
  CGRect keyboardRect = [[[notification userInfo] objectForKey:_UIKeyboardFrameEndUserInfoKey] CGRectValue];
  [self registerKeyboardSliderRect:keyboardRect];
  
  if ( [self shouldKeyboardViewMoveUp] ) {
    [self showKeyboardAndMoveViewUp];
  }
  
}


@end
