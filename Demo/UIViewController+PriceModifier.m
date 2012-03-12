//
//  UIViewController+PriceModifier.m
//  Demo
//
//  Created by Qi He on 12-3-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+PriceModifier.h"
#import "PriceModifier.h"
#import "Constants.h"

@implementation UIViewController (PriceModifier)

- (void) registerPriceModifier:(NSInteger)price
{
  [PriceModifier.currentModifier registerPriceModifier:price];
}

- (void) unregisterPriceModifier
{
  [PriceModifier.currentModifier unregister];
}

- (void) priceModificationDidFinish
{
  DLog(@"UIViewController (PriceModifier)::priceModificationDidFinish");
}

- (void) priceModifiedNotification:(NSNotification *) notification
{
  PriceModifier.currentModifier.price = [[notification object] intValue];
  [self priceModificationDidFinish];
}

@end
