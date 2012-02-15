//
//  ListItem.m
//  Demo
//
//  Created by zhicai on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ListItem.h"

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

- (id) initWithDictionary:(NSDictionary *) theDictionary
{
  if (self = [super init]) {
    _title        = [theDictionary objectForKey:@"title"];
    _description  = [theDictionary objectForKey:@"description"];
    _state        = [theDictionary objectForKey:@"state"];
    _dbId         = [theDictionary objectForKey:@"id"];
    _userId       = [theDictionary objectForKey:@"user_id"];
    
    _askPrice     = [NSDecimalNumber decimalNumberWithDecimal:[[theDictionary objectForKey:@"price"] decimalValue]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"]; //2012-02-17T07:50:16+00:00
    _endedAt = [dateFormat dateFromString:[theDictionary objectForKey:@"time"]];
    
    NSArray *latlng = [theDictionary objectForKey:@"latlng"]; 
    _location     = [[Location alloc] init];
    _location.latitude  = [NSDecimalNumber decimalNumberWithDecimal:[[latlng objectAtIndex:0] decimalValue]];
    _location.longitude = [NSDecimalNumber decimalNumberWithDecimal:[[latlng objectAtIndex:1] decimalValue]];
  }
  return self;
}

- (id) initWithData:(NSData *) theData
{
  if (self = [super init]) {
    _data = theData;
    
    NSDictionary *dict = [KassApi parseData:_data];  
    NSDictionary *listDict = [dict objectForKey:@"listing"];
    
    _title        = [listDict objectForKey:@"title"];
    _description  = [listDict objectForKey:@"description"];
    _askPrice     = [NSDecimalNumber decimalNumberWithDecimal:[[listDict objectForKey:@"price"] decimalValue]];
    _location     = [[Location alloc] init];
  }
  return self;
}

@end
