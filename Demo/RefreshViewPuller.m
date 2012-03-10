//
//  RefreshViewPuller.m
//  Demo
//
//  Created by Qi He on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RefreshViewPuller.h"

@implementation RefreshViewPuller

static RefreshViewPuller *rvp = nil;

+ (RefreshViewPuller *)currentPuller
{
  if (rvp == nil) {
    rvp = [[RefreshViewPuller alloc] init];
  }
  return rvp;
}

@end
