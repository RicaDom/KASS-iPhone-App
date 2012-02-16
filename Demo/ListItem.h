//
//  ListItem.h
//  Demo
//
//  Created by zhicai on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KassApi.h"
#import "Location.h"
#import "Offer.h"

@interface ListItem : NSObject

@property (nonatomic, strong) NSString *dbId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSDate *postedDate;
@property (nonatomic, strong) NSDecimalNumber *askPrice;
@property (nonatomic, strong) NSString *picFileName;
@property (nonatomic, strong) NSNumber *postDuration;  // in minutes??
@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) NSMutableArray *offers;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSDate *endedAt;

@property (nonatomic, strong) NSData   *data;

- (NSDecimalNumber *) price;
- (id) initWithDictionary:(NSDictionary *) theDictionary;
- (id) initWithData:(NSData *) theData;

@end
