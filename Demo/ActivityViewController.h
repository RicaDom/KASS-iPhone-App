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
#import "ItemViewController.h"
#import "VariableStore.h"

@interface ActivityViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>{
    __weak IBOutlet UISegmentedControl *activitySegment;
}

- (IBAction)activityChanged:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *emptyRecordsImageView;
@property (weak, nonatomic) IBOutlet UITableView *listingsTableView;

- (void)setupArray;
- (void)reloadTable;
- (void)getBuyingItems:(NSData *)data;

@end
