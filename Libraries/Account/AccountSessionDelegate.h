//
//  AccountSessionDelegate.h
//  Demo
//
//  Created by Qi He on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AccountSessionDelegate <NSObject>

@optional
- (void)accountDidLogin;
- (void)accountLoginFailed:(NSDictionary *)error;
- (void)accountDidLogout;

- (void)requestFailed:(NSDictionary *)errors;

@end