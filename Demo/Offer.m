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

- (id) initWithDictionary:(NSDictionary *) theDictionary
{
  if (self = [super init]) {
    _listingId    = [theDictionary objectForKey:@"listing_id"];
    _state        = [theDictionary objectForKey:@"state"];
    _dbId         = [theDictionary objectForKey:@"id"];
    _price        = [NSDecimalNumber decimalNumberWithDecimal:[[theDictionary objectForKey:@"price"] decimalValue]];
    _lastMessage     = [[Message alloc] init];
    _lastMessage.body = [theDictionary objectForKey:@"message"];
    NSDictionary *listing = [theDictionary objectForKey:@"listing"];
    _title        = [listing objectForKey:@"title"];
    _description  = [listing objectForKey:@"description"];
    _buyerId      = [listing objectForKey:@"user_id"];
    
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

@end
