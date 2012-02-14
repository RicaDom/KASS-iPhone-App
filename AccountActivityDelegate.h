//
//  AccountActivityDelegate.h
//  Demo
//
//  Created by Qi He on 12-2-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AccountActivityDelegate <NSObject>

@optional
- (void)accountLoadData;
- (void)accountDidCreateListing:(NSDictionary *)dict;
- (void)accountDidGetListings:(NSDictionary *)dict;
- (void)accountDidGetOffers:(NSDictionary *)dict;

@end
