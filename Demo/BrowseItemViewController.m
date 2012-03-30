//
//  BrowseItemViewController.m
//  Demo
//
//  Created by zhicai on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BrowseItemViewController.h"
#import "VariableStore.h"
#import "ViewHelper.h"
#import "UIView+Subviews.h"
#import "UIViewController+ActivityIndicate.h"
#import "UIViewController+KeyboardSlider.h"
#import "UIViewController+SegueActiveModel.h"
#import "UIViewController+ScrollViewRefreshPuller.h"
#import "UIViewController+PriceModifier.h"
#import "Offer+OfferHelper.h"

@implementation BrowseItemViewController

@synthesize itemTitleLabel = _itemTitleLabel;
@synthesize itemPriceLabel = _itemPriceLabel;
@synthesize itemExpiredDate = _itemExpiredDate;
@synthesize itemPriceChangedToLabel = _itemPriceChangedToLabel;

@synthesize messageTextField = _messageTextField;
@synthesize navigationButton = _navigationButton;
@synthesize scrollView = _scrollView;
@synthesize mainView = _mainView;
@synthesize buttomView = _buttomView;
@synthesize topView = _topView;
@synthesize userInfoButton = _userInfoButton;
@synthesize mapButton = _mapButton;

@synthesize descriptionTextView = _descriptionTextView;
@synthesize changePriceMessage = _changePriceMessage;
@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;
@synthesize topInfoView = _topInfoView;
@synthesize priceButton = _priceButton;
@synthesize currentOffer = _currentOffer;

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

/**
 Scroll View Refresh Puller Delegate
 */
- (void)refreshing{
  [self loadDataSource];
}

- (void)hideInputMessageShowStatus:(NSString *)status
{
  [self.buttomView hideAllSubviews];
  
  UILabel *label = [[UILabel alloc] init];
  [label setText:status];
  [label setTextColor:[UIColor lightGrayColor]];
  label.frame = CGRectMake(0, 0, self.buttomView.frame.size.width, self.buttomView.frame.size.height);
  label.textAlignment = UITextAlignmentCenter;
  label.backgroundColor = [UIColor clearColor];
  label.font = [UIFont fontWithName:DEFAULT_FONT size:24];
  label.tag  = BUTTON_STATUS_TAG;
  
  [self.buttomView addSubview:label]; 
}

- (void)populateData:(NSDictionary *)dict
{
  NSDictionary *offer = [dict objectForKey:@"offer"];
  self.currentOffer = [[Offer alloc]initWithDictionary:offer];
  
  [_currentOffer buildMessagesScrollView:self.scrollView:[self currentUser]];
  [self hideIndicator];
  [self stopLoading];
  
  self.itemTitleLabel.text = self.currentOffer.title;
  self.descriptionTextView.text = self.currentOffer.description;
  self.itemPriceLabel.text = [NSString stringWithFormat:@"%@", self.currentOffer.price];
  
  [self modifyPriceModifierPrice:self.currentOffer.price];
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setAMSymbol:@"AM"];
  [formatter setPMSymbol:@"PM"];
  [formatter setDateFormat:@"MM/dd/yy hh:mm a"];
  // self.itemExpiredDate.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:self.currentOffer.listItemEndedAt]];
  self.itemExpiredDate.text = [self.currentOffer getListItemTimeLeftTextlong];
  
  [VariableStore.sharedInstance assignItemToShow:_currentOffer];
  VariableStore.sharedInstance.userToShowId = _currentOffer.buyerId;
  
  if (_currentOffer.buyerImageUrl.isPresent) {
    [ViewHelper buildRoundCustomImageViewWithFrame:_topInfoView:_currentOffer.buyerImageUrl:CGRectMake(10,5,50,50)];
  }
  
  if ( self.currentOffer.isPaid ) {
    [self.buttomView hideAllSubviews];
    [ViewHelper buildConfirmPaymentButton:self.buttomView:self];
  } else if ( self.currentOffer.isPaymentConfirmed ) {
    [self hideInputMessageShowStatus:UI_LABEL_OFFER_PAYMENT_CONFIRMED];
  } else if ( self.currentOffer.isRejected ) {
    [self hideInputMessageShowStatus:UI_LABEL_REJECTED];
  } else if ( self.currentOffer.isExpired ) {
    [self hideInputMessageShowStatus:UI_LABEL_EXPIRED];
  }
  
}

- (void)confirmPayment
{
  DLog(@"BrowseItemViewController::confirmPayment");
  [self.currentUser confirmPaymentOffer:_currentOffer.dbId];
  [self hideInputMessageShowStatus:TEXT_IN_PROCESS];
}

- (void)loadDataSource
{
  DLog(@"BrowseItemViewController::loadingOffer");
  [self showLoadingIndicator];
  
  //check if currentOffer object is nil, if so get from kassModelDict
  NSString *offerId = [[self kassGetModelDict:@"offer"] objectForKey:@"id"];
  
  if ( offerId && ![offerId isBlank] ) {
    [self.currentUser getOffer:offerId];
  }else {
    [ViewHelper showConnectionErrorAlert:self.view];
    [self hideInputMessageShowStatus:ERROR_MSG_CONNECTION_FAILURE];
  }
}

- (void)priceModificationDidFinish:(NSInteger)price
{
  DLog (@"BrowseItemViewController::priceModificationDidFinish:%d", price);
  self.itemPriceChangedToLabel.text = [NSString stringWithFormat:@"%d", price];
  
  [CommonView setMessageWithPriceView:self.scrollView payImage:nil bottomView:self.buttomView priceButton:self.priceButton messageField:self.messageTextField price:self.itemPriceChangedToLabel.text changedPriceMessage:self.changePriceMessage];
}

- (void)setUILabelTextWithVerticalAlignTop:(NSString *)theText uilabel:(UILabel *)myUILabel{
    // labelSize is hard-wired but could use constants to populate the size
    CGSize labelSize = CGSizeMake(250, 50);
    CGSize theStringSize = [theText sizeWithFont:myUILabel.font constrainedToSize:labelSize lineBreakMode:myUILabel.lineBreakMode];
    myUILabel.frame = CGRectMake(myUILabel.frame.origin.x, myUILabel.frame.origin.y, theStringSize.width, theStringSize.height);
    myUILabel.text = theText;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // init scroll view content size
    [self.scrollView setContentSize:CGSizeMake(_ScrollViewContentSizeX, self.scrollView.frame.size.height)]; 

    [self registerPriceModifier];
    
    // Bottom view load
    [CommonView setMessageWithPriceView:self.scrollView payImage:nil bottomView:self.buttomView priceButton:self.priceButton messageField:self.messageTextField price:self.itemPriceChangedToLabel.text changedPriceMessage:self.changePriceMessage];
    
    // User info button
    [ViewHelper buildUserInfoButton:self.userInfoButton]; 
    [ViewHelper buildMapButton:self.rightButton];
    self.rightButton.tag = RIGHT_BAR_BUTTON_MAP;
    [ViewHelper buildBackButton:self.leftButton];
    self.leftButton.tag = LEFT_BAR_BUTTON_BACK;
    
#pragma marks TODO
    //[self.itemTitleLabel sizeToFit];
    //[self.itemTitleLabel alignTop];
    //[self setUILabelTextWithVerticalAlignTop:self.itemTitleLabel.text uilabel:self.itemTitleLabel];
//    CGSize maximumSize = CGSizeMake(300, 9999);
//    NSString *dateString = self.itemTitleLabel.text;
//    UIFont *dateFont = [UIFont fontWithName:@"Helvetica" size:14];
//    CGSize dateStringSize = [dateString sizeWithFont:dateFont 
//                                   constrainedToSize:maximumSize 
//                                       lineBreakMode:self.itemTitleLabel.lineBreakMode];
//    
//    CGRect dateFrame = CGRectMake(0, 0, self.itemTitleLabel.frame.size.width, dateStringSize.height);
//    
//    self.itemTitleLabel.frame = dateFrame;
}

- (void)viewDidUnload
{
    [self unregisterPriceModifier];
    [self setItemTitleLabel:nil];
    [self setNavigationButton:nil];
    [self setItemPriceLabel:nil];
    [self setItemExpiredDate:nil];
    [self setItemPriceChangedToLabel:nil];
    [self setMainView:nil];
    [self setButtomView:nil];
    [self setTopView:nil];
    [self setPriceButton:nil];
    [self setUserInfoButton:nil];
    [self setDescriptionTextView:nil];
    [self setChangePriceMessage:nil];
    [self setLeftButton:nil];
    [self setRightButton:nil];
  [self setTopInfoView:nil];
    [super viewDidUnload];
    [self setMapButton:nil];
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

/////////////////////////////// Account Activity Delegate ///////////////////////////////
- (void)accountDidGetOffer:(NSDictionary *)dict
{
  DLog(@"BrowseItemViewController::accountDidGetOffer");  
  [self populateData:dict];
}

- (void)accountRequestFailed:(NSDictionary *)errors
{
  DLog(@"BrowseItemViewController::requestFailed");
  [self hideIndicator];
  [self stopLoading];
}

- (void)accountDidModifyOffer:(NSDictionary *)dict
{
  DLog(@"BrowseItemViewController::accountDidModifyOffer");  
  [self populateData:dict];
}

- (void)accountDidConfirmPaymentOffer:(NSDictionary *)dict
{
  DLog(@"BrowseItemViewController::accountDidModifyOffer:dict=%@", dict); 
  [self populateData:dict];
}

- (IBAction)leftButtonAction:(id)sender {
    if (self.leftButton.tag == LEFT_BAR_BUTTON_BACK) {
        [self dismissModalViewControllerAnimated:YES];
    } else {
        [self.messageTextField resignFirstResponder];
        [self hideKeyboardAndMoveViewDown];
    }
}


- (IBAction)rightButtonAction:(id)sender {
    if (self.rightButton.tag == RIGHT_BAR_BUTTON_SEND) {
        
      DLog(@"BrowseItemViewController::(IBAction)rightButtonAction:modifyOffer:");
      NSMutableDictionary* params = [Offer getParamsToModify:[self kassVS].priceToModify:self.messageTextField.text];
      
      // modify listing
      [self showLoadingIndicator];
      [self.currentUser modifyOffer:params:_currentOffer.dbId];
      [self.messageTextField resignFirstResponder];
      [self hideKeyboardAndMoveViewDown];
      
    } else if (self.rightButton.tag == RIGHT_BAR_BUTTON_MAP) {
        
      VariableStore.sharedInstance.itemToShowOnMap = [_currentOffer getListItemToMap];
      [self performSegueWithIdentifier: @"dealMapModal" 
                                  sender: self];
    }
}

/** 
 KeyboardSliderDelegate
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

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:_messageTextField])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.mainView.frame.origin.y >= 0)
        {
            [self showKeyboardAndMoveViewUp];
        }
    }
    if ([sender isEqual:_messageTextField]) {
        [ViewHelper buildCancelButton:self.leftButton];
        self.leftButton.tag = LEFT_BAR_BUTTON_CANCEL;
    }
}

/**
 Overwrite UIViewController+KeyboardSlider shouldKeyboardViewMoveUp
 */
- (BOOL)shouldKeyboardViewMoveUp
{
  return [_messageTextField isFirstResponder] && self.mainView.frame.origin.y >= 0;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.messageTextField) {
        self.navigationItem.leftBarButtonItem.title = UI_BUTTON_LABEL_BACK;
        self.navigationButton.title = UI_BUTTON_LABEL_MAP;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [self registerKeyboardSlider:_mainView :_scrollView :_buttomView];
  [self registerKeyboardSliderTextView:_descriptionTextView];
  [self registerScrollViewRefreshPuller:self.scrollView];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [self unregisterScrollViewRefreshPuller];
  [self unregisterKeyboardSlider];
}

@end
