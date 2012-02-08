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
#import "PullRefreshTableViewController.h"

@interface BrowseItemViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
//PullRefreshTableViewController 
//UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemExpiredDate;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceChangedToLabel;
@property (strong, nonatomic) ListItem *currentItem;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navigationButton;
@property (strong, nonatomic) IBOutlet UITableView *messageTableView;

- (IBAction)navigationButtonAction:(id)sender;
@end
