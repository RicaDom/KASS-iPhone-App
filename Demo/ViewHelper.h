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

@interface ViewHelper : NSObject

+ (NSString *)getTitleFromOfferMessage:(User *)user:(Offer *)offer:(int)index;
+ (void) buildOfferScrollView:(IBOutlet UIScrollView *)scrollView:(User *)user:(Offer *)offer;


@end
