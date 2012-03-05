//
//  KassAppObjManager.h
//  Demo
//
//  Created by Qi He on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJObjManager.h"

@interface KassAppObjManager : NSObject

@property (nonatomic,strong)  HJObjManager* objMan;

- (BOOL) manage:(id<HJMOUser>)user;
- (void)changeFileCacheDirectory:(NSString *)cacheDir;
+ (KassAppObjManager *) sharedInstance;

@end
