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

- (id) initWithData:(NSData *) theData
{
  if (self = [super init]) {
    _data = theData;
    _listItems = [NSMutableArray new];
    
    NSDictionary *dict = [KassApi parseData:_data];  
    NSArray *listings = [dict objectForKey:@"listings"];

    for(id listing in listings)
    {
      NSDictionary *listDict = listing; 
      ListItem *listItem = [[ListItem alloc] initWithDictionary:listDict ];
      [_listItems addObject:listItem];
    }
    
    NSDictionary *locDict = [dict objectForKey:@"location"];
    if (locDict) {
      _location = [[Location alloc] initWithDictionary:locDict];
    }
    
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
