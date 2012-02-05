//
//  MTPopupWindow.h
//  PopupWindowProject
//
//  Created by Marin Todorov on 7/1/11.
//  Copyright 2011 Marin Todorov. MIT license
//  http://www.opensource.org/licenses/mit-license.php
//  

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface MTPopupWindow : NSObject
//{
//    UIView* bgView;
//    UIView* bigPanelView;
//}
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIView* bigPanelView;
@property (nonatomic, strong) UIView* signUpView;
@property (nonatomic, strong) UIView* signInView;
@property (nonatomic, strong) MTPopupWindow *mtWindow;
+(void)showWindowWithHTMLFile:(NSString*)fileName insideView:(UIView*)view;
+(void)showWindowWithUIView:(UIView*)view;
@end
