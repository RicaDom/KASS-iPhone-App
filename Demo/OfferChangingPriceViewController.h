//
//  OfferChangingPriceViewController.h
//  Demo
//
//  Created by zhicai on 1/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "ViewHelper.h"

@interface OfferChangingPriceViewController : UIViewController

@property (strong, nonatomic) NSString *currentPrice;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UITextField *offerPriceTextField;

- (IBAction)doneChangingPriceAction:(id)sender;
- (IBAction)leftButtonAction:(id)sender;

@end
