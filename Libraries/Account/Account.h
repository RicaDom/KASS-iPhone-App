//
//  Account.h
//  Demo
//
//  Created by Qi He on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountSessionDelegate.h"

@interface Account : NSObject

@property (nonatomic,assign) id<AccountSessionDelegate> delegate;
@property (nonatomic,retain,readonly) NSString* userDbId;
@property (nonatomic,retain,readonly) NSString* userName;
@property (nonatomic,retain,readonly) NSString* password;
@property (nonatomic,retain,readonly) NSString* weiboId;
@property (nonatomic,retain,readonly) NSString* email;
@property (nonatomic,retain,readonly) NSString* encode;
@property (nonatomic,retain,readonly) NSString* phone;
@property (nonatomic,retain,readonly) NSString* city;
@property (nonatomic,retain,readonly) NSString* avatarUrl;
@property (nonatomic,retain,readonly) NSArray* devices;
@property (nonatomic,retain,readonly) NSString* encodeRenren;

- (id)initWithDictionary:(NSDictionary *)dict;
- (id)initWithEmailAndPassword:(NSString*)email:(NSString *)password;
- (id)initWithWeiboEncodedData:(NSString*)encode;
- (id)initWithRenrenEncodedData:(NSString*)encode;

- (void)getAuth;
- (void)getAuthFinished:(NSData *)data;

- (void)loginFinished:(NSData *)data;
- (void)logoutFinished:(NSData *)data;
- (void)signupFinished:(NSData *)data;
- (void)login;
- (void)signup;
- (void)logout;
- (BOOL)isUserLoggedIn;

@end


