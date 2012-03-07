//
//  ActiveModel.h
//  Demo
//
//  Created by Qi He on 12-3-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActiveModel : NSObject

@property (nonatomic, strong) NSString *dbId;

- (id) initWithDictionary:(NSDictionary *) theDictionary;
- (id) initWithData:(NSData *) theData;

- (NSDictionary *) toJson;

@end
