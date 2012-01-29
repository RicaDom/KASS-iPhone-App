//
//  OfferChangingPriceViewController.h
//  Demo
//
//  Created by zhicai on 1/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferChangingPriceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *offerPriceTextField;
- (IBAction)cancelChangingPriceAction:(id)sender;
- (IBAction)doneChangingPriceAction:(id)sender;

@end
