//
//  KassApi.h
//  MyZaarlyDemo
//
//  Created by Qi He on 12-1-17.
//  Copyright (c) 2012年 Heyook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "ASIHTTPRequest.h"

@interface KassApi : NSObject

+ (NSData *)getData:(NSString *)url;
+ (NSDictionary *)parseData:(NSData *)data;
+ (void)logData:(NSDictionary *)dict;

@end
