//
//  BrowseItemViewController.h
//  Demo
//
//  Created by zhicai on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListItem.h"
#import "Constants.h"
#import "PullToRefreshView.h"
#import "OfferChangingPriceViewController.h"
#import "AccountActivityDelegate.h"
#import "UIResponder+VariableStore.h"
#import "CommonView.h"
#import "DataSourceViewController.h"
#import "Offer+OfferHelper.h"
#import "UILabel+VerticalAlign.h"

@interface BrowseItemViewController : DataSourceViewController <UIScrollViewDelegate, AccountActivityDelegate>

@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemExpiredDate;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceChangedToLabel;

@property (strong, nonatomic) Offer *currentOffer;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navigationButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIView *buttomView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *priceButton;
@property (strong, nonatomic) IBOutlet UIButton *userInfoButton;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UILabel *changePriceMessage;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;

- (IBAction)leftButtonAction:(id)sender;
- (IBAction)rightButtonAction:(id)sender;
- (void)confirmPayment;

@end
