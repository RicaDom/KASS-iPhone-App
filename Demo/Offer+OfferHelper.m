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
  return [[NSString alloc] initWithFormat:@"还有 %@", [BaseHelper getTimeFromNowText:[NSDate date]:self.listItemEndedAt]];
}

@end
