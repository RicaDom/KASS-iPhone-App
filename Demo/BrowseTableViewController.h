//
//  BrowseTableViewController.h
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ListItem.h"
#import "Listing.h"
#import "BrowseItemViewController.h"
#import "VariableStore.h"
#import "UIResponder+LocateMe.h"
#import "ListingTableCell.h"
#import "PullRefreshTableViewController.h"

@interface BrowseTableViewController : PullRefreshTableViewController {
  CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *browseSegment;
@property (strong, nonatomic) IBOutlet UITableView *listingTableView;

- (IBAction)browseSegmentAction:(id)sender;
- (void)setupArray;
- (void)reloadTable;
- (void)switchBrowseItemView;

- (void)getNearbyItems:(NSData *)data;

@end
