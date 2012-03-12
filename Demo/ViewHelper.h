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
#import "Constants.h"

@interface ViewHelper : NSObject

+ (NSString *)getTitleFromOfferMessage:(User *)user:(Offer *)offer:(int)index;

// offers
+ (void) buildOfferScrollView:(IBOutlet UIScrollView *)scrollView:(User *)user:(Offer *)offer;
+ (void) buildOfferAcceptedCell:(Offer *)item:(ListingTableCell *)cell;
+ (void) buildOfferPendingCell:(Offer *)item:(ListingTableCell *)cell;
+ (void) buildOfferExpiredCell:(Offer *)item:(ListingTableCell *)cell;

// listItems
+ (void) buildListItemPayNowCell:(ListItem *)item:(ListingTableCell *)cell;
+ (void) buildListItemHasOffersCell:(ListItem *)item:(ListingTableCell *)cell;
+ (void) buildListItemNoOffersCell:(ListItem *)item:(ListingTableCell *)cell;
+ (void) buildListItemExpiredCell:(ListItem *)item:(ListingTableCell *)cell;

+ (void) buildMapButton:(UIButton *)button;
+ (void) buildBackButton:(UIButton *)button;
+ (void) buildUserInfoButton:(UIButton *)button;
+ (void)buildCancelButton:(UIButton *)button;
+ (void)buildNextButton:(UIButton *)button;
+ (void)buildNextButtonDis:(UIButton *)button;

+ (void)showErrorAlert:(NSString *)message:(id)delegate;
+ (void)showErrorMessageAlert:(NSDictionary *)errors:(id)delegate;

@end
