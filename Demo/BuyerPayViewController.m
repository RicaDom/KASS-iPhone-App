//
//  BuyerPayViewController.m
//  Demo
//
//  Created by zhicai on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BuyerPayViewController.h"
#import "UIViewController+ActivityIndicate.h"
#import "UIResponder+VariableStore.h"
#import "UIViewController+SegueActiveModel.h"
#import "UIViewController+ScrollViewRefreshPuller.h"
#import "ViewHelper.h"
#import "Offer+OfferHelper.h"
#import "UIViewController+PriceModifier.h"
#import "UIViewController+KeyboardSlider.h"
#import "UIView+Subviews.h"

@implementation BuyerPayViewController

@synthesize scrollView = _scrollView;
@synthesize currentOffer = _currentOffer;
@synthesize listingTitle = _listingTitle;
@synthesize offerPrice = _offerPrice;
@synthesize listingExpiredDate = _listingExpiredDate;
@synthesize userInfoButton = _userInfoButton;
@synthesize priceButton = _priceButton;
@synthesize bottomView = _bottomView;
@synthesize messageTextField = _messageTextField;
@synthesize descriptionTextField = _descriptionTextField;
@synthesize changedPriceLabel = _changedPriceLabel;
@synthesize changedPriceMessage = _changedPriceMessage;
@synthesize backButton = _backButton;
@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;
@synthesize payButton = _payButton;
@synthesize payStatusLabel = _payStatusLabel;
@synthesize topInfoView = _topInfoView;
@synthesize payView = _payView;
@synthesize mainView = _mainView;

NSString *popUpSuccessfulViewFlag;

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

- (void)hideButtonAndShowStatus:(NSString *)status
{
  self.payButton.hidden = TRUE;
  self.payStatusLabel.text = status;
  self.payStatusLabel.font = [UIFont fontWithName:DEFAULT_FONT size:24];
  self.payStatusLabel.textColor = [UIColor lightGrayColor];
  self.bottomView.hidden = TRUE;
}

- (void)populateData:(NSDictionary *)dict
{
  
  NSDictionary *offer = [dict objectForKey:@"offer"];
  
  if (offer) {
     _currentOffer = [[Offer alloc]initWithDictionary:offer];
  }else{
    _currentOffer = [[Offer alloc]initWithDictionary:dict];
  }
  
  [_scrollView removeViewsWithTag:OFFER_ROW_VIEW_TAG];
  [_currentOffer buildMessagesScrollView:self.scrollView:[self currentUser]];
  [self hideIndicator];
  [self stopLoading];
  
  self.listingTitle.text = self.currentOffer.title;
  self.descriptionTextField.text = self.currentOffer.description;
  self.listingExpiredDate.text = [self.currentOffer getListItemTimeLeftTextlong];
  
  if (self.currentOffer.price) {
    self.offerPrice.text = [self.currentOffer getPriceText];
  }

  [self modifyPriceModifierPrice:self.currentOffer.price];
  [VariableStore.sharedInstance assignItemToShow:_currentOffer];
  VariableStore.sharedInstance.userToShowId = _currentOffer.userId;
  if (_currentOffer.sellerImageUrl.isPresent) {
    [ViewHelper buildRoundCustomImageViewWithFrame:_topInfoView:_currentOffer.sellerImageUrl:CGRectMake(10,5,50,50)];
  }
  
  if ( [self.currentOffer isPaid]) {
    [self hideButtonAndShowStatus:UI_LABEL_OFFER_PAID];
  }else if( self.currentOffer.isPaymentConfirmed ){
    [self hideButtonAndShowStatus:UI_LABEL_OFFER_PAYMENT_CONFIRMED];
  }else {
    self.payButton.hidden = FALSE;
    self.payStatusLabel.text = UI_BUTTON_LABEL_PAY_NOW;
  }
  
}

- (void)accountDidGetOffer:(NSDictionary *)dict
{
  DLog(@"BuyerPayViewController::accountDidGetOffer:dict=%@", dict);  
  NSDictionary *offer = [dict objectForKey:@"offer"];
  [self populateData:offer];
}

- (void)accountDidPayOffer:(NSDictionary *)dict
{
  DLog(@"BuyerPayViewController::accountDidPayOffer:dict=%@", dict);
  NSDictionary *listing = [dict objectForKey:@"listing"];
  NSDictionary *acceptedOffer = [listing objectForKey:@"accepted_offer"];
  [self populateData:acceptedOffer];
}

- (void)accountRequestFailed:(NSDictionary *)errors
{
  DLog(@"BuyerPayViewController::requestFailed");
  [self hideIndicator];
  [self stopLoading];
}

- (void)loadDataSource
{
  DLog(@"BuyerPayViewController::loadingOffer");
  [self showLoadingIndicator];
  
  NSString *offerId = [[self kassGetModelDict:@"offer"] objectForKey:@"id"];
  if ( offerId && ![offerId isBlank]) {
    [[self currentUser] getOffer:offerId];
  } else {
    [ViewHelper showConnectionErrorAlert:self.view];
    self.payStatusLabel.text = ERROR_MSG_CONNECTION_FAILURE;
    self.payButton.hidden = TRUE;
  }
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [super viewDidLoad];
  [self registerPriceModifier];
    
    [ViewHelper buildBackButton:self.leftButton];
    [ViewHelper buildMapButton:self.rightButton];
    [ViewHelper buildUserInfoButton:self.userInfoButton];
  
  [ViewHelper buildBackButton:self.leftButton];
  self.leftButton.tag = LEFT_BAR_BUTTON_BACK;
  [ViewHelper buildMapButton:self.rightButton];
  self.rightButton.tag = RIGHT_BAR_BUTTON_MAP;
  
  // init scroll view content size
  [self.scrollView setContentSize:CGSizeMake(_ScrollViewContentSizeX, self.scrollView.frame.size.height)];
  
  // Bottom view load
  [CommonView setMessageWithPriceView:self.scrollView payImage:_payView bottomView:self.bottomView priceButton:self.priceButton messageField:self.messageTextField price:self.offerPrice.text changedPriceMessage:self.changedPriceMessage];
  
  self.messageTextField.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
  popUpSuccessfulViewFlag = [[self kassGetModelDict:@"offer"] objectForKey:OFFER_STATE_ACCEPTED];

  // register for keyboard view slider
  [self registerScrollViewRefreshPuller:self.scrollView];
  [self registerKeyboardSliderTextView:_descriptionTextField];
  [self registerKeyboardSliderWithConfirmView:_mainView :_scrollView :_bottomView:_payView];
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([popUpSuccessfulViewFlag isEqualToString:OFFER_STATE_ACCEPTED]) {
        popUpSuccessfulViewFlag = nil;
        CustomImageViewPopup *pop = [[CustomImageViewPopup alloc] initWithType:POPUP_IMAGE_ACCEPTED_SUCCESS];
        [self.view addSubview: pop];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
            [pop removeFromSuperview];
        });
    }
}

- (void)viewDidUnload
{
  [self unregisterPriceModifier];
    [self setUserInfoButton:nil];
    [self setPriceButton:nil];
    [self setBottomView:nil];
    [self setMessageTextField:nil];
    [self setDescriptionTextField:nil];
    [self setChangedPriceLabel:nil];
    [self setChangedPriceMessage:nil];
    [self setBackButton:nil];
    [self setLeftButton:nil];
    [self setRightButton:nil];
  [self setPayButton:nil];
  [self setPayStatusLabel:nil];
  [self setTopInfoView:nil];
  [self setPayView:nil];
  [self setMainView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
  [self unregisterScrollViewRefreshPuller];
  [self unregisterKeyboardSlider];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/**
 Scroll View Refresh Puller Delegate
 */
- (void)refreshing{
  [self loadDataSource];
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

- (IBAction)payButtonAction:(id)sender {
  self.payButton.hidden = TRUE;
  [self.currentUser payOffer:_currentOffer.dbId];
  [self hideButtonAndShowStatus:TEXT_IN_PROCESS];
  
//  [[self currentUser] alipayOffer:_currentOffer];
}

/**
 UIViewController+PriceModifier priceModificationDidFinish
 */
- (void)priceModificationDidFinish:(NSInteger)price
{
  DLog (@"BuyerPayViewController::priceModificationDidFinish:%d", price);
  self.offerPrice.text = [NSString stringWithFormat:@"%d", price];
  [CommonView setMessageWithPriceView:self.scrollView payImage:_payView bottomView:self.bottomView priceButton:self.priceButton messageField:self.messageTextField price:self.offerPrice.text changedPriceMessage:self.changedPriceMessage];
}

- (IBAction)rightButtonAction:(id)sender {
    
  if (self.rightButton.tag == RIGHT_BAR_BUTTON_MAP) {
    VariableStore.sharedInstance.itemToShowOnMap = [_currentOffer getListItemToMap];
    [self performSegueWithIdentifier:@"BuyerPayViewToMap" sender:self];
    
  } else if (self.rightButton.tag == RIGHT_BAR_BUTTON_SEND){
    
    DLog(@"BuyerPayViewController::(IBAction)sendMessageOrMapAction:modifyOffer:");
    NSMutableDictionary* params = [Offer getParamsToModify:[self kassVS].priceToModify:_messageTextField.text];
    
    // modify listing
    [self showLoadingIndicator];
    [self.currentUser modifyOffer:params:_currentOffer.dbId];
    [_messageTextField resignFirstResponder];
    [self hideKeyboardAndMoveViewDown];
    
  }    
}

- (void)accountDidModifyOffer:(NSDictionary *)dict
{
  DLog(@"BuyerPayViewController::accountDidModifyOffer");  
  [self populateData:dict];
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
 Overwrite UIViewController+KeyboardSlider shouldKeyboardViewMoveUp
 */
- (BOOL)shouldKeyboardViewMoveUp
{
  return [_messageTextField isFirstResponder] && _mainView.frame.origin.y >= 0;
}

@end
