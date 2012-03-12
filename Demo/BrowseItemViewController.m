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
#import "UIViewController+ActivityIndicate.h"
#import "UIViewController+KeyboardSlider.h"
#import "UIViewController+SegueActiveModel.h"
#import "UIViewController+ScrollViewRefreshPuller.h"

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

- (void)populateData:(NSDictionary *)dict
{
  NSDictionary *offer = [dict objectForKey:@"offer"];
  self.currentOffer = [[Offer alloc]initWithDictionary:offer];
  
  [ViewHelper buildOfferScrollView:self.scrollView:[self currentUser]:_currentOffer];
  [self hideIndicator];
  [self stopLoading];
  
  self.itemTitleLabel.text = self.currentOffer.title;
  self.descriptionTextView.text = self.currentOffer.description;
  self.itemPriceLabel.text = [NSString stringWithFormat:@"%@", self.currentOffer.price];
  //self.itemPriceChangedToLabel.text = [NSString stringWithFormat:@"%@", self.currentOffer.price];
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setAMSymbol:@"AM"];
  [formatter setPMSymbol:@"PM"];
  [formatter setDateFormat:@"MM/dd/yy hh:mm a"];
  self.itemExpiredDate.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:self.currentOffer.listItemEndedAt]];
  
}

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

- (void)loadDataSource
{
  DLog(@"BrowseItemViewController::loadingOffer");
  [self showLoadingIndicator];
  
  //check if currentOffer object is nil, if so get from kassModelDict
  NSString *offerId = [[self kassGetModelDict:@"offer"] objectForKey:@"id"];
  
  if ( offerId && ![offerId isBlank] ) {
    [self.currentUser getOffer:offerId];
  }
}

- (void) receivePriceChangedNotification:(NSNotification *) notification
{
    // [notification name] should always be CHANGED_PRICE_NOTIFICATION
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:CHANGED_PRICE_NOTIFICATION]) {
        
        self.itemPriceChangedToLabel.text = (NSString *)[notification object];
        DLog (@"BrowseItemViewController::receivePriceChangedNotification:%@", (NSString *)[notification object]);
        DLog(@"Price changed to: %@", self.itemPriceChangedToLabel.text);
        [CommonView setMessageWithPriceView:self.scrollView payImage:nil bottomView:self.buttomView priceButton:self.priceButton messageField:self.messageTextField price:self.itemPriceChangedToLabel.text changedPriceMessage:self.changePriceMessage];
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // navigation bar background color
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:NAVIGATION_BAR_BACKGROUND_COLOR_RED green:NAVIGATION_BAR_BACKGROUND_COLOR_GREEN blue:NAVIGATION_BAR_BACKGROUND_COLOR_BLUE alpha:NAVIGATION_BAR_BACKGROUND_COLOR_ALPHA];
    
    // init scroll view content size
    [self.scrollView setContentSize:CGSizeMake(_ScrollViewContentSizeX, self.scrollView.frame.size.height)];
 
//    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
//                                initWithTitle:UI_BUTTON_LABEL_BACK
//                                style:UIBarButtonItemStyleBordered
//                                target:self
//                                action:@selector(OnClick_btnBack:)];
//    self.navigationItem.leftBarButtonItem = btnBack;   

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivePriceChangedNotification:) 
                                                 name:CHANGED_PRICE_NOTIFICATION
                                               object:nil];
    
    // Bottom view load
    [CommonView setMessageWithPriceView:self.scrollView payImage:nil bottomView:self.buttomView priceButton:self.priceButton messageField:self.messageTextField price:self.itemPriceChangedToLabel.text changedPriceMessage:self.changePriceMessage];
    
    // User info button
  [ViewHelper buildUserInfoButton:self.userInfoButton]; 
  [ViewHelper buildMapButton:self.mapButton];
  [ViewHelper buildBackButton:self.leftButton];
   self.leftButton.tag = LEFT_BAR_BUTTON_BACK;
}

- (void)viewDidUnload
{
    [self setItemTitleLabel:nil];
    [self setNavigationButton:nil];
    [self setItemPriceLabel:nil];
    [self setItemExpiredDate:nil];
    [self setItemPriceChangedToLabel:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CHANGED_PRICE_NOTIFICATION object:nil];
    [self setMainView:nil];
    [self setButtomView:nil];
    [self setTopView:nil];
    [self setPriceButton:nil];
    [self setUserInfoButton:nil];
    [self setDescriptionTextView:nil];
    [self setChangePriceMessage:nil];
    [self setLeftButton:nil];
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

- (void)accountDidModifyOffer:(NSDictionary *)dict
{
  DLog(@"BrowseItemViewController::accountDidModifyOffer");  
  [self populateData:dict];
}

- (IBAction)mapButtonAction:(id)sender
{
  NSDictionary *listing = [[NSDictionary alloc] initWithObjectsAndKeys:
                           _currentOffer.title, @"title", _currentOffer.description, @"description", 
                           _currentOffer.listingId, @"id", nil ];
  
  ListItem *listItem = [[ListItem alloc] initWithDictionary:listing];
  listItem.location = _currentOffer.listItemLocation;
  
  VariableStore.sharedInstance.showOnMapListings = [[NSMutableArray alloc] initWithObjects:listItem, nil];
  
  [self performSegueWithIdentifier: @"dealMapModal" 
                            sender: self];
}

- (IBAction)leftButtonAction:(id)sender {
    if (self.leftButton.tag == LEFT_BAR_BUTTON_BACK) {
        [self dismissModalViewControllerAnimated:YES];
        //[self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.messageTextField resignFirstResponder];
        [self hideKeyboardAndMoveViewDown];
    }
}

- (IBAction)navigationButtonAction:(id)sender {
    if (self.navigationButton.title == UI_BUTTON_LABEL_SEND) {
      
      DLog(@"BrowseItemViewController::(IBAction)navigationButtonAction:modifyOffer:");
      NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     ([self.itemPriceChangedToLabel.text length] > 0) ? self.itemPriceChangedToLabel.text : self.itemPriceLabel.text, @"price",
                                     self.messageTextField.text, @"message",nil];
      
      // modify listing
      [self showLoadingIndicator];
      [self.currentUser modifyOffer:params:_currentOffer.dbId];
      [self.messageTextField resignFirstResponder];
      [self hideKeyboardAndMoveViewDown];
    }
}

/** 
 KeyboardSliderDelegate
 */
- (void) keyboardMainViewMovedDown{
    [ViewHelper buildBackButton:self.leftButton];
    self.leftButton.tag = LEFT_BAR_BUTTON_BACK;
    //self.navigationItem.leftBarButtonItem.title = UI_BUTTON_LABEL_BACK;
    self.navigationItem.rightBarButtonItem.title = UI_BUTTON_LABEL_MAP;  
}
- (void) keyboardMainViewMovedUp{
    [ViewHelper buildCancelButton:self.leftButton];
    self.leftButton.tag = LEFT_BAR_BUTTON_CANCEL;
    //self.navigationItem.leftBarButtonItem.title = UI_BUTTON_LABEL_CANCEL;
    self.navigationItem.rightBarButtonItem.title = UI_BUTTON_LABEL_SEND; 
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"changedPriceSegue"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        OfferChangingPriceViewController *ovc = (OfferChangingPriceViewController *)navigationController.topViewController;
        ovc.currentPrice = [self.itemPriceChangedToLabel.text length] > 0 ? self.itemPriceChangedToLabel.text : self.itemPriceLabel.text;
    }
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
        //self.navigationItem.leftBarButtonItem.title = UI_BUTTON_LABEL_CANCEL;
        //self.navigationController.navigationBar.backItem.title = @"取消";
        //self.navigationItem.leftBarButtonItem.tintColor = [UIColor redColor];
        self.navigationButton.title = UI_BUTTON_LABEL_SUBMIT;
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
  CGRect keyboardRect = [[[notification userInfo] objectForKey:_UIKeyboardFrameEndUserInfoKey] CGRectValue];
  [self registerKeyboardSliderRect:keyboardRect];
    
    if ([_messageTextField isFirstResponder] && self.mainView.frame.origin.y >= 0)
    {
        [self showKeyboardAndMoveViewUp];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.messageTextField) {
        self.navigationItem.leftBarButtonItem.title = UI_BUTTON_LABEL_BACK;
        //self.navigationController.navigationBar.backItem.title = @"上一步";
        self.navigationButton.title = UI_BUTTON_LABEL_MAP;
    }
}

/* Keyboard avoiding end */

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [self registerKeyboardSlider:_mainView :_scrollView :_buttomView];
  [self registerKeyboardSliderTextView:_descriptionTextView];
  [self registerScrollViewRefreshPuller:self.scrollView];
    
  
  
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) 
                                                 name:UIKeyboardWillShowNotification object:self.view.window]; 
}

- (void)viewWillDisappear:(BOOL)animated
{
  [self unregisterScrollViewRefreshPuller];
  [self unregisterKeyboardSlider];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 
}


//-(IBAction)OnClick_btnBack:(id)sender  {
//    if ([self.navigationItem.leftBarButtonItem.title isEqualToString:UI_BUTTON_LABEL_BACK]) {
//        [self dismissModalViewControllerAnimated:YES];
//        //[self.navigationController popViewControllerAnimated:YES];
//    } else {
//        [self.messageTextField resignFirstResponder];
//        [self hideKeyboardAndMoveViewDown];
//    }
//}

@end
