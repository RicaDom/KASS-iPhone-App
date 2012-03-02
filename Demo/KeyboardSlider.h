//
//  KeyboardSlider.h
//  Demo
//
//  Created by Qi He on 12-3-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyboardSlider : NSObject
{
  CGRect _keyboardRect; 
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) UIViewController *viewController;

+ (KeyboardSlider *)currentSlider;

- (BOOL)registerKeyboardSlider:(UIViewController *)vc:(IBOutlet UIView *)mainView:(IBOutlet UIScrollView *)scrollView:(IBOutlet UIView *)bottomView;

- (BOOL)registerKeyboardRect:(CGRect)keyboardRect;

- (void)moveViewUp;
- (void)moveViewDown;

@end
