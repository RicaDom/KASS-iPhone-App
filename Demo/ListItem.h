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
#import "ActiveModel.h"

@class User;

@interface ListItem : ActiveModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSDate *postedDate;
@property (nonatomic, strong) NSDecimalNumber *askPrice;
@property (nonatomic, strong) NSString *picFileName;
@property (nonatomic, strong) NSNumber *postDuration; 
@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSDate *endedAt;

@property (nonatomic, strong) NSMutableArray *offers;
@property (nonatomic, strong) NSMutableArray *offererIds;
@property (nonatomic, strong) NSDecimalNumber *acceptedPrice;
@property (nonatomic, strong) Offer *acceptedOffer;

@property (nonatomic, strong) NSData   *data;


///////////////// model helper methods ////////////
- (NSDecimalNumber *) price;
- (BOOL) isExpired;
- (BOOL) isAccepted;
- (BOOL) isPersisted;
- (BOOL) hasOfferer:(User *)user;
- (Offer *) getOfferFromOfferer:(User *)user;

@end
