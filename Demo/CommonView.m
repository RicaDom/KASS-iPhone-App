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
    NSString *price = @"abc";
    int delta = 20;
    // Bottom view load
    UIImage *bottomViewImg = [UIImage imageNamed:(price == nil || [price length] <= 0)?UI_IMAGE_SEND_MESSAGE_BACKGROUND:UI_IMAGE_SEND_MESSAGE_BACKGROUND];
    [bottomView setBackgroundColor:[[UIColor alloc] initWithPatternImage:bottomViewImg]];
    bottomView.frame = CGRectMake(0, bottomView.frame.origin.y, bottomViewImg.size.width, bottomViewImg.size.height+20);

    // add text field if user changed price
    if ([price length] > 0) {
        // Time title
        UILabel* messageTime = [[UILabel alloc] initWithFrame:CGRectMake(0,  0, bottomView.frame.size.width, 20)];
        [messageTime setText:@"—————— 你已经把价格调整为 ¥89 ——————"];      
        [messageTime setTextColor:[UIColor whiteColor]];
        messageTime.backgroundColor = [UIColor clearColor];
        [messageTime setTextAlignment:UITextAlignmentCenter];
        messageTime.font = [UIFont systemFontOfSize:13];
        [bottomView addSubview:messageTime];
    }
    
    UIImage *priceButtonImg = [UIImage imageNamed:UI_IMAGE_SEND_MESSAGE_PRICE];
    UIImage *priceButtonPressImg = [UIImage imageNamed:UI_IMAGE_SEND_MESSAGE_PRICE_PRESS];
    priceButton.frame = CGRectMake(priceButton.frame.origin.x+8, priceButton.frame.origin.y+3+delta, priceButtonImg.size.width, priceButtonImg.size.height);
    [priceButton setImage:priceButtonImg forState:UIControlStateNormal];
    [priceButton setImage:priceButtonPressImg forState:UIControlStateSelected];
    [priceButton setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:UI_IMAGE_SEND_MESSAGE_PRICE]]];

    messageTextField.frame = CGRectMake(priceButton.frame.size.width + 15, priceButton.frame.origin.y, bottomView.frame.size.width - priceButton.frame.size.width - 20, priceButton.frame.size.height);
}

@end
