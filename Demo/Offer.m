//
//  Offer.m
//  Demo
//
//  Created by zhicai on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Offer.h"

@implementation Offer

@synthesize dbId = _dbId;
@synthesize price = _price;
@synthesize messages = _messages;
@synthesize createdAt = _createdAt;
@synthesize state = _state;
@synthesize listingId = _listingId;
@synthesize lastMessage = _lastMessage;
@synthesize userId = _userId;
@synthesize distance = _distance;
@synthesize title = _title;
@synthesize description = _description;
@synthesize buyerId = _buyerId;
@synthesize listItemEndedAt = _listItemEndedAt;
@synthesize listItemLocation = _listItemLocation;
@synthesize message = _message;
@synthesize buyerImageUrl = _buyerImageUrl;
@synthesize sellerImageUrl = _sellerImageUrl;
@synthesize alipayTradeNo = _alipayTradeNo;
@synthesize buyerName = _buyerName;
@synthesize sellerName = _sellerName;

- (id) initWithDictionary:(NSDictionary *) theDictionary
{
  if (self = [super init]) {
    _listingId    = [theDictionary objectForKey:@"listing_id"];
    _state        = [theDictionary objectForKey:@"state"];
    _dbId         = [theDictionary objectForKey:@"id"];
    _userId       = [theDictionary objectForKey:@"user_id"];
    _message      = [theDictionary objectForKey:@"message"];
    _alipayTradeNo= [theDictionary objectForKey:@"alipay_trade_no"];
    _price        = [NSDecimalNumber decimalNumberWithDecimal:[[theDictionary objectForKey:@"price"] decimalValue]];
    _lastMessage     = [[Message alloc] init];
    _lastMessage.body = [theDictionary objectForKey:@"message"];
    NSDictionary *listing = [theDictionary objectForKey:@"listing"];
    _title        = [listing objectForKey:@"title"];
    _description  = [listing objectForKey:@"description"];
    _buyerId      = [listing objectForKey:@"user_id"];
    NSDictionary *buyer = [listing objectForKey:@"user"];
    _buyerImageUrl = [buyer objectForKey:@"image"];
    _buyerId = _buyerId.isPresent ? _buyerId : [buyer objectForKey:@"id"];
    _buyerName    = [buyer objectForKey:@"name"];
    
    NSDictionary *seller = [theDictionary objectForKey:@"user"];
    _sellerImageUrl = [seller objectForKey:@"image"];
    _sellerName     = [seller objectForKey:@"name"];
    
    NSArray *latlng   = [listing objectForKey:@"latlng"]; 
    _listItemLocation = [[Location alloc] initWithArray:latlng];
    
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:RUBY_DATETIME_FORMAT]; //2012-02-17T07:50:16+0000 
//    _listItemEndedAt = [dateFormat dateFromString:[listing objectForKey:@"time"]];
    
    NSInteger expires_in_int = [[listing objectForKey:@"expires_in"] intValue];
    _listItemEndedAt = [[NSDate date] dateByAddingTimeInterval:expires_in_int];
    
    if ( !_listingId ) {
      _listingId = [listing objectForKey:@"id"];
    }
    
    NSArray *messages = [theDictionary objectForKey:@"messages"];
    _messages     = [[NSMutableArray alloc] init];
    for(id imessage in messages)
    {
      NSDictionary *messageDict = imessage; 
      Message *message = [[Message alloc] initWithDictionary:messageDict];
      [_messages addObject:message];
    }
  }
  return self;
}

- (NSDictionary *)toJson
{
  NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys: self.dbId, @"id", nil];
  return [NSMutableDictionary dictionaryWithObjectsAndKeys: params, @"offer", nil];
}

///////////////////////// model helper methods ///////////////////////////////////////
- (BOOL) isIdle
{
  return !self.isPaid && !self.isAccepted;
}

- (BOOL) isExpired
{
  return [_listItemEndedAt timeIntervalSinceNow] < 0;
}

- (BOOL) isActive
{
  return !self.isExpired && (self.isAccepted || self.isPaid || self.isPaymentConfirmed);
}

- (BOOL) isAccepted
{
  return [self.state isEqualToString:@"accepted"];
}

- (BOOL) isPaid
{
  return [self.state isEqualToString:@"paid"];
}

- (BOOL) isRejected
{
  return [self.state isEqualToString:@"rejected"];
}

- (BOOL) isUseful
{
  return self.isAccepted || self.isPaid || self.isPaymentConfirmed || !self.isExpired;
}

- (BOOL) isPaymentConfirmed
{
  return [self.state isEqualToString:@"payment_confirmed"];
}

- (NSString *)dbClass
{
  return @"listings";
}

@end
