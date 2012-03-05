//
//  KassApp.h
//  Demo
//
//  Created by Qi He on 12-3-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KassAppDelegate.h"
#import "KassAppObjManager.h"

@interface KassApp : NSObject

@property (nonatomic,assign) KassAppObjManager *kaObjManager;
@property (nonatomic,assign) id<KassAppDelegate> delegate;

- (id)initWithDelegate:(id<KassAppDelegate>)delegate;
- (void)loadSettings;
- (void)loadSettingsFinished:(NSData *)data;
- (void)loadAndStoreSettings;

- (BOOL)manageObj:(id<HJMOUser>)user;

@end
