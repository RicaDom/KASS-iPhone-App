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
  
  //TODO
  UILabel *labelExpiredDate = [[UILabel alloc] init];
  [labelExpiredDate setText:@"XX 天到期"];
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


+ (void) buildOfferScrollView:(IBOutlet UIScrollView *)scrollView:(User *)user:(Offer *)offer
{
  CGFloat yOffset = 155;
  
  UIImage *line = [UIImage imageNamed:@"line.png"];
  UIImageView *imageView = [[UIImageView alloc] initWithImage:line];
  imageView.frame = CGRectMake(0, yOffset + 10, scrollView.frame.size.width, imageView.frame.size.height);
  [scrollView addSubview:imageView];
  yOffset += 15;
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
  [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    
  for (int i=0; i< [offer.messages count]; i++) {
    UIImage *userImg = [UIImage imageNamed:@"mapPin.png"];
    UIImageView *userImgView = [[UIImageView alloc] initWithImage:userImg];
    userImgView.frame = CGRectMake(5, 5, 60, 60);
    UIView *diglogView = [[UIView alloc] initWithFrame:CGRectMake(0, yOffset, scrollView.frame.size.width, 75)];
    [diglogView addSubview:userImgView];

    Message *message = [offer.messages objectAtIndex:i];
    NSString *title = [ViewHelper getTitleFromOfferMessage:user:offer:i];
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
    UIImage *line = [UIImage imageNamed:@"line.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:line];
    imageView.frame = CGRectMake(0, diglogView.frame.size.height, scrollView.frame.size.width, imageView.frame.size.height);
    [diglogView addSubview:imageView];
    
    //INCREMNET in yOffset 
    yOffset += diglogView.frame.size.height;
      
    [scrollView addSubview:diglogView];
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, yOffset + 5)];    
  }

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
