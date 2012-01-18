//
//  Listing.h
//  Demo
//
//  Created by Qi He on 12-1-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KassApi.h"
#import "ListItem.h"

@interface Listing : NSObject

@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSData   *data;
@property (nonatomic, copy  ) NSMutableArray  *listItems;


- (NSDictionary *)getListings;
- (NSData *)fetch;

@end
