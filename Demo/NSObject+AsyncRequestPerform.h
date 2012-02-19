//
//  NSObject+AsyncRequestPerform.h
//  Demo
//
//  Created by Qi He on 12-2-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AsyncRequestPerform)

- (void)perform:(NSData *)data:(NSString *)action;
- (void)requestFailed:(NSDictionary *)dict;
//- (void)requestFailedFinished:(NSDictionary *)errors;

@end
