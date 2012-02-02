//
//  NSObject+AsyncRequestPerform.m
//  Demo
//
//  Created by Qi He on 12-2-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSObject+AsyncRequestPerform.h"

@implementation NSObject (AsyncRequestPerform)
- (void)perform:(NSData *)data:(NSString *)action
{
  DLog(@"NSObject+AsyncRequestPerform::perform");
  SEL theSelector = NSSelectorFromString(action);
  if ([self respondsToSelector:theSelector]) 
  {
    DLog(@"NSObject+AsyncRequestPerform::perform:%@", action);
    [self performSelector:theSelector withObject:data];
  }
}
@end
