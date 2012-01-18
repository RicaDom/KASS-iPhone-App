//
//  ListingTest.m
//  Demo
//
//  Created by Qi He on 12-1-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ListingTest.h"

@implementation ListingTest

// All code under test must be linked into the Unit Test bundle
- (void)testFetchData
{
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"listings" ofType:@"json"];  
  
  NSData *data = [NSData dataWithContentsOfFile:filePath];  
  
  id mockString = [OCMockObject mockForClass:[Listing class]];
  [[[mockString stub] andReturn:data] fetch];
  
  Listing *listing = [[Listing alloc] init];
  [listing setData:data];
  [listing getListings];

  ListItem *li = [[listing listItems] objectAtIndex:0];
    
  STAssertEqualObjects([li title], @"Deliver Champagne and Sing Kenny Chesney for Brother on His Birthday", nil);
  
}
@end
