//
//  MyActivityViewController.h
//  Demo
//
//  Created by Wesley Wang on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListItem.h"
#import "Listing.h"
#import "Offers.h"
#import "Offer.h"
#import "ItemViewController.h"
#import "VariableStore.h"
#import "ListingTableCell.h"
#import "AccountActivityDelegate.h"
#import "BrowseItemViewController.h"
#import "BuyerPayViewController.h"

@interface ActivityViewController : UIViewController <AccountActivityDelegate>
@property (weak, nonatomic) IBOutlet UILabel *iSell;
@property (weak, nonatomic) IBOutlet UILabel *iWant;

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) IBOutlet UISegmentedControl *activitySegment;
@property (strong, nonatomic) IBOutlet UIImageView *emptyRecordsImageView;
@property (weak, nonatomic) IBOutlet UITableView *listingsTableView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIImageView *tabImageView;
@property (strong, nonatomic) IBOutlet UIImageView *emptyImageView;
@property (strong, nonatomic) IBOutlet UIImageView *indicatorImageView;

- (void)loadDataSource;
- (void)reloadTable;
- (void)getBuyingItems:(NSDictionary *)dict;
- (void)getSellingItems:(NSDictionary *)dict;
- (void)updateTableView;

- (IBAction)activityChanged:(id)sender;
- (IBAction)pressBuyingListButton:(id)sender;
- (IBAction)pressSellingListButton:(id)sender;

@end
