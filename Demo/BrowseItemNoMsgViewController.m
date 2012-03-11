//
//  BrowseItemNoMsgViewController.m
//  Demo
//
//  Created by zhicai on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrowseItemNoMsgViewController.h"
#import "UIViewController+ActivityIndicate.h"
#import "UIViewController+KeyboardSlider.h"
#import "UIViewController+SegueActiveModel.h"
#import "UIViewController+ScrollViewRefreshPuller.h"

#import "ListingMapAnnotaion.h"
#import "ListingImageAnnotationView.h"

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
@synthesize changedPriceMessage = _changedPriceMessage;
@synthesize mapView = _mapView;

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

- (void)setupMap
{
  CLLocationCoordinate2D userCoordinate;
  userCoordinate.latitude = [_currentItem.location.latitude doubleValue];
  userCoordinate.longitude = [_currentItem.location.longitude doubleValue];
  
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userCoordinate ,MAP_DISTANCE_LAT, MAP_DISTANCE_LNG);
  [self.mapView setRegion:region animated:YES];
  self.mapView.scrollEnabled = YES;
  self.mapView.zoomEnabled = YES;
  
  ListingMapAnnotaion *listingA = [[ListingMapAnnotaion alloc] initWithCoordinate:userCoordinate title:_currentItem.title subTitle:_currentItem.description listingItemData:_currentItem];
  [self.mapView addAnnotation:listingA];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
  DLog(@"BrowseItemNoMsgViewController::viewForAnnotation");
  MKAnnotationView* annotationView = nil;
  ListingImageAnnotationView* imageAnnotationView = (ListingImageAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:nil];
  if(nil == imageAnnotationView)
  {
    imageAnnotationView = [[ListingImageAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];	
    imageAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
  }
  
  annotationView = imageAnnotationView;
	[annotationView setEnabled:YES];
	[annotationView setCanShowCallout:YES];
  return annotationView;
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
  
  [self setupMap];
  
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
  }
  
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // init scroll view content size
    [self.scrollView setContentSize:CGSizeMake(_ScrollViewContentSizeX, self.scrollView.frame.size.height)];
    
  
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:UI_BUTTON_LABEL_BACK
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(OnClick_btnBack:)];
    self.navigationItem.leftBarButtonItem = btnBack;  
    

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivePriceChangedNotification:) 
                                                 name:CHANGED_PRICE_NOTIFICATION
                                               object:nil];

    // navigation bar background color
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:NAVIGATION_BAR_BACKGROUND_COLOR_RED green:NAVIGATION_BAR_BACKGROUND_COLOR_GREEN blue:NAVIGATION_BAR_BACKGROUND_COLOR_BLUE alpha:NAVIGATION_BAR_BACKGROUND_COLOR_ALPHA];
    
    // Bottom view load
    [CommonView setMessageWithPriceView:self.scrollView payImage:nil bottomView:self.buttomView priceButton:self.priceButton messageField:self.messageTextField price:self.offerPrice.text changedPriceMessage:self.changedPriceMessage];
    
    //[CommonView setMessageWithPriceView:self.buttomView priceButton:self.priceButton messageField:self.messageTextField];
    
    // User info button
    UIImage *userButtonImg = [UIImage imageNamed:UI_IMAGE_USER_INFO_BUTTON_GREEN];
    UIImage *userButtonPressImg = [UIImage imageNamed:UI_IMAGE_USER_INFO_BUTTON_DARK];
    self.userInfoButton.frame = CGRectMake(self.userInfoButton.frame.origin.x, self.userInfoButton.frame.origin.y, userButtonImg.size.width, userButtonImg.size.height);
    [self.userInfoButton setImage:userButtonImg forState:UIControlStateNormal];
    [self.userInfoButton setImage:userButtonPressImg forState:UIControlStateSelected];
}

- (void) receivePriceChangedNotification:(NSNotification *) notification
{
    // [notification name] should always be CHANGED_PRICE_NOTIFICATION
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:CHANGED_PRICE_NOTIFICATION]) {
        
        self.offerPrice.text = (NSString *)[notification object];
        DLog (@"BrowseItemNoMsgViewController::receivePriceChangedNotification:%@", (NSString *)[notification object]);
        [CommonView setMessageWithPriceView:self.scrollView payImage:nil bottomView:self.buttomView priceButton:self.priceButton messageField:self.messageTextField price:self.offerPrice.text changedPriceMessage:self.changedPriceMessage];
    }
}

/**
  Keyboard Slider Delegate
 */
- (void) keyboardMainViewMovedDown{
  self.navigationItem.leftBarButtonItem.title = UI_BUTTON_LABEL_BACK;
  self.navigationItem.rightBarButtonItem.title = UI_BUTTON_LABEL_MAP;  
}
- (void) keyboardMainViewMovedUp{
  self.navigationItem.leftBarButtonItem.title = UI_BUTTON_LABEL_CANCEL;
  self.navigationItem.rightBarButtonItem.title = UI_BUTTON_LABEL_SEND; 
}

/**
 Scroll View Refresh Puller Delegate
 */
- (void)refreshing{
  [self loadDataSource];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"changedPriceSegue"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        OfferChangingPriceViewController *ovc = (OfferChangingPriceViewController *)navigationController.topViewController;
        ovc.currentPrice = ([self.offerPrice.text length] > 0) ? self.offerPrice.text : self.listingPrice.text;
    }
}

- (void)viewDidUnload
{
    [self setListingTitle:nil];
    [self setListingPrice:nil];
    [self setListingDate:nil];
    [self setOfferPrice:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CHANGED_PRICE_NOTIFICATION object:nil];
    [self setPriceButton:nil];
    [self setUserInfoButton:nil];
    [self setDescriptionTextView:nil];
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
    if ([self.navigationButton.title isEqualToString:UI_BUTTON_LABEL_SHARE]) {
        // TODO - share on WEIBO
        [self showActionSheet:sender];
        
        
    } else if (self.navigationButton.title == UI_BUTTON_LABEL_SEND) {
      
      // submit listing
      DLog(@"BrowseItemNoMsgViewController::(IBAction)navigationButtonAction:createOffer:");
      NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     ([self.offerPrice.text length] > 0) ? self.offerPrice.text : self.listingPrice.text, @"price",
                                     self.messageTextField.text, @"with_message",
                                     self.currentItem.dbId, @"listing_id",nil];
      
      [self showLoadingIndicator];
      [self.currentUser createOffer:params];
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

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if (sender == self.messageTextField) {
        self.navigationItem.leftBarButtonItem.title = UI_BUTTON_LABEL_CANCEL;
        self.navigationButton.title = UI_BUTTON_LABEL_SEND;
    }
    
    if ([sender isEqual:self.messageTextField])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.mainView.frame.origin.y >= 0)
        {
            [self showKeyboardAndMoveViewUp];
        }
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
  CGRect  keyboardRect = [[[notification userInfo] objectForKey:_UIKeyboardFrameEndUserInfoKey] CGRectValue];
  [self registerKeyboardSliderRect:keyboardRect];
    
    if ([self.messageTextField isFirstResponder] && self.mainView.frame.origin.y >= 0)
    {
        [self showKeyboardAndMoveViewUp];
    }
}

/* Keyboard avoiding end */

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.messageTextField) {
        self.navigationItem.leftBarButtonItem.title = UI_BUTTON_LABEL_BACK;
        self.navigationButton.title = UI_BUTTON_LABEL_SHARE;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
  // register for keyboard view slider
  [self registerScrollViewRefreshPuller:self.scrollView];
  [self registerKeyboardSlider:_mainView :_scrollView :_buttomView];
  [self registerKeyboardSliderTextView:_descriptionTextView];
  
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

-(IBAction)OnClick_btnBack:(id)sender  {
    if ([self.navigationItem.leftBarButtonItem.title isEqualToString:UI_BUTTON_LABEL_BACK]) {
        [self dismissModalViewControllerAnimated:YES];
        //[self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.messageTextField resignFirstResponder];
        [self hideKeyboardAndMoveViewDown];
    }
}

@end
