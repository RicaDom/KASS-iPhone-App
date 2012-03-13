//
//  KeyboardSlider.h
//  Demo
//
//  Created by Qi He on 12-3-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyboardSliderDelegate.h"


typedef enum {
  KeyboardSliderViewIsDown,
  KeyboardSliderViewIsUp
} KeyboardSliderViewState ;

@interface KeyboardSlider : NSObject
{
  CGRect _keyboardRect; 
  KeyboardSliderViewState _state;
}

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIView *confirmView;

@property (nonatomic,assign)  id<KeyboardSliderDelegate> delegate;

+ (KeyboardSlider *)currentSlider;

- (BOOL)registerKeyboardSlider:(id<KeyboardSliderDelegate>)delegate:(UIView *)mainView:(UIScrollView *)scrollView:(UIView *)bottomView;

- (BOOL)registerKeyboardSliderWithConfirmView:(id<KeyboardSliderDelegate>)delegate:(UIView *)mainView:(UIScrollView *)scrollView:(UIView *)bottomView:(UIView *)confirmView;

- (BOOL)registerKeyboardRect:(CGRect)keyboardRect;

- (void)moveViewUp;
- (void)moveViewDown;

- (void)unregiser;

@end
