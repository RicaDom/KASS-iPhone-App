//
//  ListItem.m
//  Demo
//
//  Created by zhicai on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ListItem.h"
#import "User.h"

@implementation ListItem

@synthesize title = _title;
@synthesize description = _description;
@synthesize postedDate = _postedDate;
@synthesize askPrice = _askPrice;
@synthesize picFileName = _picFileName;
@synthesize data = _data;
@synthesize postDuration = _postDuration;
@synthesize dbId = _dbId;
@synthesize offers = _offers;
@synthesize location = _location;
@synthesize userId = _userId;
@synthesize state = _state;
@synthesize endedAt = _endedAt;
@synthesize offererIds = _offererIds;
@synthesize acceptedPrice = _acceptedPrice;
@synthesize acceptedOffer = _acceptedOffer;
@synthesize acceptedOfferId = _acceptedOfferId;

- (void) buildData:(NSDictionary *) theDictionary
{
  _title        = [theDictionary objectForKey:@"title"];
  _description  = [theDictionary objectForKey:@"description"];
  _state        = [theDictionary objectForKey:@"state"];
  _dbId         = [theDictionary objectForKey:@"id"];
  _userId       = [theDictionary objectForKey:@"user_id"];
  
  _askPrice     = [NSDecimalNumber decimalNumberWithDecimal:[[theDictionary objectForKey:@"price"] decimalValue]];
  
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:RUBY_DATETIME_FORMAT]; //2012-02-17T07:50:16+0000 
  _endedAt = [dateFormat dateFromString:[theDictionary objectForKey:@"time"]];
  
  NSArray *latlng = [theDictionary objectForKey:@"latlng"]; 
  _location       = [[Location alloc] initWithArray:latlng];
  
  _acceptedOfferId = [theDictionary objectForKey:@"accepted_offer_id"];
  NSArray *offers = [theDictionary objectForKey:@"offers"];
  _offers     = [[NSMutableArray alloc] init];
  _offererIds = [[NSMutableArray alloc] init];
  for(id ioffer in offers)
  {
    NSDictionary *offerDict = ioffer; 
    Offer *offer = [[Offer alloc] initWithDictionary:offerDict];
    if (offer && offer.userId) {
      [_offers addObject:offer];
      [_offererIds addObject:offer.userId];
      if ( [_acceptedOfferId isPresent] && offer.dbId && [_acceptedOfferId isEqualToString:offer.dbId] ) { 
        self.acceptedOffer = offer; 
        self.acceptedPrice = offer.price;
      }
    }
  }
}

- (id) initWithDictionary:(NSDictionary *) theDictionary
{
  if (self = [super init]) {
    [self buildData:theDictionary];
  }
  return self;
}

- (NSDecimalNumber *) price
{
  return _askPrice; 
}

- (id) initWithData:(NSData *) theData
{
  if (self = [super init]) {
    _data = theData;
    
    NSDictionary *dict = [KassApi parseData:_data];  
    NSDictionary *listDict = [dict objectForKey:@"listing"];
    [self buildData:listDict];
  }
  return self;
}

////////////////////////////// model helper methods ////////////////////////////////////////////////////
- (NSDictionary *) toJson
{
  NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys: self.dbId, @"id", nil];
  return [NSMutableDictionary dictionaryWithObjectsAndKeys: params, @"listItem", nil];
}

- (BOOL) hasOfferer:(User *)user
{
  return [self.offererIds indexOfObject:user.userId] != NSNotFound;
}

- (BOOL) isAccepted
{
  return [self.state isEqualToString:@"accepted"]; //self.acceptedPrice != nil && self.acceptedPrice > 0;
}

- (BOOL) isPersisted
{
  return [self.dbId length] > 0;
}

- (BOOL) isPaid
{
  return [self.state isEqualToString:@"paid"];
}

- (BOOL) isIdle
{
  return [self.state isEqualToString:@"idle"];
}

- (BOOL) isExpired
{
  return [_endedAt timeIntervalSinceNow] < 0;
}

- (Offer *) getOfferFromOfferer:(User *)user
{
  return [self.offers objectAtIndex:[self.offererIds indexOfObject:user.userId]];
}

@end
