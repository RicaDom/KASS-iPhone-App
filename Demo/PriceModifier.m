//
//  PriceModifier.m
//  Demo
//
//  Created by Qi He on 12-3-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PriceModifier.h"

@implementation PriceModifier

@synthesize price = _price;

static PriceModifier *pm = nil;

+ (PriceModifier *)currentModifier
{
  if (pm == nil) {
    pm = [[PriceModifier alloc] init];
  }
  return pm;
}

- (void)registerPriceModifier:(NSInteger)price
{
  _price = price;
}

- (void)unregister
{
  //don't release pm, because it's cross different controllers
}

@end
