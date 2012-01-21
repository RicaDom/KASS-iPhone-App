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

@interface PostFlowViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (strong, nonatomic) NSString *postType;

- (IBAction)CancelAction:(id)sender;

@end
