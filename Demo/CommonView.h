//
//  CommonView.h
//  Demo
//
//  Created by Wesley Wang on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface CommonView : NSObject

+(void) setMessageWithPriceView:(UIScrollView *)scrollView payImage:(UIView *)payImage bottomView:(UIView *)bottomView priceButton:(UIButton *)priceButton messageField:(UITextField *)messageTextField price:(NSString *)price changedPriceMessage:(UILabel *)changedPriceMessage;

@end
