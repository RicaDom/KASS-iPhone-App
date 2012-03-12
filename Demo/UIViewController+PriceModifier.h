//
//  UIViewController+PriceModifier.h
//  Demo
//
//  Created by Qi He on 12-3-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PriceModifier)

- (void) registerPriceModifier:(NSInteger)price;
- (void) unregisterPriceModifier;

- (void) priceModificationDidFinish;
- (void) priceModifiedNotification:(NSNotification *) notification;

@end
