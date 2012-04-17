//
//  UserInfoViewController.h
//  Demo
//
//  Created by Wesley Wang on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "KassAppDelegate.h"
#import "HJManagedImageV.h"

@interface UserInfoViewController : UIViewController <KassAppDelegate>{
  HJManagedImageV *hjManagedImageView;
  UITapGestureRecognizer *singleFingerTap;
  BOOL _emailVerified;
  BOOL _weiboVerified;
  BOOL _renrenVerified;
  BOOL _phoneVerified;
  NSString *_phone_number;
}

@property (strong, nonatomic) NSString *userId;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIView *imageContainerView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *regDate;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
- (IBAction)leftButtonAction:(id)sender;

@end
