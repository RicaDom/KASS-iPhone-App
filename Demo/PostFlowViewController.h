//
//  PostFlowViewController.h
//  Demo
//
//  Created by zhicai on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostFlowViewController : UIViewController {
    UITabBarController *currentTabBarController;
}
@property (nonatomic, strong) UITabBarController *currentTabBarController;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

- (IBAction)CancelAction:(id)sender;

@end
