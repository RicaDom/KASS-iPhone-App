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

@interface BrowseItemViewController : UIViewController <UIScrollViewDelegate, PullToRefreshViewDelegate, AccountActivityDelegate>

@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemExpiredDate;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceChangedToLabel;
@property (strong, nonatomic) ListItem *currentItem;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navigationButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *tpScrollView;
@property (strong, nonatomic) PullToRefreshView *pull;

- (IBAction)navigationButtonAction:(id)sender;
@end
