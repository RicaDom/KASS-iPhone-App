//
//  Message.h
//  Demo
//
//  Created by zhicai on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic, strong) NSString *dbId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSDate *createdAt;

- (id) initWithDictionary:(NSDictionary *) theDictionary;

@end
