//
//  PostFlowViewController.h
//  Demo
//
//  Created by zhicai on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VariableStore.h"
#import "Constants.h"
#import "PostFlowPriceViewController.h"
#import "PostFlowSetDateViewController.h"
#import "PostSummaryViewController.h"
#import "ViewHelper.h"

@interface PostFlowViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) NSString *postType;
@property (strong, nonatomic) IBOutlet UITextView *desTextField;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;

- (IBAction)CancelAction:(id)sender;

@end
