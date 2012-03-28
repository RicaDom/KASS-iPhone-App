//
//  Offer+OfferHelper.m
//  Demo
//
//  Created by Qi He on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Offer+OfferHelper.h"
#import "ViewHelper.h"
#import "ListingTableCell.h"

@implementation Offer (OfferHelper)

- (NSString *) getPriceText
{
  return [NSString stringWithFormat:@"￥%@", self.price];
}

- (NSString *) getListItemTimeLeftTextlong
{
  if ( self.isAccepted ) {
    return UI_LABEL_ACCEPTED;
  }else if ( self.isPaid) {
    return UI_LABEL_PAID;
  }else if (self.isPaymentConfirmed){
    return UI_LABEL_OFFER_PAYMENT_CONFIRMED;
  }else if (self.isRejected){
    return UI_LABEL_REJECTED;
  }else{
    NSString *timeLeftText = [BaseHelper getTimeFromNowText:[NSDate date]:[self listItemEndedAt]];
    return timeLeftText ? [[NSString alloc] initWithFormat:@"还有 %@", timeLeftText] : @"已经过期";
  }
}

+ (NSMutableDictionary *) getParamsToModify:(NSInteger)price :(NSString *)message
{
  return [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%d", price], @"price", message, @"with_message",nil];
}

+ (NSMutableDictionary *) getParamsToCreate:(NSInteger)price:(NSString *)message:(ListItem *)listItem
{
  return [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", price], @"price", message, @"message",listItem.dbId, @"listing_id", nil];
}

- (ListItem *) getListItemToMap
{
  NSDictionary *listing = [[NSDictionary alloc] initWithObjectsAndKeys:
                           self.title, @"title", self.description, @"description", 
                           self.listingId, @"id", nil ];
  
  ListItem *listItem = [[ListItem alloc] initWithDictionary:listing];
  listItem.location = self.listItemLocation;
  
  return listItem;
}

- (void) buildStatusIndicationView:(UIView *)sview
{
  [BaseHelper removeTaggedSubviews:CELL_INDICATION_VIEW_TAG:sview];
  UIView *indView = [[UIView alloc] initWithFrame:CGRectMake(1, 1, 35, sview.frame.size.height-2)];
  indView.backgroundColor = [[self getStateColor] colorWithAlphaComponent:0.50];
  indView.tag = CELL_INDICATION_VIEW_TAG;
  [sview addSubview:indView]; 
  
  if ( self.isUseful ) {
    UILabel *price = [[UILabel alloc] init];
    [price setTextColor:[UIColor whiteColor]];
    price.backgroundColor = [UIColor clearColor];
    price.frame = CGRectMake(1, 1, indView.frame.size.width-1, indView.frame.size.height-1);
    price.textAlignment = UITextAlignmentCenter;
    price.font = [UIFont fontWithName:DEFAULT_FONT size:14];
    price.text = [[NSString alloc] initWithFormat:@"%d", [self.price intValue]];
    [indView addSubview:price];   
  }
}

- (void) buildListingTableCell:(ListingTableCell *)cell
{
  // if my offer has been accepted by buyer
  if ( self.isAccepted ) {
    [ViewHelper buildOfferAcceptedCell:self:cell];
  }else if ( self.isPaid || self.isPaymentConfirmed){
    [ViewHelper buildOfferPaidCell:self :cell];
  }else if (self.isRejected){
    [ViewHelper buildOfferRejectedCell:self :cell];
  }else if ( self.isExpired ){
    [ViewHelper buildOfferExpiredCell:self:cell];
  }else {
    [ViewHelper buildOfferPendingCell:self:cell];         
  }
}

- (NSString *)getDialogUserTitle:(User *)user:(Message *)message
{
  NSString *title = [ViewHelper getTitleFromOfferMessage:user:self:message];
  
  if (![user.userId isEqualToString:message.userId]) {
    if ([self.buyerId isEqualToString:message.userId] && self.buyerName.isPresent) {
      title = self.buyerName;
    }else if ([self.userId isEqualToString:message.userId] && self.sellerName.isPresent){
      title = self.sellerName;
    }
  }
  return title;
}

- (UIView *) buildDialogAvatar:(UIView *)diglogView:(User *)user:(Offer *)offer:(Message *)message
{
  CGRect frame = CGRectMake(5, 8, 60, 60);
  if([offer.buyerId isEqualToString:message.userId]) {
    if (offer.buyerImageUrl && offer.buyerImageUrl.isPresent) {
      return [ViewHelper buildRoundCustomImageViewWithFrame:diglogView :offer.buyerImageUrl:frame];
    }else {
      return [ViewHelper buildDefaultImageView:diglogView:UI_IMAGE_MESSAGE_DEFAULT_BUYER];
    }
  }else if([offer.userId isEqualToString:message.userId]){
    if (offer.sellerImageUrl && offer.sellerImageUrl.isPresent) {
      return [ViewHelper buildRoundCustomImageViewWithFrame:diglogView :offer.sellerImageUrl:frame];
    }
  }
  return [ViewHelper buildDefaultImageView:diglogView:UI_IMAGE_MESSAGE_DEFAULT_USER];
}

- (UIView *)getMessageRow:(UIScrollView *)scrollView:(User *)user:(CGFloat)yOffset:(Message *)message:(NSDateFormatter *)dateFormatter
{
  
  UIView *diglogView = [[UIView alloc] initWithFrame:CGRectMake(0, yOffset, scrollView.frame.size.width, 70)];
  UIView *userImgView = [self buildDialogAvatar:diglogView:user:self:message];
  
  NSString *title = [self getDialogUserTitle:user:message];
  NSString *date=[dateFormatter stringFromDate:message.createdAt];
  
  // Header title
  UILabel* lblHeaderTitle = [[UILabel alloc] initWithFrame:CGRectMake(userImgView.frame.size.width+15, 5, 50, 20)];
  [lblHeaderTitle setText:title];      
  [lblHeaderTitle setTextColor:[UIColor grayColor]];
  lblHeaderTitle.backgroundColor = [UIColor clearColor];
  [lblHeaderTitle setTextAlignment:UITextAlignmentLeft];
  lblHeaderTitle.font = [UIFont boldSystemFontOfSize:13];
  [diglogView addSubview:lblHeaderTitle];
  
  // Time title
  UILabel* messageTime = [[UILabel alloc] initWithFrame:CGRectMake(userImgView.frame.size.width+15 + lblHeaderTitle.frame.size.width + 5, 5, 50, 20)];
  [messageTime setText:date];      
  [messageTime setTextColor:[UIColor darkGrayColor]];
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


- (void) buildMessagesScrollView:(UIScrollView *)scrollView:(User *)user
{
  CGFloat yOffset = 170;
  
  UIImage *line = [UIImage imageNamed:UI_IMAGE_MESSAGE_LINE];
  UIImageView *imageView = [[UIImageView alloc] initWithImage:line];
  imageView.frame = CGRectMake(0, yOffset + 10, scrollView.frame.size.width, imageView.frame.size.height);
  [scrollView addSubview:imageView];
  yOffset += 15;
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
  [dateFormatter setDateStyle:NSDateFormatterLongStyle];
  
  Message *firstMessage = [[Message alloc] initWithOffer:self];
  UIView *diglogView = [self getMessageRow:scrollView:user:yOffset:firstMessage:dateFormatter];
  yOffset += diglogView.frame.size.height;
  [scrollView addSubview:diglogView];
  [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, yOffset + 5)];  
  
  for (int i=0; i< [self.messages count]; i++) {
    
    Message *message = [self.messages objectAtIndex:i];
    
    UIView *diglogView = [self getMessageRow:scrollView:user:yOffset:message:dateFormatter];
    
    //INCREMNET in yOffset 
    yOffset += diglogView.frame.size.height;
    
    [scrollView addSubview:diglogView];
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, yOffset + 5)];    
  }
}

- (int) getStateWidthOffset
{
  if ( self.isAccepted ) {
    return 8;
  }else if ( self.isPaid || self.isPaymentConfirmed){
    return 5;
  }else if (self.isRejected){
    return 2;
  }else if ( self.isExpired ){
    return 0;
  }else {
    return 0; 
  }
}

- (UIColor *) getStateColor
{
  // if my offer has been accepted by buyer
  if ( self.isAccepted ) {
    return [UIColor greenColor];
  }else if ( self.isPaid || self.isPaymentConfirmed){
    return [UIColor orangeColor];
  }else if (self.isRejected){
    return [UIColor redColor];
  }else if ( self.isExpired ){
    return [UIColor lightGrayColor];
  }else {
    return [UIColor lightGrayColor];        
  }
}

- (void) buildOffererImageView:(UIView *)view
{
  CGRect frame = CGRectMake(10,10,50,50);
  
  if (self.sellerImageUrl.isPresent) {
    [ViewHelper buildCustomImageViewWithFrame:view:self.sellerImageUrl:frame];
  }else{
    [ViewHelper buildDefaultImageViewWithFrame:view:UI_IMAGE_MESSAGE_DEFAULT_SELLER:frame];
  }
}

@end
