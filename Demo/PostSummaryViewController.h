//
//  PostSummaryViewController.h
//  Demo
//
//  Created by zhicai on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VariableStore.h"
#import "NSString+ModelHelper.h"

@interface PostSummaryViewController : UIViewController <LocateMeDelegate, AccountActivityDelegate>
@property (weak, nonatomic) IBOutlet UILabel *postTitle;
@property (weak, nonatomic) IBOutlet UILabel *postDescription;
@property (weak, nonatomic) IBOutlet UILabel *postAskPrice;
@property (weak, nonatomic) IBOutlet UILabel *postDuration;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) NSString *postType;
- (IBAction)cancelAction:(id)sender;
- (IBAction)submitAction;

@end
