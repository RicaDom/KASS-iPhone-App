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
#import "Renren.h"
#import "AccountActivityDelegate.h"
//#import "PrivatePubClient.h"

typedef enum {
  wUpdate,
  wLogin,
  wIdle
} WeiboAction ;

@interface User : NSObject<WBSessionDelegate,WBSendViewDelegate,WBRequestDelegate, AccountSessionDelegate, RenrenDelegate>{
  WeiBo *weibo;
  Renren *renren;
  Account *account;
  WeiboAction wAction;
//  PrivatePubClient *ppClient;
}

@property (nonatomic,strong) id<AccountActivityDelegate> delegate;
@property (nonatomic,strong) Renren* renren;
@property (nonatomic,strong,readonly) WeiBo* weibo;
@property (nonatomic,strong,readonly) Account* account;
//@property (nonatomic,strong,readonly) PrivatePubClient* ppClient;

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *city;

@property BOOL emailVerified;
@property BOOL weiboVerified;
@property BOOL renrenVerified;
@property BOOL phoneVerified;

- (id) initWithDelegate:(id<AccountActivityDelegate>)delegate;
- (void) weiboLogin;
- (void) renrenLogin;
- (void) accountLogin:(NSString *)email:(NSString *)password;
- (void) logout;
- (BOOL) isSameUser:(NSString *)userId;
- (void) accountSignUp:(NSDictionary *)dict;

- (void)weiboShare:(ListItem *)listItem;
- (void)weiboDidShare;
- (BOOL)isWeiboLogin;
- (BOOL)isRenrenLogin;
- (void)renrenShare:(ListItem *)listItem;
- (void)renrenDidShare;

- (void)createListing:(NSDictionary *)dict;
- (void)createListingFinished:(NSData *)data;
- (void)modifyListing:(NSDictionary *)dict:(NSString *)modelId;
- (void)modifyListingFinished:(NSData *)data;

- (void)createOffer:(NSDictionary *)dict;
- (void)createOfferFinished:(NSData *)data;
- (void)createOfferMessage:(NSDictionary *)dict:(NSString *)modelId;
- (void)createOfferMessageFinished:(NSData *)data;

- (void)deleteListing:(NSString *)dbId;
- (void)deleteListingFinished;
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
- (void)payOffer:(NSString *)offerId;
- (void)payOfferFinished:(NSData *)data;
- (void)alipayOffer:(Offer *)offer;
- (void)confirmPaymentOffer:(NSString *)offerId;
- (void)confirmPaymentOfferFinished:(NSData *)data;

- (void)getAlertListings:(NSString *)alertId;
- (void)getAlertListingsFinished:(NSData *)data;
- (void)createAlert:(NSDictionary *)dict;
- (void)createAlertFinished:(NSData *)data;
- (void)modifyAlert:(NSDictionary *)dict:(NSString *)modelId;
- (void)modifyAlertFinished:(NSData *)data;
- (void)deleteAlert:(NSString *)modelId;
- (void)deleteAlertFinished;
- (void)getAlerts;
- (void)getAlertsFinished:(NSData *)data;

- (void)createStatusCall:(NSDictionary *)dict;
- (void)createStatusCallFinished:(NSData *)data;

- (void)phoneNotify;
- (void)phoneNotifyFinished:(NSData *)data;

- (void)phoneVerify:(NSString *)token;
- (void)phoneVerifyFinished:(NSData *)data;

//- (void)getPrivatePub;
//- (void)getPrivatePubFinished:(NSData *)data;

//- (void)sendIphoneToken;
//- (void)sendIphoneTokenFinished:(NSData *)data;

//// model helper methods
- (BOOL)hasListItem:(ListItem *)listItem;
- (NSString*)stringFromDictionary:(NSDictionary*)info;
+ (BOOL)isEmailValid:(NSString *)email;
+ (BOOL)isNameValid:(NSString *)name;
+ (BOOL)isPhoneValid:(NSString *)phone;

- (void)getAuth;

@end
