//
//  AboutVideoViewController.h
//  kass
//
//  Created by zhicai on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ActivityIndicate.h"

@interface AboutVideoViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *leftNavigationButton;
@property (strong, nonatomic) IBOutlet UIWebView *videoWebView;
- (IBAction)leftNavigationButtonAction:(id)sender;
@end
