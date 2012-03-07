//
//  PrivatePubClient.h
//  Demo
//
//  Created by Qi He on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FayeClient.h"

@interface PrivatePubClient : NSObject

@property (nonatomic, strong) NSMutableArray *fayeClients;
@property (nonatomic, strong) NSMutableArray *privatePubs;
@property (nonatomic,assign) id<FayeClientDelegate> delegate;

- (void)clear;
- (id)initWithDelegate:(id<FayeClientDelegate>)delegate;
- (void)addClient:(NSDictionary *)privatePubDict;
- (void)connectClients;
- (void)disconnectClients;

@end
