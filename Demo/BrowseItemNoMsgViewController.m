//
//  BrowseItemNoMsgViewController.m
//  Demo
//
//  Created by zhicai on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrowseItemNoMsgViewController.h"
#import "UIViewController+KeyboardSlider.h"
#import "UIViewController+SegueActiveModel.h"
#import "UIViewController+ScrollViewRefreshPuller.h"
#import "UIViewController+PriceModifier.h"
#import "UIViewController+ActivityIndicate.h"
#import "UIView+Subviews.h"

#import "ListingMapAnnotaion.h"
#import "ListingImageAnnotationView.h"
#import "ListItem+ListItemHelper.h"

@implementation BrowseItemNoMsgViewController

@synthesize messageTextField = _messageTextField;
@synthesize descriptionTextView = _descriptionTextView;
@synthesize currentItem = _currentItem;
@synthesize navigationButton = _navigationButton;
@synthesize listingTitle = _listingTitle;
@synthesize listingPrice = _listingPrice;
@synthesize listingDate = _listingDate;
@synthesize offerPrice = _offerPrice;
@synthesize mainView = _mainView;
@synthesize buttomView = _buttomView;
@synthesize scrollView = _scrollView;
@synthesize priceButton = _priceButton;
@synthesize userInfoButton = _userInfoButton;
@synthesize leftButton = _leftButton;
@synthesize changedPriceMessage = _changedPriceMessage;
@synthesize mapView = _mapView;
@synthesize rightButton = _rightButton;

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

- (void)hideInputMessageShowStatus:(NSString *)status
{
  [self.buttomView hideAllSubviews];
  
  UILabel *label = [[UILabel alloc] init];
  [label setText:status];
  [label setTextColor:[UIColor brownColor]];
  label.frame = CGRectMake(0, 0, self.buttomView.frame.size.width, self.buttomView.frame.size.height);
  label.textAlignment = UITextAlignmentCenter;
  label.backgroundColor = [UIColor clearColor];
  label.font = [UIFont boldSystemFontOfSize:24];
  [self.buttomView addSubview:label]; 
}

/////////////////////////////////////////////////////////////////////////////////////////

- (void) appDidGetListing:(NSDictionary *)dict
{
  DLog(@"BrowseItemNoMsgViewController::appDidGetListing:listing=%@", dict);
  self.currentItem = [[ListItem alloc] initWithDictionary:dict];
  
  self.listingTitle.text = self.currentItem.title;
  self.descriptionTextView.text = self.currentItem.description;
  self.listingPrice.text = [NSString stringWithFormat:@"%@", self.currentItem.askPrice];
  //self.offerPrice.text = [NSString stringWithFormat:@"%@", self.currentItem.askPrice];
  self.listingDate.text = [self.currentItem getTimeLeftTextlong];       
  
  [self.currentItem buildMap:self.mapView];
  
  [self modifyPriceModifierPrice:self.currentItem.price];
  
  VariableStore.sharedInstance.userToShowId = _currentItem.userId;
  
  [self hideIndicator];
  [self stopLoading];
}

- (void)loadDataSource
{
  DLog(@"BrowseItemNoMsgViewController::loadDataSource");
  [self showLoadingIndicator];
  
  NSString *listItemId = [[self kassGetModelDict:@"listItem"] objectForKey:@"id"];
  
  if ( listItemId && ![listItemId isBlank] ) {
    [self.kassApp getListing:listItemId];
  }else {
    [ViewHelper showErrorAlert:ERROR_MSG_CONNECTION_FAILURE:self];
    [self hideInputMessageShowStatus:ERROR_MSG_CONNECTION_FAILURE];
  }
  
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // init scroll view content size
    [self.scrollView setContentSize:CGSizeMake(_ScrollViewContentSizeX, self.scrollView.frame.size.height)];
    
    [self registerPriceModifier];
    
    // Bottom view load
    [CommonView setMessageWithPriceView:self.scrollView payImage:nil bottomView:self.buttomView priceButton:self.priceButton messageField:self.messageTextField price:self.offerPrice.text changedPriceMessage:self.changedPriceMessage];
  
    [ViewHelper buildUserInfoButton:self.userInfoButton];
    [ViewHelper buildShareButton:self.rightButton];
    self.rightButton.tag = RIGHT_BAR_BUTTON_SHARE;
    [ViewHelper buildBackButton:self.leftButton];
    self.leftButton.tag = LEFT_BAR_BUTTON_BACK;
  
    self.messageTextField.delegate = self;
}

/**
 UIViewController+PriceModifier priceModificationDidFinish
 */
- (void)priceModificationDidFinish:(NSInteger)price
{
  DLog (@"BrowseItemNoMsgViewController::priceModificationDidFinish:%d", price);
  self.offerPrice.text = [NSString stringWithFormat:@"%d", price];
  [CommonView setMessageWithPriceView:self.scrollView payImage:nil bottomView:self.buttomView priceButton:self.priceButton messageField:self.messageTextField price:self.offerPrice.text changedPriceMessage:self.changedPriceMessage];
}

/**
  Keyboard Slider Delegate
 */
- (void) keyboardMainViewMovedDown{
  [ViewHelper buildBackButton:self.leftButton];
  self.leftButton.tag = LEFT_BAR_BUTTON_BACK;
  [ViewHelper buildMapButton:self.rightButton];
  self.rightButton.tag = RIGHT_BAR_BUTTON_MAP;
}

- (void) keyboardMainViewMovedUp{
  [ViewHelper buildCancelButton:self.leftButton];
  self.leftButton.tag = LEFT_BAR_BUTTON_CANCEL;
  [ViewHelper buildSendButton:self.rightButton];
  self.rightButton.tag = RIGHT_BAR_BUTTON_SEND;
}

/**
 Scroll View Refresh Puller Delegate
 */
- (void)refreshing{
  [self loadDataSource];
}

- (void)viewDidUnload
{
    [self unregisterPriceModifier];
    [self setListingTitle:nil];
    [self setListingPrice:nil];
    [self setListingDate:nil];
    [self setOfferPrice:nil];
    [self setPriceButton:nil];
    [self setUserInfoButton:nil];
    [self setDescriptionTextView:nil];
    [self setLeftButton:nil];
    [self setRightButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(IBAction)showActionSheet:(id)sender {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:UI_BUTTON_LABEL_SHARE_WITH_FRIEND delegate:self cancelButtonTitle:UI_BUTTON_LABEL_CANCEL destructiveButtonTitle:nil otherButtonTitles:UI_BUTTON_LABEL_WEIBO_SHARE, UI_BUTTON_LABEL_SEND_MESSAGE, UI_BUTTON_LABEL_SEND_EMAIL, nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:self.view];
}

- (void)accountDidCreateOffer:(NSDictionary *)dict
{
    DLog(@"BrowseItemNoMsgViewController::accountDidCreateOffer:dict=%@", dict);
    [self hideIndicator];
    [self stopLoading];
    UINavigationController *navController = self.navigationController;
    // Pop this controller and replace with another
    [navController dismissModalViewControllerAnimated:YES];

    [[NSNotificationCenter defaultCenter] postNotificationName:NO_MESSAGE_TO_MESSAGE_VIEW_NOTIFICATION object:dict];
    //  [navController popViewControllerAnimated:NO];
    //  [(BrowseTableViewController *)[navController.viewControllers objectAtIndex:([navController.viewControllers count]-1)] switchBrowseItemView];
  
}

- (IBAction)navigationButtonAction:(id)sender {
    if (self.rightButton.tag == RIGHT_BAR_BUTTON_SHARE) {
        
        [self showActionSheet:sender];
        
    } else if (self.rightButton.tag == RIGHT_BAR_BUTTON_SEND) {
      
      // submit listing
      DLog(@"BrowseItemNoMsgViewController::(IBAction)navigationButtonAction:createOffer:");
      NSMutableDictionary* params = [Offer getParamsToCreate:[self kassVS].priceToModify:self.messageTextField.text:self.currentItem];
      
      [self showLoadingIndicator];
      [self.currentUser createOffer:params];
      [self.messageTextField resignFirstResponder];
      [self hideKeyboardAndMoveViewDown];
      
    }
}

- (IBAction)leftButtonAction:(id)sender {
    if ( self.leftButton.tag == LEFT_BAR_BUTTON_BACK ) {
        [self dismissModalViewControllerAnimated:YES];
        //[self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.messageTextField resignFirstResponder];
        [self hideKeyboardAndMoveViewDown];
    }
}

- (void) accountWeiboShareFinished
{
  DLog(@"BrowseItemNoMsgViewController::accountWeiboShareFinished");
  
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
       
      //share weibo
      [[self currentUser] weiboShare:_currentItem];
      
    } else if (buttonIndex == 1) {
        //self.label.text = @"Other Button 1 Clicked";
    } else if (buttonIndex == 2) {
        //self.label.text = @"Other Button 2 Clicked";
    } else if (buttonIndex == 3) {
        //self.label.text = @"Cancel Button Clicked";
    }
}

/**
 Overwrite UIViewController+KeyboardSlider shouldKeyboardViewMoveUp
 */
- (BOOL)shouldKeyboardViewMoveUp
{
  return [self.messageTextField isFirstResponder] && self.mainView.frame.origin.y >= 0;
}

/**
 TextFieldDelegate
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    if (textField == self.messageTextField) {
//        self.navigationItem.leftBarButtonItem.title = UI_BUTTON_LABEL_BACK;
//        self.navigationButton.title = UI_BUTTON_LABEL_SHARE;
//    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
//  if (sender == self.messageTextField) {
//    self.navigationItem.leftBarButtonItem.title = UI_BUTTON_LABEL_CANCEL;
//    self.navigationButton.title = UI_BUTTON_LABEL_SEND;
//  }
}

- (void)viewWillAppear:(BOOL)animated
{
  // register for keyboard view slider
  [self registerScrollViewRefreshPuller:self.scrollView];
  [self registerKeyboardSlider:_mainView :_scrollView :_buttomView];
  [self registerKeyboardSliderTextView:_descriptionTextView];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [self unregisterScrollViewRefreshPuller];
  [self unregisterKeyboardSlider];
}


@end
