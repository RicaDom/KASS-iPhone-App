//
//  CommonView.m
//  Demo
//
//  Created by Wesley Wang on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CommonView.h"

@implementation CommonView

+(void) setMessageWithPriceView:(UIView *)bottomView priceButton:(UIButton *)priceButton messageField:(UITextField *)messageTextField
{
    // Bottom view load
    UIImage *bottomViewImg = [UIImage imageNamed:UI_IMAGE_SEND_MESSAGE_BACKGROUND];
    bottomView.frame = CGRectMake(0, bottomView.frame.origin.y, bottomViewImg.size.width, bottomViewImg.size.height + 15);
    [bottomView setBackgroundColor:[[UIColor alloc] initWithPatternImage:bottomViewImg]];

    UIImage *priceButtonImg = [UIImage imageNamed:UI_IMAGE_SEND_MESSAGE_PRICE];
    UIImage *priceButtonPressImg = [UIImage imageNamed:UI_IMAGE_SEND_MESSAGE_PRICE_PRESS];
    priceButton.frame = CGRectMake(priceButton.frame.origin.x, priceButton.frame.origin.y, priceButtonImg.size.width, priceButtonImg.size.height);
    [priceButton setImage:priceButtonImg forState:UIControlStateNormal];
    [priceButton setImage:priceButtonPressImg forState:UIControlStateSelected];
    [priceButton setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:UI_IMAGE_SEND_MESSAGE_PRICE]]];

    messageTextField.frame = CGRectMake(priceButton.frame.size.width + 15, priceButton.frame.origin.y, bottomView.frame.size.width - priceButton.frame.size.width - 20, priceButton.frame.size.height);
}
@end
