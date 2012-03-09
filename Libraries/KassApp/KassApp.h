//
//  KassApp.h
//  Demo
//
//  Created by Qi He on 12-3-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KassAppDelegate.h"
#import "KassAppObjManager.h"

@interface KassApp : NSObject

@property (nonatomic,assign) KassAppObjManager *kaObjManager;
@property (nonatomic,assign) id<KassAppDelegate> delegate;

- (id)initWithDelegate:(id<KassAppDelegate>)delegate;
- (void)loadSettings;
- (void)loadSettingsFinished:(NSData *)data;
- (void)loadAndStoreSettings;

- (void)getListing:(NSString *)dbId;
- (void)getListingFinished:(NSData *)data;

- (void)getListingsNearby:(NSMutableDictionary *)dict;
- (void)getListingsNearbyFinished:(NSData *)data;

- (void)getListingsRecent:(NSMutableDictionary *)dict;
- (void)getListingsRecentFinished:(NSData *)data;

- (void)getListingsMostPrice:(NSMutableDictionary *)dict;
- (void)getListingsMostPriceFinished:(NSData *)data;

- (void)requestFailed:(NSDictionary *)errors;
- (BOOL)manageObj:(id<HJMOUser>)user;

@end
