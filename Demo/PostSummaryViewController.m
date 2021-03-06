//
//  PostSummaryViewController.m
//  Demo
//
//  Created by zhicai on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PostSummaryViewController.h"
#import "UIResponder+VariableStore.h"
#import "UIViewController+ActivityIndicate.h"

#import "ListingMapAnnotaion.h"
#import "ListingImageAnnotationView.h"
#import "ListItem+ListItemHelper.h"
#import "MTPopupWindow.h"

@implementation PostSummaryViewController

@synthesize postTitle = _postTitle;
@synthesize postDesciptionTextField = _postDesciptionTextField;
@synthesize topInfoView = _topInfoView;
@synthesize postAskPrice = _postAskPrice;
@synthesize postDuration = _postDuration;
@synthesize renrenHintLabel = _renrenHintLabel;
@synthesize submitButton = _submitButton;
@synthesize postType = _postType;
@synthesize cancelButton = _cancelButton;
@synthesize mapView = _mapView;
@synthesize leftButton = _leftButton;
@synthesize weiboCheckBox = _weiboCheckBox;
@synthesize renrenCheckBox = _renrenCheckBox;
@synthesize weiboHintLabel = _weiboHintLabel;
@synthesize submitLabel = _submitLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)updateShareView
{
  if ([[VariableStore sharedInstance].user isWeiboLogin] > 0) {
    [ViewHelper buildCheckBoxButton:self.weiboCheckBox];
    self.weiboCheckBox.tag = 1; //ON
    self.weiboCheckBox.enabled = YES;
    self.weiboHintLabel.hidden = NO;
    self.weiboCheckBox.hidden = NO;
  } else {
    [ViewHelper buildCheckBoxButtonUncheck:self.weiboCheckBox];
    self.weiboCheckBox.tag = 0; //OFF
    self.weiboCheckBox.enabled = NO;
    self.weiboHintLabel.hidden = YES;
    self.weiboCheckBox.hidden = YES;
  }
  
  if ([[VariableStore sharedInstance].user isRenrenLogin ] > 0) {
    [ViewHelper buildCheckBoxButton:self.renrenCheckBox];
    self.renrenCheckBox.tag = 1; //ON
    self.renrenCheckBox.enabled = YES;
    self.renrenHintLabel.hidden = NO;
    self.renrenCheckBox.hidden = NO;
  } else {
    [ViewHelper buildCheckBoxButtonUncheck:self.renrenCheckBox];
    self.renrenCheckBox.tag = 0; //OFF
    self.renrenCheckBox.enabled = NO;
    self.renrenHintLabel.hidden = YES;
    self.renrenCheckBox.hidden = YES;
  }
}

- (void)updateCurrentView
{
  DLog(@"PostSummaryViewController::updateCurrentView ");
    // check states to display different button title
    if ([VariableStore sharedInstance].isLoggedIn) {
        // Update submit button label if it's an update
        if ([self.postType isEqualToString:POST_TYPE_EDITING]) {
            self.submitLabel.text = UI_BUTTON_LABEL_UPDATE;
        } else {
            self.submitLabel.text = UI_BUTTON_LABEL_POST_NOW;
        }
    } else {
        self.submitLabel.text = UI_BUTTON_LABEL_SIGNIN_TO_POST;
    }
    self.submitButton.hidden = FALSE;
    
  [self updateShareView];
  
    if ([self currentUser].avatarUrl.isPresent) {
      [ViewHelper buildRoundCustomImageViewWithFrame:_topInfoView:[self currentUser].avatarUrl:CGRectMake(10,5,50,50)];
    }
}

- (void) accountLoginFinished
{
    DLog(@"PostSummaryViewController::accountLoginFinished");
    [self updateCurrentView];
    [self hideIndicator];
}

- (void)loadCurrentPostingData
{
  DLog(@"PostSummaryViewController::loadCurrentPostingData");
    self.postTitle.text = [VariableStore sharedInstance].currentPostingItem.title;
    self.postDesciptionTextField.text = [VariableStore sharedInstance].currentPostingItem.description;
    self.postAskPrice.text = [NSString stringWithFormat:@"%@", [VariableStore sharedInstance].currentPostingItem.askPrice];

    if ([VariableStore sharedInstance].currentPostingItem.postDuration) {
        NSArray *keys = [self.settings.expiredTimeDict 
                         allKeysForObject:[VariableStore sharedInstance].currentPostingItem.postDuration];
        if (keys && [keys count] > 0) {
            NSString *selectedItem = [keys objectAtIndex:0];
            if ([selectedItem length] != 0) {
                self.postDuration.text = selectedItem;
            } else {
                self.postDuration.text = nil;
            }
        }
    }
  
  [self updateCurrentView];
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)setupCurrentPostingLocation
{
  VariableStore.sharedInstance.currentPostingItem.location = [[Location alloc] initWithCLLocation:VariableStore.sharedInstance.location];
  [VariableStore.sharedInstance.currentPostingItem buildMap:self.mapView];
  [self loadCurrentPostingData];
}

- (void)locateMeFinished
{
  DLog(@"PostSummaryViewController::locateMeFinished ");
  [self setupCurrentPostingLocation];
  [self hideIndicator];
}

- (void)customViewLoad
{
    self.submitButton.hidden = FALSE;
    [ViewHelper buildCancelButton:self.cancelButton];
    [ViewHelper buildEditButton:self.leftButton];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    DLog(@"PostSummaryViewController::viewDidLoad ");
    [super viewDidLoad];
    [self customViewLoad];
}

- (void)viewDidUnload
{
    [self setPostTitle:nil];
    [self setPostDesciptionTextField:nil];
    [self setPostAskPrice:nil];
    [self setPostDuration:nil];
    [self setSubmitButton:nil];
    [self setCancelButton:nil];
    [self setLeftButton:nil];
    [self setLeftButton:nil];
    [self setWeiboCheckBox:nil];
  [self setWeiboHintLabel:nil];
  [self setTopInfoView:nil];
  [self setSubmitLabel:nil];
  [self setRenrenHintLabel:nil];
  [self setRenrenCheckBox:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  if ([self kassVS].currentPostingItem && [self kassVS].currentPostingItem.location) {
    [self loadCurrentPostingData];
  }if (VariableStore.sharedInstance.location) {
    [self setupCurrentPostingLocation];
  }
  else{
    [self showIndicator:@"寻找您的位置..."];
    VariableStore.sharedInstance.locateMeManager.delegate = self;
    [VariableStore.sharedInstance.locateMeManager locateMe];
  }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancelAction:(id)sender {
    [[VariableStore sharedInstance] clearCurrentPostingItem];
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

- (void)shareListing:(NSDictionary *)dict
{
  ListItem *listItem = [[ListItem alloc] initWithDictionary:dict];
  if (self.weiboCheckBox.tag == 1) { 
    [VariableStore.sharedInstance.user weiboShare:listItem];
  }
  
  if (self.renrenCheckBox.tag == 1) {
    [VariableStore.sharedInstance.user renrenShare:listItem];
  }
}

- (void)accountDidCreateListing:(NSDictionary *)dict
{
  DLog(@"PostSummaryViewController::accountDidCreateListing:dict=%@", dict);
  [[self kassVS] appendPostingItemToListings:dict];
  
  [self shareListing:dict];
  
  [self hideIndicator];
  [self.presentingViewController dismissModalViewControllerAnimated:YES];
  [[NSNotificationCenter defaultCenter] postNotificationName: NEW_POST_NOTIFICATION 
														object: nil];
}

- (void)accountDidModifyListing:(NSDictionary *)dict
{
  DLog(@"PostSummaryViewController::accountDidModifyListing:dict=%@", dict);
//  [[self kassVS] appendPostingItemToListings:dict];
  [self shareListing:dict];
  
  [self hideIndicator];
  [self.presentingViewController dismissModalViewControllerAnimated:YES];
  [[NSNotificationCenter defaultCenter] postNotificationName: NEW_POST_NOTIFICATION 
                                                      object: nil];
}

- (IBAction)submitAction {
    if ([VariableStore sharedInstance].isLoggedIn) {
        DLog(@"PostSummaryViewController::(IBAction)submitAction:postingItem: \n");
        NSString *latlng = [NSString stringWithFormat:@"%+.6f,%+.6f", 
                          VariableStore.sharedInstance.location.coordinate.latitude, 
                          VariableStore.sharedInstance.location.coordinate.longitude]; 

        ListItem *postItem = [VariableStore sharedInstance].currentPostingItem;

        NSNumber *postDuration = (NSNumber *)postItem.postDuration;
        NSString *durationStr  = (NSString *)[self.settings.durationToServerDic objectForKey:postDuration];

        NSMutableDictionary* params = [[NSMutableDictionary alloc] init];

        [params setObject:postItem.title forKey:@"title"];
        if (postItem.description) { [params setObject:postItem.description forKey:@"description"]; }
        [params setObject:postItem.askPrice forKey:@"price"];
        [params setObject:durationStr forKey:@"time"];
        [params setObject:latlng forKey:@"latlng"];
     
        DLog(@"PostSummaryViewController::submitAction:params = %@", params);
        [self.submitLabel setText:TEXT_IN_PROCESS];
        self.submitButton.hidden = TRUE;
        if ([self.postType isEqualToString:POST_TYPE_EDITING] && self.postingItem.isPersisted) {
            [self.currentUser modifyListing:params:self.postingItem.dbId];
        }else{
            [self.currentUser createListing:params];
        }
    } else {
        [MTPopupWindow showWindowWithUIView:self.navigationController.view];
    }
}

- (IBAction)iwantAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)ipayAction:(id)sender {
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
}

- (IBAction)idateAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)leftButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)weiboCheckBoxAction:(id)sender {
    if (self.weiboCheckBox.tag == 0) {
        [ViewHelper buildCheckBoxButton:self.weiboCheckBox];
        self.weiboCheckBox.tag = 1;
    } else {
        [ViewHelper buildCheckBoxButtonUncheck:self.weiboCheckBox];
        self.weiboCheckBox.tag = 0;        
    }
}

- (IBAction)renrenCheckBoxAction:(id)sender {
  if (self.renrenCheckBox.tag == 0) {
    [ViewHelper buildCheckBoxButton:self.renrenCheckBox];
    self.renrenCheckBox.tag = 1;
  } else {
    [ViewHelper buildCheckBoxButtonUncheck:self.renrenCheckBox];
    self.renrenCheckBox.tag = 0;        
  }
}

@end
