//
//  BrowseTableViewController.h
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListItem.h"
#import "Listing.h"
#import "BrowseItemViewController.h"
#import "VariableStore.h"
#import "ListingTableCell.h"
#import "PullRefreshTableViewController.h"
#import "LocateMeDelegate.h"
#import "ItemViewController.h"
#import "BrowseItemNoMsgViewController.h"
#import "UIResponder+VariableStore.h"

@interface BrowseTableViewController : PullRefreshTableViewController <LocateMeDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *browseSegment;
@property (strong, nonatomic) IBOutlet UITableView *listingTableView;

@property (strong, nonatomic) NSMutableArray *currentListings;

- (IBAction)browseSegmentAction:(id)sender;
- (void)setupArray;
- (void)reloadTable;
- (void)switchBrowseItemView;
- (void)locateMe;

- (void)getNearbyItems:(NSData *)data;
- (void)getRecentItems:(NSData *)data;
- (void)getMostPriceItems:(NSData *)data;

@end
