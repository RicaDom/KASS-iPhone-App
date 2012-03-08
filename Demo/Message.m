//
//  Message.m
//  Demo
//
//  Created by zhicai on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Message.h"

@implementation Message

@synthesize dbId    = _dbId;
@synthesize userId  = _userId;
@synthesize body    = _body;
@synthesize createdAt = _createdAt;

- (id) initWithDictionary:(NSDictionary *) theDictionary
{
  if (self = [super init]) {
    _body    = [theDictionary objectForKey:@"body"];
    _userId  = [theDictionary objectForKey:@"user_id"];
    _dbId    = [theDictionary objectForKey:@"id"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:RUBY_DATETIME_FORMAT]; 
    _createdAt = [dateFormat dateFromString:[theDictionary objectForKey:@"created_at"]];
  }
  return self;
}

@end
