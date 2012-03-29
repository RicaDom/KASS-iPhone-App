//
//  AboutDetailsViewController.h
//  kass
//
//  Created by Wesley Wang on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
- (IBAction)leftButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *contentView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end
