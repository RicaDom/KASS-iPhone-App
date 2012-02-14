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

@interface User : NSObject<WBSessionDelegate,WBSendViewDelegate,WBRequestDelegate, AccountSessionDelegate>{
  WeiBo *weibo;
  Account *account;
}

@property (nonatomic,assign) id<AccountActivityDelegate> delegate;
@property (nonatomic,strong,readonly) WeiBo* weibo;
@property (nonatomic,strong,readonly) Account* account;

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;

- (void) weiboLogin;
- (void) accountLogin:(NSString *)email:(NSString *)password;
- (void) logout;


@end