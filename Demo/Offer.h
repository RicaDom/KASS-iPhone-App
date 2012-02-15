//
//  Offer.h
//  Demo
//
//  Created by zhicai on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@interface Offer : NSObject

@property (nonatomic, strong) NSString *dbId;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *listingId;
@property (nonatomic, strong) Message *lastMessage;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSNumber *distance;

@end
