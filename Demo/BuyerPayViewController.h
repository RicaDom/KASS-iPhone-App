//
//  BuyerPayViewController.h
//  Demo
//
//  Created by zhicai on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"
#import "AccountActivityDelegate.h"
#import "Constants.h"
#import "CommonView.h"
#import "DataSourceViewController.h"
#import "ViewHelper.h"
#import "CustomImageViewPopup.h"

@interface BuyerPayViewController : DataSourceViewController <UIScrollViewDelegate, UITextFieldDelegate, AccountActivityDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) Offer *currentOffer;
@property (strong, nonatomic) IBOutlet UILabel *listingTitle;
@property (strong, nonatomic) IBOutlet UILabel *offerPrice;
@property (strong, nonatomic) IBOutlet UILabel *listingExpiredDate;
@property (strong, nonatomic) IBOutlet UIButton *userInfoButton;
@property (strong, nonatomic) IBOutlet UIButton *priceButton;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UITextField *messageTextField;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextField;
@property (strong, nonatomic) IBOutlet UILabel *changedPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *changedPriceMessage;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UILabel *payStatusLabel;
@property (weak, nonatomic) IBOutlet UIView *topInfoView;
@property (strong, nonatomic) IBOutlet UIView *payView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

- (IBAction)leftButtonAction:(id)sender;
- (IBAction)payButtonAction:(id)sender;
- (IBAction)rightButtonAction:(id)sender;

@end
