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

- (id) initWithDictionary:(NSDictionary *) theDictionary
{
  if (self = [super init]) {
    _listingId    = [theDictionary objectForKey:@"listing_id"];
    _state        = [theDictionary objectForKey:@"state"];
    _dbId         = [theDictionary objectForKey:@"id"];
    _price        = [NSDecimalNumber decimalNumberWithDecimal:[[theDictionary objectForKey:@"price"] decimalValue]];
    _lastMessage     = [[Message alloc] init];
    _lastMessage.body = [theDictionary objectForKey:@"message"];
    
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
