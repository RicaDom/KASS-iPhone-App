//
//  Offers.m
//  Demo
//
//  Created by Qi He on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Offers.h"

@implementation Offers

@synthesize data = _data;
@synthesize offers = _offers;
@synthesize location = _location;

- (void) buildOffers:(NSDictionary *) theDict
{
  NSArray *offers = [theDict objectForKey:@"listings"];
  for(id ioffer in offers)
  {
    NSDictionary *offerDict = ioffer; 
    Offer *offer = [[Offer alloc] initWithDictionary:offerDict];
    [_offers addObject:offer];
  }
  
  NSDictionary *locDict = [theDict objectForKey:@"location"];
  if (locDict) {
    _location = [[Location alloc] initWithDictionary:locDict];
  }
}

- (id) initWithDictionary:(NSDictionary *) theDict
{
  if (self = [super init]) {
    _offers = [NSMutableArray new];
    [self buildOffers:theDict];
  }
  return self;
}

- (id) initWithData:(NSData *) theData
{
  if (self = [super init]) {
    _data = theData;
    _offers = [NSMutableArray new];
    
    NSDictionary *dict = [KassApi parseData:_data];  
    [self buildOffers:dict];    
  }
  return self;
}

- (void) printOut
{
  NSLog(@"------- Listing ------- \n");
  for(id offer in _offers)
  {
    NSLog(@"> %@ \n", [offer title]);
  }
  NSLog(@"------- ------- ------- \n");
}

@end
