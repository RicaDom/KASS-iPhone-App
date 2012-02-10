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

@interface BrowseItemNoMsgViewController : UIViewController <UIActionSheetDelegate>

@property (strong, nonatomic) ListItem *currentItem;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navigationButton;

- (IBAction)navigationButtonAction:(id)sender;
@end
