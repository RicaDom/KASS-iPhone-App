//
//  BrowseItemNoMsgViewController.h
//  Demo
//
//  Created by zhicai on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Constants.h"
#import "VariableStore.h"
#import "BrowseTableViewController.h"
#import "UIResponder+VariableStore.h"
#import "PullToRefreshView.h"
#import "DataSourceViewController.h"
#import "KassApp.h"
#import "ViewHelper.h"

@interface BrowseItemNoMsgViewController : DataSourceViewController <UIActionSheetDelegate, AccountActivityDelegate, UIScrollViewDelegate, KassAppDelegate, MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) ListItem *currentItem;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navigationButton;
@property (strong, nonatomic) IBOutlet UILabel *listingTitle;
@property (strong, nonatomic) IBOutlet UILabel *listingPrice;
@property (strong, nonatomic) IBOutlet UILabel *listingDate;
@property (strong, nonatomic) IBOutlet UILabel *offerPrice;
@property (strong, nonatomic) IBOutlet UILabel *changedPriceMessage;

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIView *buttomView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIButton *priceButton;
@property (strong, nonatomic) IBOutlet UIButton *userInfoButton;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;

- (IBAction)navigationButtonAction:(id)sender;
- (IBAction)leftButtonAction:(id)sender;

@end
