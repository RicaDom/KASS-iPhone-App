//
//  Offer+OfferHelper.m
//  Demo
//
//  Created by Qi He on 12-3-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Offer+OfferHelper.h"

@implementation Offer (OfferHelper)

- (NSString *) getPriceText
{
  return [NSString stringWithFormat:@"￥%@", self.price];
}

- (NSString *) getListItemTimeLeftTextlong
{
  NSString *timeLeftText = [BaseHelper getTimeFromNowText:[NSDate date]:[self listItemEndedAt]];
  return timeLeftText ? [[NSString alloc] initWithFormat:@"还有 %@", timeLeftText] : @"已经过期";
}

+ (NSMutableDictionary *) getParamsToModify:(NSInteger)price :(NSString *)message
{
  return [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%d", price], @"price", message, @"with_message",nil];
}

+ (NSMutableDictionary *) getParamsToCreate:(NSInteger)price:(NSString *)message:(ListItem *)listItem
{
  return [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", price], @"price", message, @"message",listItem.dbId, @"listing_id", nil];
}

- (ListItem *) getListItemToMap
{
  NSDictionary *listing = [[NSDictionary alloc] initWithObjectsAndKeys:
                           self.title, @"title", self.description, @"description", 
                           self.listingId, @"id", nil ];
  
  ListItem *listItem = [[ListItem alloc] initWithDictionary:listing];
  listItem.location = self.listItemLocation;
  
  return listItem;
}

@end
