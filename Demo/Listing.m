//
//  Listing.m
//  Demo
//
//  Created by Qi He on 12-1-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Listing.h"

@implementation Listing : NSObject 

@synthesize url = _url;
@synthesize data = _data;
@synthesize listItems = _listItems;

- (id) initWithData:(NSData *) theData
{
  if (self = [super init]) {
    _data = theData;
  }
  return self;
}

- (id) initWithUrl:(NSString *) theUrl
{
  if (self = [super init]) {
    _url = theUrl;
  }
  return self;
}

- (NSDictionary *)getListings{
  
  if(!_data){
    _data = [self fetch];
  }
  
  if(!_listItems){
    _listItems = [NSMutableArray new];
  }
  
  NSDictionary *dict = [KassApi parseData:_data];  
  
  NSArray *listings = [dict objectForKey:@"listings"];
  
  for(id listing in listings)
  {
    NSDictionary *listDict = listing; 
    ListItem *listItem = [[ListItem alloc] initWithDictionary:listDict ];
    [_listItems addObject:listItem];
    //NSLog(@"List Item: %@", [listItem title]);
  }
  
  return dict;
}

- (NSData *)fetch{
  //NSLog(@"fetching data from url %@ ...", url);
  _data = [KassApi getData:_url];
  return _data;
}

@end
