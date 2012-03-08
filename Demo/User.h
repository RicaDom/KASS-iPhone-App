//
//  User.h
//  Demo
//
//  Created by zhicai on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KassApi.h"
#import "WBConnect.h"
#import "Account.h"
#import "AccountActivityDelegate.h"
#import "PrivatePubClient.h"

typedef enum {
  wUpdate,
  wLogin,
  wIdle
} WeiboAction ;

@interface User : NSObject<WBSessionDelegate,WBSendViewDelegate,WBRequestDelegate, AccountSessionDelegate, FayeClientDelegate>{
  WeiBo *weibo;
  Account *account;
  WeiboAction wAction;
  PrivatePubClient *ppClient;
}

@property (nonatomic,assign) id<AccountActivityDelegate> delegate;
@property (nonatomic,strong,readonly) WeiBo* weibo;
@property (nonatomic,strong,readonly) Account* account;
@property (nonatomic,strong,readonly) PrivatePubClient* ppClient;

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;

- (id) initWithDelegate:(id<AccountActivityDelegate>)delegate;
- (void) weiboLogin;
- (void) accountLogin:(NSString *)email:(NSString *)password;
- (void) logout;
- (BOOL) isSameUser:(NSString *)userId;

- (void)weiboShare:(ListItem *)listItem;
- (void)weiboDidShare;

- (void)createListing:(NSDictionary *)dict;
- (void)createListingFinished:(NSData *)data;
- (void)modifyListing:(NSDictionary *)dict:(NSString *)modelId;
- (void)modifyListingFinished:(NSData *)data;

- (void)createOffer:(NSDictionary *)dict;
- (void)createOfferFinished:(NSData *)data;
- (void)createOfferMessage:(NSDictionary *)dict:(NSString *)modelId;
- (void)createOfferMessageFinished:(NSData *)data;

- (void)getListing:(NSString *)dbId;
- (void)getListingFinished:(NSData *)data;
- (void)getListings;
- (void)getListingsFinished:(NSData *)data;
- (void)getOffer:(NSString *)dbId;
- (void)getOfferFinished:(NSData *)data;
- (void)getOffers;
- (void)getOffersFinished:(NSData *)data;
- (void)modifyOffer:(NSDictionary *)dict:(NSString *)modelId;
- (void)modifyOfferFinished:(NSData *)data;
- (void)getOfferMessages:(NSString *)offerId;
- (void)getOfferMessagesFinished:(NSData *)data;
- (void)acceptOffer:(NSString *)offerId;
- (void)acceptOfferFinished:(NSData *)data;

- (void)getPrivatePub;
- (void)getPrivatePubFinished:(NSData *)data;

//// model helper methods
- (BOOL)hasListItem:(ListItem *)listItem;
- (NSString*)stringFromDictionary:(NSDictionary*)info;

@end
