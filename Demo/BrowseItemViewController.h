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
#import "TPKeyboardAvoidingScrollView.h"
#import "AccountActivityDelegate.h"
#import "UIResponder+VariableStore.h"
#import "CommonView.h"
#import "DataSourceViewController.h"

@interface BrowseItemViewController : DataSourceViewController <UIScrollViewDelegate, PullToRefreshViewDelegate, AccountActivityDelegate>
{
    CGRect _keyboardRect; // for keyboard avoiding
}

@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemExpiredDate;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceChangedToLabel;

@property (strong, nonatomic) Offer *currentOffer;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navigationButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *tpScrollView;
@property (strong, nonatomic) PullToRefreshView *pull;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIView *buttomView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *priceButton;
@property (strong, nonatomic) IBOutlet UIButton *userInfoButton;

- (IBAction)navigationButtonAction:(id)sender;

@end
