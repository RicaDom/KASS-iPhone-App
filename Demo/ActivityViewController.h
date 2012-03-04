//
//  ActivityViewController.h
//  Demo
//
//  Created by zhicai on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListItem.h"
#import "Listing.h"
#import "Offers.h"
#import "Offer.h"
#import "ItemViewController.h"
#import "VariableStore.h"
#import "ListingTableCell.h"
#import "PullRefreshTableViewController.h"
#import "AccountActivityDelegate.h"
#import "BrowseItemViewController.h"
#import "BuyerPayViewController.h"

@interface ActivityViewController : UITableViewController <AccountActivityDelegate, EGORefreshTableHeaderDelegate>
{
	EGORefreshTableHeaderView *_refreshHeaderView;
	
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes 
	BOOL _reloading;
}


@property (strong, nonatomic) IBOutlet UISegmentedControl *activitySegment;
@property (strong, nonatomic) IBOutlet UIImageView *emptyRecordsImageView;
@property (weak, nonatomic) IBOutlet UITableView *listingsTableView;

- (IBAction)activityChanged:(id)sender;
- (void)loadDataSource;
- (void)reloadTable;
- (void)getBuyingItems:(NSDictionary *)dict;
- (void)getSellingItems:(NSDictionary *)dict;

@end
