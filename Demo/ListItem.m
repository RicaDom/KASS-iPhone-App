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

- (id) initWithDictionary:(NSDictionary *) theDictionary
{
  if (self = [super init]) {
    _title        = [theDictionary objectForKey:@"title"];
    _description  = [theDictionary objectForKey:@"description"];
    _askPrice     = [NSDecimalNumber decimalNumberWithDecimal:[[theDictionary objectForKey:@"price"] decimalValue]];
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
  }
  return self;
}

@end
