//
//  UIViewController+PriceModifier.m
//  Demo
//
//  Created by Qi He on 12-3-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+PriceModifier.h"
#import "UIResponder+VariableStore.h"
#import "Constants.h"

@implementation UIViewController (PriceModifier)

- (void) modifyPriceModifierPrice:(NSDecimalNumber *)price
{
  [self kassVS].priceToModify = [price intValue];
}

- (void) registerPriceModifier
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(priceModifiedNotification:) 
                                               name:CHANGED_PRICE_NOTIFICATION
                                             object:nil];
}

- (void) unregisterPriceModifier
{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:CHANGED_PRICE_NOTIFICATION object:nil];
}

- (void) priceModificationDidFinish:(NSInteger)price
{
  DLog(@"UIViewController (PriceModifier)::priceModificationDidFinish:price=%@", price);
}

- (void) priceModifiedNotification:(NSNotification *) notification
{
  [self kassVS].priceToModify = [[notification object] intValue];
  [self priceModificationDidFinish:[self kassVS].priceToModify];
}

@end
