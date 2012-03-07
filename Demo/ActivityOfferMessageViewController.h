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
#import "Offer+OfferHelper.h"
#import "Message.h"
#import "VariableStore.h"
#import "AccountActivityDelegate.h"
#import "OfferChangingPriceViewController.h"
#import "UIResponder+VariableStore.h"
#import "DataSourceViewController.h"
#import "CommonView.h"

@interface ActivityOfferMessageViewController : DataSourceViewController <UIScrollViewDelegate, PullToRefreshViewDelegate, AccountActivityDelegate>
{
    CGRect _keyboardRect; // for keyboard avoiding
}


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) PullToRefreshView *pull;
@property (strong, nonatomic) Offer *currentOffer;
@property (strong, nonatomic) IBOutlet UILabel *listingTitle;
@property (strong, nonatomic) IBOutlet UILabel *offerPrice;
@property (strong, nonatomic) IBOutlet UILabel *listingExpiredDate;
@property (strong, nonatomic) IBOutlet UILabel *changingPrice;
@property (strong, nonatomic) IBOutlet UITextField *sendMessageTextField;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIView *buttomView;
@property (strong, nonatomic) IBOutlet UIButton *userInfoButton;
@property (strong, nonatomic) IBOutlet UIButton *priceButton;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextField;

- (IBAction)sellerInfoAction:(id)sender;
- (IBAction)confirmDealAction:(id)sender;
- (IBAction)sendMessageOrMapAction:(UIBarButtonItem *)sender;

@end

