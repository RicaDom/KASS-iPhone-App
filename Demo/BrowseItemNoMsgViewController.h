//
//  BrowseItemNoMsgViewController.h
//  Demo
//
//  Created by zhicai on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "VariableStore.h"
#import "BrowseTableViewController.h"
#import "UIResponder+VariableStore.h"
#import "PullToRefreshView.h"
#import "DataSourceViewController.h"
#import "KassApp.h"

@interface BrowseItemNoMsgViewController : DataSourceViewController <UIActionSheetDelegate, AccountActivityDelegate, UIScrollViewDelegate, PullToRefreshViewDelegate, KassAppDelegate>

@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) ListItem *currentItem;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navigationButton;
@property (strong, nonatomic) IBOutlet UILabel *listingTitle;
@property (strong, nonatomic) IBOutlet UILabel *listingPrice;
@property (strong, nonatomic) IBOutlet UILabel *listingDate;
@property (strong, nonatomic) IBOutlet UILabel *offerPrice;

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIView *buttomView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIButton *priceButton;
@property (strong, nonatomic) PullToRefreshView *pull;
@property (strong, nonatomic) IBOutlet UIButton *userInfoButton;

- (IBAction)navigationButtonAction:(id)sender;

@end
