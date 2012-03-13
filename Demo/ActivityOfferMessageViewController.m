//
//  ActivityOfferMessageViewController.m
//  Demo
//
//  Created by zhicai on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActivityOfferMessageViewController.h"
#import "UIViewController+ActivityIndicate.h"
#import "UIViewController+KeyboardSlider.h"
#import "UIViewController+ScrollViewRefreshPuller.h"
#import "UIViewController+PriceModifier.h"
#import "ViewHelper.h"

@implementation ActivityOfferMessageViewController

@synthesize scrollView    = _scrollView;
@synthesize currentOffer  = _currentOffer;
@synthesize listingTitle  = _listingTitle;
@synthesize offerPrice    = _offerPrice;
@synthesize listingExpiredDate = _listingExpiredDate;
@synthesize changingPrice = _changingPrice;
@synthesize sendMessageTextField = _sendMessageTextField;
@synthesize mainView      = _mainView;
@synthesize buttomView    = _buttomView;
@synthesize userInfoButton  = _userInfoButton;
@synthesize priceButton     = _priceButton;
@synthesize descriptionTextField = _descriptionTextField;
@synthesize confirmDealButton = _confirmDealButton;
@synthesize confirmImageView  = _confirmImageView;
@synthesize changedPriceMessage = _changedPriceMessage;
@synthesize leftButton = _leftButton;
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

-(void)loadMessageView
{
  [ViewHelper buildOfferScrollView:self.scrollView:[self kassVS].user:_currentOffer];
}

- (void) populateData:(NSDictionary *)dict{
  NSDictionary *offer = [dict objectForKey:@"offer"];
  _currentOffer = [[Offer alloc]initWithDictionary:offer];
  
  self.listingTitle.text          = self.currentOffer.title;
  self.descriptionTextField.text  = self.currentOffer.description;
  self.listingExpiredDate.text    = [self.currentOffer getListItemTimeLeftTextlong];
  self.offerPrice.text            = [self.currentOffer getPriceText]; 
  
  [self modifyPriceModifierPrice:self.currentOffer.price];
  [self loadMessageView];
  [self hideIndicator];
  [self stopLoading];
}

- (void) accountDidGetOffer:(NSDictionary *)dict{
  DLog(@"ActivityOfferMessageViewController::accountDidGetOffer:dict=%@", dict);
  [self populateData:dict];
}

- (void)loadDataSource
{
  DLog(@"ActivityOfferMessageViewController::loadDataSource");
  [self showLoadingIndicator];
  [self.currentUser getOffer:self.currentOffer.dbId];
}

-(void) customViewLoad
{
    [ViewHelper buildBackButton:self.leftButton];
    self.leftButton.tag = LEFT_BAR_BUTTON_BACK;
    [ViewHelper buildMapButton:self.rightButton];
    self.rightButton.tag = RIGHT_BAR_BUTTON_MAP;
    
    // init scroll view content size
    [self.scrollView setContentSize:CGSizeMake(_ScrollViewContentSizeX, self.scrollView.frame.size.height)];
    
    // Bottom view load
    [CommonView setMessageWithPriceView:self.scrollView payImage:self.confirmImageView bottomView:self.buttomView priceButton:self.priceButton messageField:self.sendMessageTextField price:self.changingPrice.text changedPriceMessage:self.changedPriceMessage];
    
    // User info button
    [ViewHelper buildUserInfoButton:self.userInfoButton];
    [ViewHelper buildAcceptButton:self.confirmDealButton];
 
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerPriceModifier];
    [self customViewLoad];
}

/**
 UIViewController+PriceModifier priceModificationDidFinish
 */
- (void)priceModificationDidFinish:(NSInteger)price
{
  DLog (@"ActivityOfferMessageViewController::priceModificationDidFinish:%d", price);
  self.changingPrice.text = [NSString stringWithFormat:@"%d", price];
  
  [CommonView setMessageWithPriceView:self.scrollView payImage:self.confirmImageView bottomView:self.buttomView priceButton:self.priceButton messageField:self.sendMessageTextField price:self.changingPrice.text changedPriceMessage:self.changedPriceMessage];
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
    [self setOfferPrice:nil];
    [self setListingExpiredDate:nil];
    [self setChangingPrice:nil];
    [self setSendMessageTextField:nil];
    [self setMainView:nil];
    [self setUserInfoButton:nil];
    [self setPriceButton:nil];
    [self setDescriptionTextField:nil];
    [self setConfirmDealButton:nil];
    [self setConfirmImageView:nil];
    [self setChangedPriceMessage:nil];
    [self setLeftButton:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//-(void)textFieldDidBeginEditing:(UITextField *)sender
//{
//    if ([sender isEqual:_sendMessageTextField])
//    {
//        //move the main view, so that the keyboard does not hide it.
//        if  (self.mainView.frame.origin.y >= 0)
//        {
//            [self showKeyboardAndMoveViewUp];
//        }
//    }
//}

/**
 Overwrite UIViewController+KeyboardSlider shouldKeyboardViewMoveUp
 */
- (BOOL)shouldKeyboardViewMoveUp
{
  return [_sendMessageTextField isFirstResponder] && self.mainView.frame.origin.y >= 0;
}

- (void)viewWillAppear:(BOOL)animated
{
  // register for keyboard view slider
  [self registerScrollViewRefreshPuller:self.scrollView];
  [self registerKeyboardSliderWithConfirmView:_mainView :_scrollView :_buttomView:_confirmImageView];
  [self registerKeyboardSliderTextView:_descriptionTextField];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [self unregisterScrollViewRefreshPuller];
  [self unregisterKeyboardSlider];
}

- (IBAction)sellerInfoAction:(id)sender {
}

- (void)accountDidAcceptOffer:(NSDictionary *)dict
{
  DLog(@"ActivityOfferMessageViewController::accountDidAcceptOffer");  
  
  UINavigationController *navController = self.navigationController;
  [navController dismissModalViewControllerAnimated:NO];
  
  [[NSNotificationCenter defaultCenter] 
   postNotificationName:OFFER_TO_PAY_VIEW_NOTIFICATION 
   object:self.currentOffer];
}

- (IBAction)buttonDraggingAction:(UIPanGestureRecognizer*)recognizer {
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    if (recognizer.state == UIGestureRecognizerStateBegan) {    
        CGPoint touchLocationBegan = [recognizer locationInView:recognizer.view];
        touchBegan = touchLocationBegan.x;
        originX = self.confirmDealButton.frame.origin.x;
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {  
        if (touchLocation.x > touchBegan && self.confirmDealButton.frame.origin.x < (self.view.frame.size.width - self.confirmDealButton.frame.size.width)) {
            int delta = touchLocation.x - touchBegan;
            if ((self.confirmDealButton.frame.origin.x + delta + 10) > (self.view.frame.size.width - self.confirmDealButton.frame.size.width)) {
                self.confirmDealButton.frame = CGRectMake(self.view.frame.size.width - self.confirmDealButton.frame.size.width , self.confirmDealButton.frame.origin.y, self.confirmDealButton.frame.size.width, self.confirmDealButton.frame.size.height);
            } else {
                self.confirmDealButton.frame = CGRectMake(self.confirmDealButton.frame.origin.x + delta + 10 , self.confirmDealButton.frame.origin.y, self.confirmDealButton.frame.size.width, self.confirmDealButton.frame.size.height);
            }
            touchBegan = touchLocation.x;
        }        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {    
        if ((self.confirmDealButton.frame.origin.x + self.confirmDealButton.frame.size.width) >= self.view.frame.size.width && !alreadyConfirmedDeal) {
            DLog(@"Performing deal action...");
            [[self currentUser] acceptOffer:_currentOffer.dbId];
            alreadyConfirmedDeal = YES;
        } else {
            self.confirmDealButton.frame = CGRectMake(originX , self.confirmDealButton.frame.origin.y, self.confirmDealButton.frame.size.width, self.confirmDealButton.frame.size.height);
        }
    }
}

- (void)accountDidModifyOffer:(NSDictionary *)dict
{
  DLog(@"ActivityOfferMessageViewController::accountDidModifyOffer");  
  [self populateData:dict];
}

- (IBAction)leftButtonAction:(id)sender {
    if (self.leftButton.tag == LEFT_BAR_BUTTON_BACK) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.sendMessageTextField resignFirstResponder];
        [self hideKeyboardAndMoveViewDown];
    }
}

- (IBAction)rightButtonAction:(id)sender {
    if (self.rightButton.tag == RIGHT_BAR_BUTTON_MAP) {
      
      VariableStore.sharedInstance.itemToShowOnMap = [_currentOffer getListItemToMap];
      [self performSegueWithIdentifier:@"ActOfferToMapView" sender:self];
      
    } else if (self.rightButton.tag == RIGHT_BAR_BUTTON_SEND){
       
      DLog(@"ActivityOfferMessageViewController::(IBAction)sendMessageOrMapAction:modifyOffer:");
      NSMutableDictionary* params = [Offer getParamsToModify:[self kassVS].priceToModify:self.sendMessageTextField.text];
      
      // modify listing
      [self showLoadingIndicator];
      [self.currentUser modifyOffer:params:_currentOffer.dbId];
      [self.sendMessageTextField resignFirstResponder];
      [self hideKeyboardAndMoveViewDown];
        
    }    
}

@end
