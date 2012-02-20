//
//  ActivityOfferMessageViewController.h
//  Demo
//
//  Created by zhicai on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullToRefreshView.h"
#import "ListItem.h"
#import "Offer.h"
#import "Message.h"
#import "VariableStore.h"
#import "AccountActivityDelegate.h"
#import "OfferChangingPriceViewController.h"
#import "UIResponder+VariableStore.h"

@interface ActivityOfferMessageViewController : UIViewController <UIScrollViewDelegate, PullToRefreshViewDelegate, AccountActivityDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) PullToRefreshView *pull;
//@property (strong, nonatomic) ListItem *currentItem;
@property (strong, nonatomic) Offer *currentOffer;
@property (strong, nonatomic) IBOutlet UILabel *listingTitle;
@property (strong, nonatomic) IBOutlet UILabel *listingDescription;
@property (strong, nonatomic) IBOutlet UILabel *offerPrice;
@property (strong, nonatomic) IBOutlet UILabel *listingExpiredDate;
@property (strong, nonatomic) IBOutlet UILabel *changingPrice;

- (IBAction)sellerInfoAction:(id)sender;
- (IBAction)confirmDealAction:(id)sender;

@end

