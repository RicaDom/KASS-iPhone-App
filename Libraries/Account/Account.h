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

- (void)loginFinished:(NSData *)data;
- (void)login;
- (void)logout;
- (BOOL)isUserLoggedIn;

@end


