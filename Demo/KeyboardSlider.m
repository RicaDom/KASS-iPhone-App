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
@synthesize viewController  = _viewController;

static KeyboardSlider *ks = nil;

+ (KeyboardSlider *)currentSlider
{
  if (ks == nil) {
    ks = [[KeyboardSlider alloc] init];
  }
  return ks;
}

- (BOOL)registerKeyboardSlider:(UIViewController *)vc:(IBOutlet UIView *)mainView:(IBOutlet UIScrollView *)scrollView:(IBOutlet UIView *)bottomView
{
  _scrollView   = scrollView;
  _mainView     = mainView;
  _bottomView   = bottomView;
  _viewController = vc;
  
  return TRUE; 
}

- (BOOL)registerKeyboardRect:(CGRect)keyboardRect
{
  _keyboardRect = keyboardRect;
  return TRUE; 
}

- (void)moveViewDown
{
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:0.5]; // if you want to slide up the view
  
  CGRect rect = _mainView.frame;
  
  rect.origin.y += (_keyboardRect.size.height - _viewController.tabBarController.tabBar.frame.size.height);
  rect.size.height -= _keyboardRect.size.height;
  _viewController.navigationItem.leftBarButtonItem.title = UI_BUTTON_LABEL_BACK;
  _viewController.navigationItem.rightBarButtonItem.title = UI_BUTTON_LABEL_MAP;
  _mainView.frame = rect;
  
  CGRect scrollViewRect = self.scrollView.frame;
  
  scrollViewRect.origin.y = 0;
  scrollViewRect.size.height = rect.size.height - _bottomView.frame.size.height;
  
  self.scrollView.frame = scrollViewRect;      
  
  [UIView commitAnimations];
}

- (void)moveViewUp
{
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDuration:0.5]; // if you want to slide up the view
  
  CGRect rect = _mainView.frame;
  
  // 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
  // 2. increase the size of the view so that the area behind the keyboard is covered up.
  rect.origin.y -= (_keyboardRect.size.height - _viewController.tabBarController.tabBar.frame.size.height);
  rect.size.height += _keyboardRect.size.height;
  _viewController.navigationItem.leftBarButtonItem.title = UI_BUTTON_LABEL_CANCEL;
  _viewController.navigationItem.rightBarButtonItem.title = UI_BUTTON_LABEL_SEND;
  
  _mainView.frame = rect;
  
  CGRect scrollViewRect = _scrollView.frame;
  
  scrollViewRect.origin.y -= _viewController.tabBarController.tabBar.frame.size.height;
  scrollViewRect.size.height = rect.size.height - _keyboardRect.size.height*2; 
  
  _scrollView.frame = scrollViewRect;
  
  [UIView commitAnimations];

}

@end
