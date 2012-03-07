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

- (id) initWithDictionary:(NSDictionary *) theDictionary
{
  if (self = [super init]) {
    _listingId    = [theDictionary objectForKey:@"listing_id"];
    _state        = [theDictionary objectForKey:@"state"];
    _dbId         = [theDictionary objectForKey:@"id"];
    _userId       = [theDictionary objectForKey:@"user_id"];
    _price        = [NSDecimalNumber decimalNumberWithDecimal:[[theDictionary objectForKey:@"price"] decimalValue]];
    _lastMessage     = [[Message alloc] init];
    _lastMessage.body = [theDictionary objectForKey:@"message"];
    NSDictionary *listing = [theDictionary objectForKey:@"listing"];
    _title        = [listing objectForKey:@"title"];
    _description  = [listing objectForKey:@"description"];
    _buyerId      = [listing objectForKey:@"user_id"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:RUBY_DATETIME_FORMAT]; //2012-02-17T07:50:16+0000 
    _listItemEndedAt = [dateFormat dateFromString:[listing objectForKey:@"time"]];
    
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
- (BOOL) isExpired
{
  return [_listItemEndedAt timeIntervalSinceNow] < 0;
}


@end
