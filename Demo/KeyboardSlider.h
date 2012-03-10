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

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic,assign)  id<KeyboardSliderDelegate> delegate;

+ (KeyboardSlider *)currentSlider;

- (BOOL)registerKeyboardSlider:(id<KeyboardSliderDelegate>)delegate:(IBOutlet UIView *)mainView:(IBOutlet UIScrollView *)scrollView:(IBOutlet UIView *)bottomView;

- (BOOL)registerKeyboardRect:(CGRect)keyboardRect;

- (void)moveViewUp;
- (void)moveViewDown;

@end
