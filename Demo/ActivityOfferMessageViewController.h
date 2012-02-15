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

@interface ActivityOfferMessageViewController : UIViewController <UIScrollViewDelegate, PullToRefreshViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) PullToRefreshView *pull;
@property (strong, nonatomic) ListItem *currentItem;
@property (strong, nonatomic) Offer *currentOffer;
@property (strong, nonatomic) IBOutlet UILabel *listingTitle;
@property (strong, nonatomic) IBOutlet UILabel *listingDescription;
@property (strong, nonatomic) IBOutlet UILabel *offerPrice;
@property (strong, nonatomic) IBOutlet UILabel *listingExpiredDate;
- (IBAction)sellerInfoAction:(id)sender;

@end
