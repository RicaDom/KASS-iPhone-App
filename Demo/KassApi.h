//
//  KassApi.h
//  MyZaarlyDemo
//
//  Created by Qi He on 12-1-17.
//  Copyright (c) 2012年 Heyook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"
#import "NSObject+AsyncRequestPerform.h"
#import "Listing.h"
#import "ListItem.h"

#import "NSString+ModelHelper.h"
#import "NSNull+ModelHelper.h"

@interface KassApi : NSObject

@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSString *response;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSObject *performer;

- (id) initWithPerformerAndAction:(NSObject *)thePerformer:(NSString *)theAction;

+ (NSData *)getData:(NSString *)url;
//+ (NSData *)postData:(NSString *)url:(NSDictionary *)dict;
//+ (NSData *)getListings:(NSString *)box;
//+ (NSData *)getListing:(NSString *)modelId;

+ (NSDictionary *)parseData:(NSData *)data;
+ (void)logData:(NSDictionary *)dict;

- (void)postData:(NSString *)url:(NSDictionary *)dict;
- (void)getData:(NSString *)url;

- (void)getAlertListings:(NSString *)modelId;
- (BOOL)createAlert:(NSDictionary *)dict;
- (void)modifyAlert:(NSDictionary *)dict:(NSString *)modelId;
- (void)deleteAlert:(NSString *)modelId;
- (void)getAccountAlerts;

- (void)deleteListing:(NSString *)modelId;
- (BOOL)createOffer:(NSDictionary *)dict;
- (BOOL)createListing:(NSDictionary *)dict;
- (void)getListings:(NSDictionary *)dict;
- (void)getListing:(NSString *)modelId;
- (void)getMember:(NSString *)memberId;
- (void)getAccountListings;
- (void)getAccountListing:(NSString *)modelId;
- (void)getAccountOffers;
- (void)getAccountOffer:(NSString *)modelId;
- (void)modifyListing:(NSDictionary *)dict:(NSString *)modelId;
- (void)modifyOffer:(NSDictionary *)dict:(NSString *)modelId;
- (void)acceptOffer:(NSDictionary *)dict:(NSString *)modelId;
- (void)payOffer:(NSDictionary *)dict:(NSString *)modelId;
- (void)confirmPaymentOffer:(NSDictionary *)dict:(NSString *)modelId;
- (void)getOfferMessages:(NSString *)offerId;
- (void)createOfferMessage:(NSDictionary *)dict:(NSString *)offerId;
- (void)loadSettings;

- (void)createStatusCall:(NSDictionary *)dict;

- (void)phoneNotify;
- (void)phoneVerify:(NSString *)token;

//- (void)getPrivatePub;
//- (void)sendIphoneToken:(NSDictionary *)dict;

- (void)signUp:(NSDictionary *)dict;
- (void)login:(NSDictionary *)dict;
- (void)logout:(NSString *)token;
- (void)getAuth;

- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;

+ (NSData *)loadSettings;
+ (NSData *)login:(NSDictionary *)dict;
+ (NSData *)getListings:(NSDictionary *)dict;

@end
