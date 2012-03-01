//
//  ViewHelper.h
//  Demo
//
//  Created by Qi He on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Offer.h"
#import "Message.h"
#import "User.h"
#import "ListingTableCell.h"

@interface ViewHelper : NSObject

+ (NSString *)getTitleFromOfferMessage:(User *)user:(Offer *)offer:(int)index;

// offers
+ (void) buildOfferScrollView:(IBOutlet UIScrollView *)scrollView:(User *)user:(Offer *)offer;
+ (void) buildOfferAcceptedCell:(Offer *)item:(ListingTableCell *)cell;
+ (void) buildOfferExpiredCell:(Offer *)item:(ListingTableCell *)cell;
+ (void) buildOfferExpiredCell:(Offer *)item:(ListingTableCell *)cell;

// listItems
+ (void) buildListItemPayNowCell:(ListItem *)item:(ListingTableCell *)cell;
+ (void) buildListItemHasOffersCell:(ListItem *)item:(ListingTableCell *)cell;
+ (void) buildListItemNoOffersCell:(ListItem *)item:(ListingTableCell *)cell;

@end
