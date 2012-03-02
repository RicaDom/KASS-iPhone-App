//
//  PostFlowPriceViewController.h
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VariableStore.h"
#import "PostFlowSetDateViewController.h"

@interface PostFlowPriceViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (strong, nonatomic) NSString *postType;

@end
