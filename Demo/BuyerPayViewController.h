//
//  BuyerPayViewController.h
//  Demo
//
//  Created by zhicai on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullToRefreshView.h"
#import "Offer.h"
#import "AccountActivityDelegate.h"
#import "Constants.h"

@interface BuyerPayViewController : UIViewController <UIScrollViewDelegate, PullToRefreshViewDelegate, AccountActivityDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) PullToRefreshView *pull;
@property (strong, nonatomic) Offer *currentOffer;
@property (strong, nonatomic) IBOutlet UILabel *listingTitle;
@property (strong, nonatomic) IBOutlet UILabel *listingDescription;
@property (strong, nonatomic) IBOutlet UILabel *offerPrice;
@property (strong, nonatomic) IBOutlet UILabel *listingExpiredDate;

@end
