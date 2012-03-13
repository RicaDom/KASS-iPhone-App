//
//  KeyboardSlider.m
//  Demo
//
//  Created by Qi He on 12-3-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KeyboardSlider.h"
#import "Constants.h"

@implementation KeyboardSlider

@synthesize scrollView      = _scrollView;
@synthesize mainView        = _mainView;
@synthesize bottomView      = _bottomView;
@synthesize delegate        = _delegate;
@synthesize confirmView     = _confirmView;

static KeyboardSlider *ks = nil;

+ (KeyboardSlider *)currentSlider
{
  if (ks == nil) {
    ks = [[KeyboardSlider alloc] init];
  }
  return ks;
}

- (BOOL)registerKeyboardSlider:(id<KeyboardSliderDelegate>)delegate:(UIView *)mainView:(UIScrollView *)scrollView:(UIView *)bottomView
{
  _scrollView   = scrollView;
  _mainView     = mainView;
  _bottomView   = bottomView;
  _delegate     = delegate;
  _state        = KeyboardSliderViewIsDown;
  return TRUE; 
}

- (BOOL)registerKeyboardSliderWithConfirmView:(id<KeyboardSliderDelegate>)delegate:(UIView *)mainView:(UIScrollView *)scrollView:(UIView *)bottomView:(UIView *)confirmView
{
  _confirmView  = confirmView;
  return [self registerKeyboardSlider:delegate:mainView:scrollView:bottomView];
}

- (BOOL)registerKeyboardRect:(CGRect)keyboardRect
{
  _keyboardRect = keyboardRect;
  return TRUE; 
}

- (void)unregiser
{
  _scrollView   = nil;
  _mainView     = nil;
  _bottomView   = nil;
  _delegate     = nil;
  ks            = nil;
}

- (void)moveViewDown
{
  if ( _state == KeyboardSliderViewIsDown ) { return; }
  
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:0.5]; // if you want to slide up the view
  
  CGRect rect = _mainView.frame;
  
  int height = _confirmView ? _keyboardRect.size.height - self.confirmView.frame.size.height : _keyboardRect.size.height;
  
  rect.origin.y += height;
  rect.size.height -= _keyboardRect.size.height;
  _mainView.frame = rect;
  
  CGRect scrollViewRect = self.scrollView.frame;
  
  scrollViewRect.origin.y = 0;
  scrollViewRect.size.height = rect.size.height - _bottomView.frame.size.height;
  
  self.scrollView.frame = scrollViewRect;      
  
  [UIView commitAnimations];
  
  _state = KeyboardSliderViewIsDown;
 
  if( [_delegate respondsToSelector:@selector(keyboardMainViewMovedDown)] )
    [_delegate keyboardMainViewMovedDown];
  
}

- (void)moveViewUp
{
  if ( _state == KeyboardSliderViewIsUp ) { return; }
  
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:0.5]; // if you want to slide up the view
  
  CGRect rect = _mainView.frame;
  
  // 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
  // 2. increase the size of the view so that the area behind the keyboard is covered up.
  int height = _confirmView ? _keyboardRect.size.height - self.confirmView.frame.size.height : _keyboardRect.size.height;
  
  rect.origin.y -= height;
  rect.size.height += _keyboardRect.size.height;
  
  _mainView.frame = rect;
  
  CGRect scrollViewRect = _scrollView.frame;
  
  scrollViewRect.origin.y = height;
  scrollViewRect.size.height = rect.size.height - _keyboardRect.size.height*2 - _bottomView.frame.size.height; 
    
  _scrollView.frame = scrollViewRect;
  
  [UIView commitAnimations];
  
  _state = KeyboardSliderViewIsUp;
  
  if( [_delegate respondsToSelector:@selector(keyboardMainViewMovedUp)] )
    [_delegate keyboardMainViewMovedUp];
  
}

@end
