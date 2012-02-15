//
//  Offers.h
//  Demo
//
//  Created by Qi He on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KassApi.h"
#import "Location.h"
#import "Offer.h"

@interface Offers : NSObject

@property (nonatomic, strong) NSData   *data;
@property (nonatomic, copy  ) NSMutableArray  *offers;
@property (nonatomic, strong) Location *location;


- (id) initWithDictionary:(NSDictionary *) theDict;
- (id) initWithData:(NSData *) theData;
- (void) printOut;


@end
