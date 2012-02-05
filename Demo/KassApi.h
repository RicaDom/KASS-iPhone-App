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

@interface KassApi : NSObject

@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSString *response;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSObject *performer;

- (id) initWithPerformerAndAction:(NSObject *)thePerformer:(NSString *)theAction;

//+ (NSData *)getData:(NSString *)url;
//+ (NSData *)postData:(NSString *)url:(NSDictionary *)dict;
//+ (NSData *)getListings:(NSString *)box;
//+ (NSData *)getListing:(NSString *)modelId;

+ (NSDictionary *)parseData:(NSData *)data;
+ (void)logData:(NSDictionary *)dict;

- (void)postData:(NSString *)url:(NSDictionary *)dict;
- (void)getData:(NSString *)url;

- (void)getListings:(NSDictionary *)dict;
- (void)getListing:(NSString *)modelId;
- (void)getAccountListings;
- (void)login:(NSDictionary *)dict;

- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;

@end
