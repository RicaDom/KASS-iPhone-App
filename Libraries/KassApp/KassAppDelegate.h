//
//  KassAppDelegate.h
//  Demo
//
//  Created by Qi He on 12-3-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KassAppDelegate <NSObject>

@optional
- (void)settingsDidLoad:(NSDictionary *)dict;
- (void)appDidGetListing:(NSDictionary *)dict;
- (void)appDidGetListingsNearby:(NSDictionary *)dict;
- (void)appDidGetListingsRecent:(NSDictionary *)dict;
- (void)appDidGetListingsMostPrice:(NSDictionary *)dict;
- (void)appRequestFailed:(NSDictionary *)errors;
- (void)appDidGetListingsBySearch:(NSDictionary *)dict;

@end
