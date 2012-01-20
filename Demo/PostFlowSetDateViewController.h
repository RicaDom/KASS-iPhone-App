//
//  PostFlowSetDateViewController.h
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VariableStore.h"

@interface PostFlowSetDateViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIPickerView *PostDueDatePicker;
@property (weak, nonatomic) IBOutlet UILabel *PostDueDateLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *PostFlowSegment;

@end
