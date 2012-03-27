//
//  Offer+OfferHelper.h
//  Demo
//
//  Created by Qi He on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Offer.h"
#import "ListItem.h"
#import "BaseHelper.h"

@class ListingTableCell;

@interface Offer (OfferHelper)

- (NSString *) getPriceText;
- (NSString *) getListItemTimeLeftTextlong;
- (ListItem *) getListItemToMap;
- (UIColor *) getStateColor;
- (int) getStateWidthOffset;

+ (NSMutableDictionary *) getParamsToModify:(NSInteger)price:(NSString *)message;
+ (NSMutableDictionary *) getParamsToCreate:(NSInteger)price:(NSString *)message:(ListItem *)listItem;

- (void) buildOffererImageView:(UIView *)view;
- (void) buildStatusIndicationView:(UIView *)view;
- (void) buildListingTableCell:(ListingTableCell *)cell;
- (void) buildMessagesScrollView:(UIScrollView *)scrollView:(User *)user;

@end
