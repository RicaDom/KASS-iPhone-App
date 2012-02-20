//
//  ViewHelper.m
//  Demo
//
//  Created by Qi He on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewHelper.h"

@implementation ViewHelper

+ (NSString *)getTitleFromOfferMessage:(User *)user:(Offer *)offer:(int)index
{
  Message *message = [offer.messages objectAtIndex:index];
  
  NSString *title;
  
  if ([user.userId isEqualToString:message.userId]) {
    title = @"您";
  }else if([offer.buyerId isEqualToString:message.userId]) {
    title = @"买家";
  }else{
    title = @"卖家";
  }
  
  return title;
}


+ (void) buildOfferScrollView:(IBOutlet UIScrollView *)scrollView:(User *)user:(Offer *)offer
{
  CGFloat yOffset = 155;
  
  UIImage *line = [UIImage imageNamed:@"line.png"];
  UIImageView *imageView = [[UIImageView alloc] initWithImage:line];
  imageView.frame = CGRectMake(3, yOffset + 10, imageView.frame.size.width, imageView.frame.size.height);
  [scrollView addSubview:imageView];
  yOffset += 10;
  
  for (int i=0; i< [offer.messages count]; i++) {
    
    yOffset += 5;
    
    Message *message = [offer.messages objectAtIndex:i];
    NSString *title = [ViewHelper getTitleFromOfferMessage:user:offer:i];
    
    // Header title
    UILabel* lblHeaderTitle = [[UILabel alloc] initWithFrame:CGRectMake(8, yOffset, 310, 21)];
    [lblHeaderTitle setText:[NSString stringWithFormat:@"%@ %@", title, message.body]];
    [lblHeaderTitle setTextColor:[UIColor blackColor]];[lblHeaderTitle setTextAlignment:UITextAlignmentLeft];
    [lblHeaderTitle setBackgroundColor:[UIColor lightGrayColor]];
    //[lblHeaderTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16.0f]];
    [scrollView addSubview:lblHeaderTitle];
    
    // line
    UIImage *line = [UIImage imageNamed:@"line.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:line];
    imageView.frame = CGRectMake(3, yOffset + 25, imageView.frame.size.width, imageView.frame.size.height);
    [scrollView addSubview:imageView];
    
    //INCREMNET in yOffset 
    yOffset += 30;
    
    [scrollView setContentSize:CGSizeMake(320, yOffset)];    
  }

}

@end
