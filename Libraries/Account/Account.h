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

- (id)initWithEmailAndPassword:(NSString*)email:(NSString *)password;
- (id)initWithWeiboEncodedData:(NSString*)encode;

- (void)loginFinished:(NSData *)data;
- (void)login;
- (void)logout;
- (BOOL)isUserLoggedIn;

@end

