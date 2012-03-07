//
//  ActiveModel.m
//  Demo
//
//  Created by Qi He on 12-3-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ActiveModel.h"

@implementation ActiveModel

@synthesize dbId = _dbId;

- (id) initWithDictionary:(NSDictionary *) theDictionary
{
  if (self = [super init]) {
    _dbId = [theDictionary valueForKey:@"id"];
  }
  return self;
}
- (id) initWithData:(NSData *) theData
{
  if (self = [super init]) {
       
  }
  return self;
}

- (NSDictionary *) toJson
{
  return nil;
}

@end
