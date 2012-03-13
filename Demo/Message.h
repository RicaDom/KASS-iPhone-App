//
//  Message.h
//  Demo
//
//  Created by zhicai on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActiveModel.h"

@class Offer;

@interface Message : ActiveModel

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSDate *createdAt;

- (id) initWithOffer:(Offer *)offer;
- (id) initWithDictionary:(NSDictionary *) theDictionary;

@end
