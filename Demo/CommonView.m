//
//  CommonView.m
//  Demo
//
//  Created by Wesley Wang on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CommonView.h"

@implementation CommonView

+(void) setMessageWithPriceView:(UIScrollView *)scrollView payImage:(UIImageView *)payImage bottomView:(UIView *)bottomView priceButton:(UIButton *)priceButton messageField:(UITextField *)messageTextField price:(NSString *)price changedPriceMessage:(UILabel *)changedPriceMessage
{
    // Bottom view load
    UIImage *tempSmall = [UIImage imageNamed:UI_IMAGE_SEND_MESSAGE_BACKGROUND];
    UIImage *tempLarge = [UIImage imageNamed:UI_IMAGE_SEND_MESSAGE_BACKGROUND_EXT];
    
    UIImage *bottomViewImg = (price == nil || [price length] <= 0)? tempSmall : tempLarge;
    [bottomView setBackgroundColor:[[UIColor alloc] initWithPatternImage:bottomViewImg]];
    
    if (payImage != nil) {
        bottomView.frame = CGRectMake(0, payImage.frame.origin.y - bottomViewImg.size.height, bottomViewImg.size.width, bottomViewImg.size.height);
        
        scrollView.frame = CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, scrollView.frame.size.width, bottomView.frame.origin.y + 64);
    } else {
        bottomView.frame = CGRectMake(0, ([price length] > 0 && [changedPriceMessage.text length] <= 0) ? bottomView.frame.origin.y - tempLarge.size.height + tempSmall.size.height  : bottomView.frame.origin.y, bottomViewImg.size.width, bottomViewImg.size.height);
    }
    
    // add text field if user changed price
    if ([price length] > 0) {
        changedPriceMessage.frame = CGRectMake(0,  2, bottomView.frame.size.width, 20);
        [changedPriceMessage setText:[@"您已经把价格调整为 ¥ " stringByAppendingFormat:price ]];      
        [changedPriceMessage setTextColor:[UIColor lightGrayColor]];
        changedPriceMessage.backgroundColor = [UIColor clearColor];
        [changedPriceMessage setTextAlignment:UITextAlignmentCenter];
        changedPriceMessage.font = [UIFont boldSystemFontOfSize:13];
        changedPriceMessage.hidden = NO;
        //[bottomView addSubview:changedPriceMessage];
    }
    
    UIImage *priceButtonImg = [UIImage imageNamed:UI_IMAGE_SEND_MESSAGE_PRICE];
    UIImage *priceButtonPressImg = [UIImage imageNamed:UI_IMAGE_SEND_MESSAGE_PRICE_PRESS];
    priceButton.frame = CGRectMake(8, ([price length] > 0)?32:5, priceButtonImg.size.width, priceButtonImg.size.height);
    [priceButton setImage:priceButtonImg forState:UIControlStateNormal];
    [priceButton setImage:priceButtonPressImg forState:UIControlStateSelected];
    [priceButton setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:UI_IMAGE_SEND_MESSAGE_PRICE]]];

    messageTextField.frame = CGRectMake(priceButton.frame.size.width + 15, priceButton.frame.origin.y, bottomView.frame.size.width - priceButton.frame.size.width - 20, priceButton.frame.size.height);
}

@end
