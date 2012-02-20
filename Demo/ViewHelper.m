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
  buttonPayNow.frame = CGRectMake(2, 2, 70.0, 20.0);
  [buttonPayNow setTitle:UI_BUTTON_LABEL_PAY_NOW forState:UIControlStateNormal];
  [buttonPayNow setTitleColor: [UIColor orangeColor] forState: UIControlStateNormal];
  [cell.infoView addSubview:buttonPayNow];     
  
  UILabel *labelAskPrice = [[UILabel alloc] init];
  
  if (item.askPrice != nil && item.askPrice > 0) {
    [labelAskPrice setText:[item.askPrice stringValue]];
  }
  
  [labelAskPrice setTextColor:[UIColor blackColor]];
  labelAskPrice.frame = CGRectMake(cell.infoView.frame.size.width/2 - 5, cell.infoView.frame.size.height/2, cell.infoView.frame.size.width - 2, cell.infoView.frame.size.height / 2 - 5);
  labelAskPrice.textAlignment = UITextAlignmentCenter;
  [labelAskPrice sizeToFit];
  [cell.infoView addSubview:labelAskPrice];            
}

+ (void) buildListItemNoOffersCell:(ListItem *)item:(ListingTableCell *)cell
{
  UILabel *labelWaiting = [[UILabel alloc] init];
  [labelWaiting setText:UI_LABEL_WAITING_FOR_OFFER];
  [labelWaiting setTextColor:[UIColor blackColor]];
  
  DLog(@"x: %f, y: %f, w: %f, h: %f", cell.infoView.frame.origin.x, cell.infoView.frame.origin.y, cell.infoView.frame.size.width - 2, cell.infoView.frame.size.height / 2 - 5);
  
  labelWaiting.frame = CGRectMake(2, 2, cell.infoView.frame.size.width - 2, cell.infoView.frame.size.height / 2 - 5);
  labelWaiting.textAlignment = UITextAlignmentCenter;
  [labelWaiting sizeToFit];
  //labelWaiting.center = CGPointMake(cell.infoView.frame.size.width/2, 2);
  [cell.infoView addSubview:labelWaiting]; 
  
  UILabel *labelAskPrice = [[UILabel alloc] init];
  if (item.askPrice != nil && item.askPrice > 0) {
    [labelAskPrice setText:[item.askPrice stringValue]];
  }
  [labelAskPrice setTextColor:[UIColor blackColor]];
  labelAskPrice.frame = CGRectMake(cell.infoView.frame.size.width/2 - 5, cell.infoView.frame.size.height/2 - 10, cell.infoView.frame.size.width - 2, cell.infoView.frame.size.height / 2 - 5);
  labelAskPrice.textAlignment = UITextAlignmentCenter;
  //labelAskPrice.center = CGPointMake(cell.infoView.frame.size.width/2, cell.infoView.frame.size.height/2 + 3);
  [labelAskPrice sizeToFit];
  [cell.infoView addSubview:labelAskPrice]; 
  
  //TODO
  UILabel *labelExpiredDate = [[UILabel alloc] init];
  [labelExpiredDate setText:@"3天到期"];
  [labelExpiredDate setTextColor:[UIColor blackColor]];
  labelExpiredDate.frame = CGRectMake(2, cell.infoView.frame.size.height/2 + 12, cell.infoView.frame.size.width - 2, cell.infoView.frame.size.height / 2 - 5);
  labelExpiredDate.textAlignment = UITextAlignmentCenter;
  //labelExpiredDate.center = CGPointMake(cell.infoView.frame.size.width/2, cell.infoView.frame.size.height/2 + 3);
  [labelExpiredDate sizeToFit];
  [cell.infoView addSubview:labelExpiredDate]; 
}

+ (void) buildListItemHasOffersCell:(ListItem *)item:(ListingTableCell *)cell
{
  UILabel *labelNeedsReview = [[UILabel alloc] init];
  [labelNeedsReview setText:UI_LABEL_NEEDS_REVIEW];
  [labelNeedsReview setTextColor:[UIColor blackColor]];
  labelNeedsReview.frame = CGRectMake(2, 2, cell.infoView.frame.size.width - 2, cell.infoView.frame.size.height / 2 - 5);
  labelNeedsReview.textAlignment = UITextAlignmentCenter;
  [labelNeedsReview sizeToFit];
  [cell.infoView addSubview:labelNeedsReview];    
  
  UILabel *labelOffersCount = [[UILabel alloc] init];
  [labelOffersCount setText:[[NSString alloc] initWithFormat:@"%d %@", [item.offers count], UI_LABEL_OFFER]];
  [labelOffersCount setTextColor:[UIColor blackColor]];
  labelOffersCount.frame = CGRectMake(cell.infoView.frame.size.width/2 - 10, cell.infoView.frame.size.height/2 - 10, cell.infoView.frame.size.width - 2, cell.infoView.frame.size.height / 2 - 5);
  labelOffersCount.textAlignment = UITextAlignmentCenter;
  [labelOffersCount sizeToFit];
  [cell.infoView addSubview:labelOffersCount];  
}

+ (void) buildOfferPendingCell:(Offer *)item:(ListingTableCell *)cell
{
  UILabel *labelPending = [[UILabel alloc] init];
  [labelPending setText:UI_LABEL_OFFER_PENDING];
  [labelPending setTextColor:[UIColor blackColor]];
  
  labelPending.frame = CGRectMake(2, 2, cell.infoView.frame.size.width - 2, cell.infoView.frame.size.height / 2 - 5);
  labelPending.textAlignment = UITextAlignmentCenter;
  [labelPending sizeToFit];
  //labelPending.center = CGPointMake(cell.infoView.frame.size.width/2, 2);
  [cell.infoView addSubview:labelPending]; 
  
  UILabel *labelAskPrice = [[UILabel alloc] init];
  
  if (item.price != nil && item.price > 0) {
    [labelAskPrice setText:[item.price stringValue]];
  }
  
  [labelAskPrice setTextColor:[UIColor blackColor]];
  labelAskPrice.frame = CGRectMake(cell.infoView.frame.size.width/2 - 5, cell.infoView.frame.size.height/2 - 10, cell.infoView.frame.size.width - 2, cell.infoView.frame.size.height / 2 - 5);
  labelAskPrice.textAlignment = UITextAlignmentCenter;
  [labelAskPrice sizeToFit];
  [cell.infoView addSubview:labelAskPrice]; 
  
  UILabel *labelOfferer = [[UILabel alloc] init];
  
  [labelOfferer setText:([item.state isEqualToString: OFFER_STATE_REJECTED] ? UI_LABEL_BUYER_OFFERED : UI_LABEL_YOU_OFFERED)];
  
  [labelOfferer setTextColor:[UIColor blackColor]];
  labelOfferer.frame = CGRectMake(2, cell.infoView.frame.size.height/2 + 12, cell.infoView.frame.size.width - 2, cell.infoView.frame.size.height / 2 - 5);
  labelOfferer.textAlignment = UITextAlignmentCenter;
  [labelOfferer sizeToFit];
  [cell.infoView addSubview:labelOfferer]; 
}

+ (void) buildOfferExpiredCell:(Offer *)item:(ListingTableCell *)cell
{
  UILabel *labelExpired = [[UILabel alloc] init];
  [labelExpired setText:UI_LABEL_EXPIRED];
  [labelExpired setTextColor:[UIColor blackColor]];
  
  labelExpired.frame = CGRectMake(2, 2, cell.infoView.frame.size.width - 2, cell.infoView.frame.size.height / 2 - 5);
  labelExpired.textAlignment = UITextAlignmentCenter;
  [labelExpired sizeToFit];
  //labelWaiting.center = CGPointMake(cell.infoView.frame.size.width/2, 2);
  [cell.infoView addSubview:labelExpired]; 
  
  UILabel *labelAskPrice = [[UILabel alloc] init];
  
  if (item.price != nil && item.price > 0) {
    [labelAskPrice setText:[item.price stringValue]];
  }
  
  [labelAskPrice setTextColor:[UIColor blackColor]];
  labelAskPrice.frame = CGRectMake(cell.infoView.frame.size.width/2 - 5, cell.infoView.frame.size.height/2 - 10, cell.infoView.frame.size.width - 2, cell.infoView.frame.size.height / 2 - 5);
  labelAskPrice.textAlignment = UITextAlignmentCenter;
  [labelAskPrice sizeToFit];
  [cell.infoView addSubview:labelAskPrice]; 
  
  //TODO
  UILabel *labelYouOffered = [[UILabel alloc] init];
  [labelYouOffered setText:UI_LABEL_YOU_OFFERED];
  [labelYouOffered setTextColor:[UIColor blackColor]];
  labelYouOffered.frame = CGRectMake(2, cell.infoView.frame.size.height/2 + 12, cell.infoView.frame.size.width - 2, cell.infoView.frame.size.height / 2 - 5);
  labelYouOffered.textAlignment = UITextAlignmentCenter;
  [labelYouOffered sizeToFit];
  [cell.infoView addSubview:labelYouOffered]; 
}

+ (void) buildOfferAcceptedCell:(Offer *)item:(ListingTableCell *)cell
{
  UILabel *labelAccepted = [[UILabel alloc] init];
  [labelAccepted setText:UI_LABEL_ACCEPTED];
  [labelAccepted setTextColor:[UIColor blackColor]];
  
  labelAccepted.frame = CGRectMake(2, 2, cell.infoView.frame.size.width - 2, cell.infoView.frame.size.height / 2 - 5);
  labelAccepted.textAlignment = UITextAlignmentCenter;
  [labelAccepted sizeToFit];
  //labelAccepted.center = CGPointMake(cell.infoView.frame.size.width/2, 2);
  [cell.infoView addSubview:labelAccepted]; 
  
  UILabel *labelAskPrice = [[UILabel alloc] init];
  
  if (item.price != nil && item.price > 0) {
    [labelAskPrice setText:[item.price stringValue]];
  }
  
  [labelAskPrice setTextColor:[UIColor blackColor]];
  labelAskPrice.frame = CGRectMake(cell.infoView.frame.size.width/2 - 5, cell.infoView.frame.size.height/2 - 10, cell.infoView.frame.size.width - 2, cell.infoView.frame.size.height / 2 - 5);
  labelAskPrice.textAlignment = UITextAlignmentCenter;
  //labelAskPrice.center = CGPointMake(cell.infoView.frame.size.width/2, cell.infoView.frame.size.height/2 + 3);
  [labelAskPrice sizeToFit];
  [cell.infoView addSubview:labelAskPrice]; 
  
  //TODO
  UILabel *labelYouOffered = [[UILabel alloc] init];
  [labelYouOffered setText:UI_LABEL_YOU_OFFERED];
  [labelYouOffered setTextColor:[UIColor blackColor]];
  labelYouOffered.frame = CGRectMake(2, cell.infoView.frame.size.height/2 + 12, cell.infoView.frame.size.width - 2, cell.infoView.frame.size.height / 2 - 5);
  labelYouOffered.textAlignment = UITextAlignmentCenter;
  //labelExpiredDate.center = CGPointMake(cell.infoView.frame.size.width/2, cell.infoView.frame.size.height/2 + 3);
  [labelYouOffered sizeToFit];
  [cell.infoView addSubview:labelYouOffered];
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
