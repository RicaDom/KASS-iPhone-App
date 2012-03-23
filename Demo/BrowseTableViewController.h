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
#import "LocateMeDelegate.h"
#import "ItemViewController.h"
#import "BrowseItemNoMsgViewController.h"
#import "BuyerPayViewController.h"
#import "UIResponder+VariableStore.h"

@interface BrowseTableViewController : UIViewController <UISearchDisplayDelegate, UISearchBarDelegate,LocateMeDelegate> {
	NSDictionary *transferJson;
  BOOL _searching;
  CLLocation *location;
  BOOL _locating;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *browseSegment;
@property (strong, nonatomic) IBOutlet UITableView *listingTableView;
@property (strong, nonatomic) NSMutableArray *currentListings;
@property (strong, nonatomic) NSMutableArray *filteredListContent;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) NSString *remoteNotificationListingId;
@property (strong, nonatomic) IBOutlet UIImageView *tableFooter;
- (IBAction)leftButtonAction:(id)sender;

- (IBAction)browseSegmentAction:(id)sender;
- (void)loadDataSource;
- (void)reloadTable;
- (void)locateMe;
- (void)populateData;

@end
