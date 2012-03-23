//
//  AboutViewController.h
//  kass
//
//  Created by Wesley Wang on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (strong, nonatomic) NSArray *aboutArray;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
- (IBAction)leftButtonAction:(id)sender;

@end
