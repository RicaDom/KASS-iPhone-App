//
//  PostSummaryViewController.m
//  Demo
//
//  Created by zhicai on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PostSummaryViewController.h"
#import "UIResponder+VariableStore.h"

#import "ListingMapAnnotaion.h"
#import "ListingImageAnnotationView.h"
#import "ListItem+ListItemHelper.h"

@implementation PostSummaryViewController

@synthesize postTitle = _postTitle;
@synthesize postDesciptionTextField = _postDesciptionTextField;
@synthesize postAskPrice = _postAskPrice;
@synthesize postDuration = _postDuration;
@synthesize submitButton = _submitButton;
@synthesize postType = _postType;
@synthesize cancelButton = _cancelButton;
@synthesize mapView = _mapView;
@synthesize leftButton = _leftButton;

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
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)locateMeFinished
{
  DLog(@"PostSummaryViewController::locateMeFinished ");
  [self loadCurrentPostingData];
  
  VariableStore.sharedInstance.currentPostingItem.location = [[Location alloc] initWithCLLocation:VariableStore.sharedInstance.location];
  
  [VariableStore.sharedInstance.currentPostingItem buildMap:self.mapView];
}

- (void)customViewLoad
{
    UIImage* signUpButtonImg = [UIImage imageNamed:UI_IMAGE_POST_SEND_BUTTON];
    UIImage* signUpButtonPressImg = [UIImage imageNamed:UI_IMAGE_POST_SEND_BUTTON_PRESS];
    [self.submitButton setBackgroundImage:signUpButtonImg forState:UIControlStateNormal];
    [self.submitButton setBackgroundImage:signUpButtonPressImg forState:UIControlStateSelected];
    
    // Update submit button label if it's an update
    if ([self.postType isEqualToString:POST_TYPE_EDITING]) {
        self.submitButton.titleLabel.text = UI_BUTTON_LABEL_UPDATE;
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    DLog(@"PostSummaryViewController::viewDidLoad ");
    [super viewDidLoad];
    VariableStore.sharedInstance.locateMeManager.delegate = self;
    [VariableStore.sharedInstance.locateMeManager locateMe];
    [self customViewLoad];
    [ViewHelper buildCancelButton:self.cancelButton];
    [ViewHelper buildEditButton:self.leftButton];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadCurrentPostingData];
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

- (void)accountDidCreateListing:(NSDictionary *)dict
{
  DLog(@"PostSummaryViewController::accountDidCreateListing:dict=%@", dict);
  [[self kassVS] appendPostingItemToListings:dict];

  [self.presentingViewController dismissModalViewControllerAnimated:YES];
  [[NSNotificationCenter defaultCenter] postNotificationName: NEW_POST_NOTIFICATION 
														object: nil];
}

- (void)accountDidModifyListing:(NSDictionary *)dict
{
  DLog(@"PostSummaryViewController::accountDidModifyListing:dict=%@", dict);
//  [[self kassVS] appendPostingItemToListings:dict];
  
  [self.presentingViewController dismissModalViewControllerAnimated:YES];
  [[NSNotificationCenter defaultCenter] postNotificationName: NEW_POST_NOTIFICATION 
                                                      object: nil];
}


- (IBAction)submitAction {
  DLog(@"PostSummaryViewController::(IBAction)submitAction:postingItem: \n");
  NSString *latlng = [NSString stringWithFormat:@"%+.6f,%+.6f", 
                      VariableStore.sharedInstance.location.coordinate.latitude, 
                      VariableStore.sharedInstance.location.coordinate.longitude]; 
    
  DLog(@"Duration Dic: %@", self.settings.durationToServerDic);
  NSString * durationStr = 
    (NSString *)[self.settings.durationToServerDic objectForKey:(NSNumber *)[VariableStore sharedInstance].currentPostingItem.postDuration];

  if ([durationStr length] <= 0) {
     // TODO
     // Error Message
     DLog(@"Failed to get duration... \nlocal duration=%@", [VariableStore sharedInstance].currentPostingItem.postDuration);
     DLog(@"server duration=%@", durationStr);   
  }
    
  DLog(@"title=%@", [VariableStore sharedInstance].currentPostingItem.title);
  DLog(@"description=%@", [VariableStore sharedInstance].currentPostingItem.description);
  DLog(@"price=%@", [VariableStore sharedInstance].currentPostingItem.askPrice);
  DLog(@"local duration=%@", [VariableStore sharedInstance].currentPostingItem.postDuration);
  DLog(@"server duration=%@", [durationStr class]);    
  DLog(@"latlng=%@", latlng);
  
  NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 [VariableStore sharedInstance].currentPostingItem.title, @"title",
                                 [VariableStore sharedInstance].currentPostingItem.description, @"description",
                                 [VariableStore sharedInstance].currentPostingItem.askPrice, @"price",
                                 durationStr, @"time",
                                 latlng, @"latlng",nil];
  
  if ([self.postType isEqualToString:POST_TYPE_EDITING] && self.postingItem.isPersisted) {
    [self.currentUser modifyListing:params:self.postingItem.dbId];
  }else{
    [self.currentUser createListing:params];
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

@end
