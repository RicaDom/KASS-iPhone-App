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

@interface BrowseTableViewController : PullRefreshTableViewController <LocateMeDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *browseSegment;
@property (strong, nonatomic) IBOutlet UITableView *listingTableView;

- (IBAction)browseSegmentAction:(id)sender;
- (void)setupArray;
- (void)reloadTable;
- (void)switchBrowseItemView;

- (void)getNearbyItems:(NSData *)data;

@end
