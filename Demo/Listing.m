//
//  Listing.m
//  Demo
//
//  Created by Qi He on 12-1-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Listing.h"

@implementation Listing : NSObject 

@synthesize url, data, listItems;


- (NSDictionary *)getListings{
  
  if(!data){
    data = [self fetch];
  }
  
  if(!listItems){
    listItems = [NSMutableArray new];
  }
  
  NSDictionary *dict = [KassApi parseData:data];  
  
  NSArray *listings = [dict objectForKey:@"listings"];
  
  for(id listing in listings)
  {
    NSDictionary *listDict = listing; 
    
    ListItem *listItem = [[ListItem alloc] init ];
    [listItem setTitle:[listDict objectForKey:@"title"]];
    [listItem setDescription:[listDict objectForKey:@"description"]];
    
    [listItems addObject:listItem];
    
    NSLog(@"List Item: %@", [listItem title]);
  }
  
  
  return dict;
}

- (NSData *)fetch{
  NSLog(@"fetching data from url %@ ...", url);
  data = [KassApi getData:url];
  return data;
}

@end
