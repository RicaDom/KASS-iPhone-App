//
//  PriceModifier.h
//  Demo
//
//  Created by Qi He on 12-3-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriceModifier : NSObject

@property NSInteger price;

+ (PriceModifier *)currentModifier;
- (void)registerPriceModifier:(NSInteger)price;
- (void)unregister;

@end
