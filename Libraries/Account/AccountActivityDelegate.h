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
- (void)accountDidCreateListing:(NSDictionary *)dict;
- (void)accountDidGetListings:(NSDictionary *)dict;
- (void)accountDidGetListing:(NSDictionary *)dict;
- (void)accountDidGetOffers:(NSDictionary *)dict;
- (void)accountDidGetOffer:(NSDictionary *)dict;
- (void)accountDidCreateOffer:(NSDictionary *)dict;
- (void)accountDidModifyListing:(NSDictionary *)dict;
- (void)accountDidModifyOffer:(NSDictionary *)dict;
- (void)accountDidAcceptOffer:(NSDictionary *)dict;
- (void)accountDidGetOfferMessages:(NSDictionary *)dict;
- (void)accountDidCreateOfferMessage:(NSDictionary *)dict;
- (void)accountDidDeleteListing;

- (void)accountRequestFailed:(NSDictionary *)errors;
- (void)accountRequestStarted;

- (void)accountLoginFinished;
- (void)accountLogoutFinished;
- (void)accountWeiboShareFinished;

@end
