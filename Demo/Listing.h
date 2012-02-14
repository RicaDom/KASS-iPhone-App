//
//  Listing.h
//  Demo
//
//  Created by Qi He on 12-1-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KassApi.h"
#import "Location.h"
#import "ListItem.h"

@interface Listing : NSObject

@property (nonatomic, strong) NSData   *data;
@property (nonatomic, copy  ) NSMutableArray  *listItems;
@property (nonatomic, strong) Location *location;


- (id) initWithDictionary:(NSDictionary *) theDict;
- (id) initWithData:(NSData *) theData;
- (void) printOut;

@end
