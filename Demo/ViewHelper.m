//
//  ViewHelper.m
//  Demo
//
//  Created by Qi He on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewHelper.h"
#import "NSString+ModelHelper.h"
#import "Offer+OfferHelper.h"
#import "HJManagedImageV.h"
#import "VariableStore.h"

@implementation ViewHelper

+ (NSString *)getTitleFromOfferMessage:(User *)user:(Offer *)offer:(Message *)message
{
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

+ (UIView *) buildDefaultImageView:(UIView *)diglogView:(NSString *)url
{
  UIImage *userImg = [UIImage imageNamed:url];
  UIImageView *userImgView = [[UIImageView alloc] initWithImage:userImg];
  userImgView.frame = CGRectMake(5, 5, 60, 60);
  [diglogView addSubview:userImgView];
  return userImgView;
}

+ (UIView *) buildDialogAvatar:(UIView *)diglogView:(User *)user:(Offer *)offer:(Message *)message
{
  if([offer.buyerId isEqualToString:message.userId]) {
    if (offer.buyerImageUrl && offer.buyerImageUrl.isPresent) {
      HJManagedImageV *imgV = [offer getHJManagedImageView:message:CGRectMake(5, 5, 60, 60)];
      [imgV showLoadingWheel];
      [diglogView addSubview:imgV];
      return imgV;
    }else {
      return [self buildDefaultImageView:diglogView:UI_IMAGE_MESSAGE_DEFAULT_BUYER];
    }
  }else if([offer.userId isEqualToString:message.userId]){
    if (offer.sellerImageUrl && offer.sellerImageUrl.isPresent) {
      HJManagedImageV *imgV = [offer getHJManagedImageView:message:CGRectMake(5, 5, 60, 60)];
      [imgV showLoadingWheel];
      [diglogView addSubview:imgV];
      return imgV;
    }else {
      return [self buildDefaultImageView:diglogView:UI_IMAGE_MESSAGE_DEFAULT_USER];
    }
  }else {
    return [self buildDefaultImageView:diglogView:UI_IMAGE_MESSAGE_DEFAULT_USER];
  }
}

+ (void) buildListItemPayNowCell:(ListItem *)item:(ListingTableCell *)cell
{
  UIButton *buttonPayNow = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  buttonPayNow.frame = CGRectMake(5, 5, 60, 20.0);
  [buttonPayNow setTitle:UI_BUTTON_LABEL_PAY_NOW forState:UIControlStateNormal];
  [buttonPayNow setTitleColor: [UIColor orangeColor] forState: UIControlStateNormal];
  [cell.infoView addSubview:buttonPayNow];     
  
  UILabel *labelAskPrice = [[UILabel alloc] init];  
  if (item.askPrice != nil && item.askPrice > 0) {
    [labelAskPrice setText:[@"¥ " stringByAppendingFormat: [item.askPrice stringValue]]];
  }
  
  [labelAskPrice setTextColor:[UIColor blackColor]];
  labelAskPrice.frame = CGRectMake(0, cell.infoView.frame.size.height/2 - 6, cell.infoView.frame.size.width, cell.infoView.frame.size.height / 2 - 5);
  labelAskPrice.textAlignment = UITextAlignmentCenter;
  labelAskPrice.font = [UIFont boldSystemFontOfSize:16];
  labelAskPrice.backgroundColor = [UIColor clearColor];
  [cell.infoView addSubview:labelAskPrice];            
}

+ (void) buildListItemNoOffersCell:(ListItem *)item:(ListingTableCell *)cell
{
  UILabel *labelWaiting = [[UILabel alloc] init];
  [labelWaiting setText:UI_LABEL_WAITING_FOR_OFFER];
  [labelWaiting setTextColor:[UIColor brownColor]];
  [labelWaiting setBackgroundColor:[UIColor clearColor]];
  labelWaiting.font = [UIFont boldSystemFontOfSize:13];
  labelWaiting.frame = CGRectMake(0, 0, cell.infoView.frame.size.width, cell.infoView.frame.size.height / 2 - 8);
  labelWaiting.textAlignment = UITextAlignmentCenter;

  [cell.infoView addSubview:labelWaiting]; 
  UILabel *labelAskPrice = [[UILabel alloc] init];
  if (item.askPrice != nil && item.askPrice > 0) {
      [labelAskPrice setText:[@"¥ " stringByAppendingFormat: [item.askPrice stringValue]]];
  }
  [labelAskPrice setTextColor:[UIColor blackColor]];
  labelAskPrice.font = [UIFont boldSystemFontOfSize:16];
  labelAskPrice.backgroundColor = [UIColor clearColor];
  labelAskPrice.frame = CGRectMake(0, cell.infoView.frame.size.height/2 - 12, cell.infoView.frame.size.width, cell.infoView.frame.size.height / 2 - 5);
  labelAskPrice.textAlignment = UITextAlignmentCenter;
  [cell.infoView addSubview:labelAskPrice]; 
  
  UILabel *labelExpiredDate = [[UILabel alloc] init];
  [labelExpiredDate setText:item.getTimeLeftTextlong];
  [labelExpiredDate setTextColor:[UIColor brownColor]];
  labelExpiredDate.backgroundColor = [UIColor clearColor];
  labelExpiredDate.font = [UIFont boldSystemFontOfSize:13];
  labelExpiredDate.frame = CGRectMake(0, cell.infoView.frame.size.height/2 + 10, cell.infoView.frame.size.width, cell.infoView.frame.size.height / 2 - 8);
  labelExpiredDate.textAlignment = UITextAlignmentCenter;
  [cell.infoView addSubview:labelExpiredDate]; 
}

+ (void) buildListItemHasOffersCell:(ListItem *)item:(ListingTableCell *)cell
{ 
  UILabel *labelNeedsReview = [[UILabel alloc] init];
  [labelNeedsReview setText:UI_LABEL_NEEDS_REVIEW];
  [labelNeedsReview setTextColor:[UIColor brownColor]];
  [labelNeedsReview setBackgroundColor:[UIColor clearColor]];
  labelNeedsReview.font = [UIFont boldSystemFontOfSize:13];
  labelNeedsReview.frame = CGRectMake(0, 3, cell.infoView.frame.size.width, cell.infoView.frame.size.height/2);
  labelNeedsReview.textAlignment = UITextAlignmentCenter;
  //[labelNeedsReview sizeToFit];
  [cell.infoView addSubview:labelNeedsReview];    
  
  UILabel *labelOffersCount = [[UILabel alloc] init];
  [labelOffersCount setText:[[NSString alloc] initWithFormat:@"%d %@", [item.offers count], UI_LABEL_OFFER]];
  [labelOffersCount setTextColor:[UIColor blackColor]];
  [labelOffersCount setBackgroundColor:[UIColor clearColor]];
  labelOffersCount.font = [UIFont boldSystemFontOfSize:16];
  labelOffersCount.frame = CGRectMake(0, 25, cell.infoView.frame.size.width, cell.infoView.frame.size.height / 2 - 5);
  labelOffersCount.textAlignment = UITextAlignmentCenter;
  //[labelOffersCount sizeToFit];
  [cell.infoView addSubview:labelOffersCount];  
}

+ (void) buildListItemExpiredCell:(ListItem *)item:(ListingTableCell *)cell
{    
    UILabel *labelOffersCount = [[UILabel alloc] init];
    [labelOffersCount setText:[[NSString alloc] initWithFormat:@"%d %@", [item.offers count], UI_LABEL_OFFER]];
    [labelOffersCount setTextColor:[UIColor blackColor]];
    [labelOffersCount setBackgroundColor:[UIColor clearColor]];
    labelOffersCount.font = [UIFont boldSystemFontOfSize:13];
    labelOffersCount.frame = CGRectMake(0, 0, cell.infoView.frame.size.width, cell.infoView.frame.size.height / 2 - 8);
    labelOffersCount.textAlignment = UITextAlignmentCenter;
    [cell.infoView addSubview:labelOffersCount];  
     
    UILabel *labelAskPrice = [[UILabel alloc] init];
    if (item.askPrice != nil && item.askPrice > 0) {
        [labelAskPrice setText:[@"¥ " stringByAppendingFormat: [item.askPrice stringValue]]];
    }
    [labelAskPrice setTextColor:[UIColor blackColor]];
    labelAskPrice.font = [UIFont boldSystemFontOfSize:13];
    labelAskPrice.backgroundColor = [UIColor clearColor];
    labelAskPrice.frame = CGRectMake(0, cell.infoView.frame.size.height/2 + 10, cell.infoView.frame.size.width, cell.infoView.frame.size.height / 2 - 8);
    labelAskPrice.textAlignment = UITextAlignmentCenter;
    [cell.infoView addSubview:labelAskPrice]; 
    
    UILabel *labelExpiredDate = [[UILabel alloc] init];
    [labelExpiredDate setText:@"已经过期"];
    [labelExpiredDate setTextColor:[UIColor brownColor]];
    labelExpiredDate.backgroundColor = [UIColor clearColor];
    labelExpiredDate.font = [UIFont boldSystemFontOfSize:16];
    labelExpiredDate.frame = CGRectMake(0, cell.infoView.frame.size.height/2 - 12, cell.infoView.frame.size.width, cell.infoView.frame.size.height / 2 - 5);
    labelExpiredDate.textAlignment = UITextAlignmentCenter;
    [cell.infoView addSubview:labelExpiredDate]; 
}

+ (void) buildOfferPendingCell:(Offer *)item:(ListingTableCell *)cell
{
  [cell.infoView setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:UI_IMAGE_ACTIVITY_PRICE_BG]]];   
  UILabel *labelPending = [[UILabel alloc] init];
  [labelPending setText:UI_LABEL_OFFER_PENDING];
  [labelPending setTextColor:[UIColor brownColor]];
  labelPending.frame = CGRectMake(0, 0, cell.infoView.frame.size.width, cell.infoView.frame.size.height / 2 - 8);
  labelPending.textAlignment = UITextAlignmentCenter;
  labelPending.backgroundColor = [UIColor clearColor];
  labelPending.font = [UIFont boldSystemFontOfSize:13];
  [cell.infoView addSubview:labelPending]; 
  
  UILabel *labelAskPrice = [[UILabel alloc] init];
  
  if (item.price != nil && item.price > 0) {
    [labelAskPrice setText:[@"¥ " stringByAppendingFormat: [item.price stringValue]]];
  }
  
  [labelAskPrice setTextColor:[UIColor blackColor]];
  labelAskPrice.frame = CGRectMake(0, cell.infoView.frame.size.height/2 - 12, cell.infoView.frame.size.width, cell.infoView.frame.size.height / 2 - 5);
  labelAskPrice.textAlignment = UITextAlignmentCenter;
  labelAskPrice.backgroundColor = [UIColor clearColor];
  labelAskPrice.font = [UIFont boldSystemFontOfSize:16];
  [cell.infoView addSubview:labelAskPrice]; 
  
  UILabel *labelOfferer = [[UILabel alloc] init];
  [labelOfferer setText:([item.state isEqualToString: OFFER_STATE_REJECTED] ? UI_LABEL_BUYER_OFFERED : UI_LABEL_YOU_OFFERED)];
  
  [labelOfferer setTextColor:[UIColor brownColor]];
  labelOfferer.frame = CGRectMake(0, cell.infoView.frame.size.height/2 + 10, cell.infoView.frame.size.width, cell.infoView.frame.size.height / 2 - 8);
  labelOfferer.textAlignment = UITextAlignmentCenter;
  labelOfferer.backgroundColor = [UIColor clearColor];
  labelOfferer.font = [UIFont boldSystemFontOfSize:13];
  [cell.infoView addSubview:labelOfferer]; 
}

+ (void) buildOfferExpiredCell:(Offer *)item:(ListingTableCell *)cell
{
  [cell.infoView setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:UI_IMAGE_ACTIVITY_PRICE_BG]]];   
  UILabel *labelExpired = [[UILabel alloc] init];
  [labelExpired setText:UI_LABEL_EXPIRED];
  [labelExpired setTextColor:[UIColor brownColor]];
  labelExpired.frame = CGRectMake(0, 0, cell.infoView.frame.size.width, cell.infoView.frame.size.height / 2 - 8);
  labelExpired.textAlignment = UITextAlignmentCenter;
  labelExpired.backgroundColor = [UIColor clearColor];
  labelExpired.font = [UIFont boldSystemFontOfSize:13];
  [cell.infoView addSubview:labelExpired]; 
  
  UILabel *labelAskPrice = [[UILabel alloc] init];
  if (item.price != nil && item.price > 0) {
    [labelAskPrice setText:[@"¥ " stringByAppendingFormat:[item.price stringValue]]];
  }
  
  [labelAskPrice setTextColor:[UIColor blackColor]];
  labelAskPrice.frame = CGRectMake(0, cell.infoView.frame.size.height/2 - 12, cell.infoView.frame.size.width, cell.infoView.frame.size.height / 2 - 5);
  labelAskPrice.textAlignment = UITextAlignmentCenter;
  labelAskPrice.backgroundColor = [UIColor clearColor];
  labelAskPrice.font = [UIFont boldSystemFontOfSize:16];
  [cell.infoView addSubview:labelAskPrice]; 
  
  UILabel *labelYouOffered = [[UILabel alloc] init];
  [labelYouOffered setText:UI_LABEL_YOU_OFFERED];
  [labelYouOffered setTextColor:[UIColor brownColor]];
  labelYouOffered.frame = CGRectMake(2, cell.infoView.frame.size.height/2 + 10, cell.infoView.frame.size.width, cell.infoView.frame.size.height / 2 - 8);
  labelYouOffered.textAlignment = UITextAlignmentCenter;
  labelYouOffered.backgroundColor = [UIColor clearColor];
  labelYouOffered.font = [UIFont boldSystemFontOfSize:13];
  [cell.infoView addSubview:labelYouOffered]; 
}

+ (void) buildOfferAcceptedCell:(Offer *)item:(ListingTableCell *)cell
{
  [cell.infoView setBackgroundColor:[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:UI_IMAGE_ACTIVITY_PRICE_BG]]];   
  UILabel *labelAccepted = [[UILabel alloc] init];
  [labelAccepted setText:UI_LABEL_ACCEPTED];
  [labelAccepted setTextColor:[UIColor brownColor]];
  labelAccepted.frame = CGRectMake(0, 0, cell.infoView.frame.size.width, cell.infoView.frame.size.height / 2 - 8);
  labelAccepted.textAlignment = UITextAlignmentCenter;
  labelAccepted.backgroundColor = [UIColor clearColor];
  labelAccepted.font = [UIFont boldSystemFontOfSize:13];
  [cell.infoView addSubview:labelAccepted]; 
  
  UILabel *labelAskPrice = [[UILabel alloc] init];
  if (item.price != nil && item.price > 0) {
    [labelAskPrice setText:[@"¥ " stringByAppendingFormat:[item.price stringValue]]];
  }
  
  [labelAskPrice setTextColor:[UIColor blackColor]];
  labelAskPrice.backgroundColor = [UIColor clearColor];
  labelAskPrice.frame = CGRectMake(0, cell.infoView.frame.size.height/2 - 12, cell.infoView.frame.size.width, cell.infoView.frame.size.height / 2 - 5);
  labelAskPrice.textAlignment = UITextAlignmentCenter;
  labelAskPrice.font = [UIFont boldSystemFontOfSize:16];
  [cell.infoView addSubview:labelAskPrice]; 
  
  UILabel *labelYouOffered = [[UILabel alloc] init];
  [labelYouOffered setText:([item.state isEqualToString: OFFER_STATE_REJECTED] ? UI_LABEL_BUYER_OFFERED : UI_LABEL_YOU_OFFERED)];
  //[labelYouOffered setText:UI_LABEL_YOU_OFFERED];
  [labelYouOffered setTextColor:[UIColor brownColor]];
  labelYouOffered.frame = CGRectMake(0, cell.infoView.frame.size.height/2 + 10, cell.infoView.frame.size.width, cell.infoView.frame.size.height / 2 - 8);
  labelYouOffered.textAlignment = UITextAlignmentCenter;
  labelYouOffered.font = [UIFont boldSystemFontOfSize:13];
  labelYouOffered.backgroundColor = [UIColor clearColor];
  [cell.infoView addSubview:labelYouOffered];
}

+ (KassApp *)viewKassApp
{
  return [VariableStore.sharedInstance kassApp];
}

+ (UIView *)getOfferRow:(UIScrollView *)scrollView:(User *)user:(Offer *)offer:(CGFloat)yOffset:(Message *)message:(NSDateFormatter *)dateFormatter
{
  
  UIView *diglogView = [[UIView alloc] initWithFrame:CGRectMake(0, yOffset, scrollView.frame.size.width, 75)];
  UIView *userImgView = [self buildDialogAvatar:diglogView:user:offer:message];
  
  NSString *title = [ViewHelper getTitleFromOfferMessage:user:offer:message];
  NSString *date=[dateFormatter stringFromDate:message.createdAt];
  
  // Header title
  UILabel* lblHeaderTitle = [[UILabel alloc] initWithFrame:CGRectMake(userImgView.frame.size.width+15, 5, 50, 20)];
  [lblHeaderTitle setText:title];      
  [lblHeaderTitle setTextColor:[UIColor brownColor]];
  lblHeaderTitle.backgroundColor = [UIColor clearColor];
  [lblHeaderTitle setTextAlignment:UITextAlignmentLeft];
  lblHeaderTitle.font = [UIFont boldSystemFontOfSize:13];
  [diglogView addSubview:lblHeaderTitle];
  
  // Time title
  UILabel* messageTime = [[UILabel alloc] initWithFrame:CGRectMake(userImgView.frame.size.width+15 + lblHeaderTitle.frame.size.width + 5, 5, 50, 20)];
  [messageTime setText:date];      
  [messageTime setTextColor:[UIColor blackColor]];
  messageTime.backgroundColor = [UIColor clearColor];
  [messageTime setTextAlignment:UITextAlignmentLeft];
  messageTime.font = [UIFont systemFontOfSize:13];
  [diglogView addSubview:messageTime];
  
  // Message  
  UITextView *messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(userImgView.frame.size.width+8, 25, 230, 50)];  
  messageTextView.text = message.body;
  messageTextView.font = [UIFont boldSystemFontOfSize:15];
  messageTextView.textColor = [UIColor darkGrayColor];
  messageTextView.editable = NO;
  messageTextView.backgroundColor = [UIColor clearColor];
  [diglogView addSubview:messageTextView];     
  
  // line
  UIImage *line = [UIImage imageNamed:UI_IMAGE_MESSAGE_LINE];
  UIImageView *imageView = [[UIImageView alloc] initWithImage:line];
  imageView.frame = CGRectMake(0, diglogView.frame.size.height, scrollView.frame.size.width, imageView.frame.size.height);
  [diglogView addSubview:imageView]; 
  
  return diglogView;
}

+ (void) buildOfferScrollView:(UIScrollView *)scrollView:(User *)user:(Offer *)offer
{
  CGFloat yOffset = 155;
  
  UIImage *line = [UIImage imageNamed:UI_IMAGE_MESSAGE_LINE];
  UIImageView *imageView = [[UIImageView alloc] initWithImage:line];
  imageView.frame = CGRectMake(0, yOffset + 10, scrollView.frame.size.width, imageView.frame.size.height);
  [scrollView addSubview:imageView];
  yOffset += 15;
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
  [dateFormatter setDateStyle:NSDateFormatterLongStyle];
  
  Message *firstMessage = [[Message alloc] initWithOffer:offer];
  UIView *diglogView = [self getOfferRow:scrollView:user:offer:yOffset:firstMessage:dateFormatter];
  yOffset += diglogView.frame.size.height;
  [scrollView addSubview:diglogView];
  [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, yOffset + 5)];  
  
  for (int i=0; i< [offer.messages count]; i++) {
    
    Message *message = [offer.messages objectAtIndex:i];
    
    UIView *diglogView = [self getOfferRow:scrollView:user:offer:yOffset:message:dateFormatter];
    
    //INCREMNET in yOffset 
    yOffset += diglogView.frame.size.height;
      
    [scrollView addSubview:diglogView];
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, yOffset + 5)];    
  }

  [[self viewKassApp] manageObj:offer.sellerImageView];
  [[self viewKassApp] manageObj:offer.buyerImageView];
}

+ (void)buildMapButton:(UIButton *)button
{
  UIImage *mapImg = [UIImage imageNamed:UI_IMAGE_BROWSE_MAP];
  [button setImage:mapImg forState:UIControlStateNormal];
  button.frame = CGRectMake(200, button.frame.origin.y, mapImg.size.width, mapImg.size.height);
}

+ (void)buildBackButton:(UIButton *)button
{
  UIImage *backImg = [UIImage imageNamed:UI_IMAGE_BACK_BUTTON];
  [button setImage:backImg forState:UIControlStateNormal];
  button.frame = CGRectMake(5, button.frame.origin.y, backImg.size.width, backImg.size.height);
}

+ (void)buildCancelButton:(UIButton *)button
{
    UIImage *img = [UIImage imageNamed:UI_IMAGE_CANCEL_BUTTON];
    [button setImage:img forState:UIControlStateNormal];
    button.frame = CGRectMake(5, button.frame.origin.y, img.size.width, img.size.height);
}

+ (void)buildShareButton:(UIButton *)button
{
    UIImage *img = [UIImage imageNamed:UI_IMAGE_SHARE_BUTTON];
    UIImage *imgPress = [UIImage imageNamed:UI_IMAGE_SHARE_BUTTON_PRESS];
    [button setImage:img forState:UIControlStateNormal];
    [button setImage:imgPress forState:UIControlStateSelected];
    button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, img.size.width, img.size.height);
    button.enabled = YES;
}

+ (void)buildConfirmButton:(UIButton *)button
{
    UIImage *img = [UIImage imageNamed:UI_IMAGE_CONFIRM_BUTTON];
    UIImage *imgPress = [UIImage imageNamed:UI_IMAGE_CONFIRM_BUTTON_PRESS];
    [button setImage:img forState:UIControlStateNormal];
    [button setImage:imgPress forState:UIControlStateSelected];
    button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, img.size.width, img.size.height);
    button.enabled = YES;
}

+ (void)buildEditButton:(UIButton *)button
{
    UIImage *img = [UIImage imageNamed:UI_IMAGE_EDIT_BUTTON];
    UIImage *imgPress = [UIImage imageNamed:UI_IMAGE_EDIT_BUTTON_PRESS];
    [button setImage:img forState:UIControlStateNormal];
    [button setImage:imgPress forState:UIControlStateSelected];
    button.frame = CGRectMake(5, button.frame.origin.y, img.size.width, img.size.height);
    button.enabled = YES;
}

+ (void)buildLoginButton:(UIButton *)button
{
    UIImage *img = [UIImage imageNamed:UI_IMAGE_SETTING_LOGIN];
    UIImage *imgPress = [UIImage imageNamed:UI_IMAGE_SETTING_LOGIN_PRESS];
    [button setImage:img forState:UIControlStateNormal];
    [button setImage:imgPress forState:UIControlStateSelected];
    button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, img.size.width, img.size.height);
    button.enabled = YES;
}

+ (void)buildLogoutButton:(UIButton *)button
{
    UIImage *img = [UIImage imageNamed:UI_IMAGE_SETTING_LOGOUT];
    UIImage *imgPress = [UIImage imageNamed:UI_IMAGE_SETTING_LOGOUT_PRESS];
    [button setImage:img forState:UIControlStateNormal];
    [button setImage:imgPress forState:UIControlStateSelected];
    button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, img.size.width, img.size.height);
    button.enabled = YES;
}

+ (void)buildNextButton:(UIButton *)button
{
    UIImage *img = [UIImage imageNamed:UI_IMAGE_NEXT_BUTTON_ENABLE];
    UIImage *imgPress = [UIImage imageNamed:UI_IMAGE_NEXT_BUTTON_ENABLE_PRESS];
    [button setImage:img forState:UIControlStateNormal];
    [button setImage:imgPress forState:UIControlStateSelected];
    button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, img.size.width, img.size.height);
    button.enabled = YES;
}

+ (void)buildNextButtonDis:(UIButton *)button
{
    UIImage *img = [UIImage imageNamed:UI_IMAGE_NEXT_BUTTON_DISABLE];
    [button setImage:img forState:UIControlStateNormal];
    button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, img.size.width, img.size.height);
    button.enabled = NO;
}

+ (void)buildUserInfoButton:(UIButton *)button
{
  UIImage *userButtonImg = [UIImage imageNamed:UI_IMAGE_USER_INFO_BUTTON_GREEN];
  UIImage *userButtonPressImg = [UIImage imageNamed:UI_IMAGE_USER_INFO_BUTTON_DARK];
  button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, userButtonImg.size.width, userButtonImg.size.height);
  [button setImage:userButtonImg forState:UIControlStateNormal];
  [button setImage:userButtonPressImg forState:UIControlStateSelected];
}

+ (void)buildAcceptButton:(UIButton *)button
{
  UIImage *acceptButtonImg = [UIImage imageNamed:UI_IMAGE_ACTIVITY_ACCEPT_BUTTON];
  UIImage *acceptButtonPressImg = [UIImage imageNamed:UI_IMAGE_ACTIVITY_ACCEPT_BUTTON_PRESS];
  [button setImage:acceptButtonImg forState:UIControlStateNormal];
  [button setImage:acceptButtonPressImg forState:UIControlStateSelected];
}

+ (void)buildSendButton:(UIButton *)button
{
    UIImage *img = [UIImage imageNamed:UI_IMAGE_SEND_BUTTON];
    UIImage *imgPress = [UIImage imageNamed:UI_IMAGE_SEND_BUTTON_PRESS];
    [button setImage:img forState:UIControlStateNormal];
    [button setImage:imgPress forState:UIControlStateSelected];
    button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, img.size.width, img.size.height);
    button.enabled = YES;
}

+ (void)buildCheckBoxButton:(UIButton *)button
{
    UIImage *img = [UIImage imageNamed:UI_IMAGE_CHECKBOX_CHECK];
    [button setImage:img forState:UIControlStateNormal];
    button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, img.size.width, img.size.height);
    button.enabled = YES;
}

+ (void)buildCheckBoxButtonUncheck:(UIButton *)button
{
    UIImage *img = [UIImage imageNamed:UI_IMAGE_CHECKBOX_UNCHECK];
    [button setImage:img forState:UIControlStateNormal];
    button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, img.size.width, img.size.height);
    button.enabled = YES;
}

+ (void)buildProvideButton:(UIButton *)button
{
    UIImage *img = [UIImage imageNamed:UI_IMAGE_PROVIDE];
    UIImage *imgPress = [UIImage imageNamed:UI_IMAGE_PROVIDE_PRESS];
    [button setImage:img forState:UIControlStateNormal];
    [button setImage:imgPress forState:UIControlStateSelected];
    button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, img.size.width, img.size.height);
}

+ (void)showErrorAlert:(NSString *)message:(id)delegate
{
  UIAlertView *alert = [[UIAlertView alloc] init];
	[alert setTitle:UI_LABEL_ERROR];
	[alert setMessage:message];
  [alert setDelegate:delegate];
  [alert addButtonWithTitle:UI_LABEL_CONFIRM];
  [alert show];
}

+ (void)showErrorMessageAlert:(NSDictionary *)errors:(id)delegate
{
  NSString *errorMsgs = nil;
  NSString *errorKey  = nil;
  
  errorMsgs = [errors valueForKey:@"code"];
  if ( errorMsgs ){
    [ViewHelper showErrorAlert:ERROR_MSG_CONNECTION_FAILURE:delegate]; 
    return;
  }
  
  for (NSString *k in errors) {
    errorKey  = k;
    errorMsgs = [errors valueForKey:errorKey];
    break;
  }
  
  if ( !errorMsgs || !errorKey ) { return; }
  
  if ( [errorMsgs isKindOfClass:NSArray.class]) {
    NSArray *errorArray = (NSArray *)errorMsgs;
    if ([errorArray count] > 0) {
      NSString *err = [[NSString alloc] initWithFormat:@"%@ %@", errorKey, [errorArray objectAtIndex:0]];
      [ViewHelper showErrorAlert:err:delegate]; 
    }
  }else if ( [errorMsgs isKindOfClass:NSString.class] ){ 
    NSString *err = [[NSString alloc] initWithFormat:@"%@ %@", errorKey, errorMsgs];
    [ViewHelper showErrorAlert:err:delegate]; 
  }

}

@end
