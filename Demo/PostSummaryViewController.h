//
//  PostSummaryViewController.h
//  Demo
//
//  Created by zhicai on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "VariableStore.h"
#import "NSString+ModelHelper.h"
#import "ViewHelper.h"

@interface PostSummaryViewController : UIViewController <LocateMeDelegate, AccountActivityDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *postTitle;
@property (weak, nonatomic) IBOutlet UILabel *postAskPrice;
@property (weak, nonatomic) IBOutlet UILabel *postDuration;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) NSString *postType;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UITextView *postDesciptionTextField;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)cancelAction:(id)sender;
- (IBAction)submitAction;
- (IBAction)iwantAction:(id)sender;
- (IBAction)ipayAction:(id)sender;
- (IBAction)idateAction:(id)sender;

@end
