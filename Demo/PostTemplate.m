//
//  PostTemplate.m
//  Demo
//
//  Created by Wesley Wang on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PostTemplate.h"

@implementation PostTemplate

@synthesize dbId = _dbId;
@synthesize picPath = _picPath;
@synthesize listItem = _listItem;
@synthesize category = _category;

- (id) initWithDictionaryAndCategory:(NSDictionary*) theDict:(NSString *)category
{
  if (self = [super init]) {
    self.dbId = [theDict objectForKey:@"id"];
    self.picPath = [theDict objectForKey:@"pic"];
    self.category = category;
    
    ListItem *item = [ListItem new];
    item.title = [theDict objectForKey:@"title"];
    item.description = [theDict objectForKey:@"description"];
    item.askPrice = [NSDecimalNumber decimalNumberWithDecimal:[[theDict objectForKey:@"price"] decimalValue]];
    item.postDuration = [NSNumber numberWithInt:[[theDict objectForKey:@"duration"] intValue]];
    
    self.listItem = item;

  }
  return self;
}

@end
