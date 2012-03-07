//
//  Settings.m
//  Demo
//
//  Created by Qi He on 12-3-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"

@implementation Settings

@synthesize expiredTimeDict = _expiredTimeDict;
@synthesize durationToServerDic = _durationToServerDic;
@synthesize postTemplatesDict = _postTemplatesDict;
@synthesize messageTypesDict = _messageTypesDict;

- (id) initWithDictionary:(NSDictionary *)dict
{
  if (self = [super init]) {
    // save to variable store
    NSDictionary *settings = [dict objectForKey:@"settings"];
    NSDictionary *duration = [settings objectForKey:@"duration"];
    NSDictionary *secToString = [duration objectForKey:@"sec_string"];
    NSDictionary *secToText   = [duration objectForKey:@"sec_text"];
    
    self.durationToServerDic = [[NSMutableDictionary alloc] init];
    self.expiredTimeDict     = [[NSMutableDictionary alloc] init];
    
    for (id key in secToString) {
      [self.durationToServerDic setObject:[secToString objectForKey:key] forKey:[NSNumber numberWithInt:[key intValue]]];
    }
    
    for (id key in secToText) {
      [self.expiredTimeDict setObject:[NSNumber numberWithInt:[key intValue]] forKey:[secToText objectForKey:key]];
    }
    
    self.postTemplatesDict = [settings objectForKey:@"post_templates"];
    self.messageTypesDict  = [settings objectForKey:@"message_types"];
  }
  return self;
}

- (NSString *) getTextForMessageType:(NSString *)type
{
  return [self.messageTypesDict objectForKey:type];
}

@end
