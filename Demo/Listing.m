//
//  Listing.m
//  Demo
//
//  Created by Qi He on 12-1-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Listing.h"

@implementation Listing : NSObject 

@synthesize data = _data;
@synthesize listItems = _listItems;
@synthesize location = _location;

- (void) buildListing:(NSDictionary *) theDict
{
  NSArray *listings = [theDict objectForKey:@"listings"];
  for(id listing in listings)
  {
    NSDictionary *listDict = listing; 
    ListItem *listItem = [[ListItem alloc] initWithDictionary:listDict ];
    [_listItems addObject:listItem];
  }
  
  NSDictionary *locDict = [theDict objectForKey:@"location"];
  if (locDict) {
    _location = [[Location alloc] initWithDictionary:locDict];
  }
}

- (id) initWithDictionary:(NSDictionary *) theDict
{
  if (self = [super init]) {
    _listItems = [NSMutableArray new];
    [self buildListing:theDict];
  }
  return self;
}

- (id) initWithData:(NSData *) theData
{
  if (self = [super init]) {
    _data = theData;
    _listItems = [NSMutableArray new];
    
    NSDictionary *dict = [KassApi parseData:_data];  
    [self buildListing:dict];    
  }
  return self;
}

- (void) printOut
{
  NSLog(@"------- Listing ------- \n");
  for(id listItem in _listItems)
  {
    NSLog(@"> %@ \n", [listItem title]);
  }
  NSLog(@"------- ------- ------- \n");
}

@end
