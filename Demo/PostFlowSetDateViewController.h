//
//  PostFlowSetDateViewController.h
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VariableStore.h"
#import "PostSummaryViewController.h"
#import "BaseHelper.h"
#import "ViewHelper.h"

@interface PostFlowSetDateViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIPickerView *PostDurationPicker;
@property (weak, nonatomic) IBOutlet UILabel *PostDurationLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *PostFlowSegment;
@property (strong, nonatomic) NSString *postType;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)backButtonAction:(id)sender;

@end
