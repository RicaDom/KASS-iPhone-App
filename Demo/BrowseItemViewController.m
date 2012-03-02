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

@implementation BrowseItemViewController

@synthesize itemTitleLabel = _itemTitleLabel;
@synthesize itemDescriptionLabel = _itemDescriptionLabel;
@synthesize itemPriceLabel = _itemPriceLabel;
@synthesize itemExpiredDate = _itemExpiredDate;
@synthesize itemPriceChangedToLabel = _itemPriceChangedToLabel;
@synthesize currentItem = _currentItem;
@synthesize messageTextField = _messageTextField;
@synthesize navigationButton = _navigationButton;
@synthesize scrollView = _scrollView;
@synthesize pull = _pull;
@synthesize mainView = _mainView;
@synthesize buttomView = _buttomView;
@synthesize topView = _topView;
@synthesize tpScrollView = _tpScrollView;
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


-(void)stopLoading
{
	[self.pull finishedLoading];
}

// called when the user pulls-to-refresh
- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view
{
  [self performSelector:@selector(loadOffer) withObject:nil afterDelay:2.0];	
}

- (void)populateData:(NSDictionary *)dict
{
  NSDictionary *offer = [dict objectForKey:@"offer"];
  self.currentOffer = [[Offer alloc]initWithDictionary:offer];
  
  [ViewHelper buildOfferScrollView:self.scrollView:[self currentUser]:_currentOffer];
  [self hideIndicator];
  [self stopLoading];
  
  if (self.currentItem != nil) {
    self.itemTitleLabel.text = self.currentItem.title;
    self.itemDescriptionLabel.text = self.currentItem.description;
    self.itemPriceLabel.text = [NSString stringWithFormat:@"%@", self.currentItem.askPrice];
    self.itemPriceChangedToLabel.text = [NSString stringWithFormat:@"%@", self.currentItem.askPrice];
    self.itemExpiredDate.text = [self.currentItem getTimeLeftTextlong];   
    
  } else if (self.currentOffer != nil) {
    self.itemTitleLabel.text = self.currentOffer.title;
    self.itemDescriptionLabel.text = self.currentOffer.description;
    self.itemPriceLabel.text = [NSString stringWithFormat:@"%@", self.currentOffer.price];
    self.itemPriceChangedToLabel.text = [NSString stringWithFormat:@"%@", self.currentOffer.price];
  }
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

- (void)loadOffer
{
  DLog(@"BrowseItemViewController::loadingOffer");
  [self showLoadingIndicator];
  
  //check if currentOffer object is nil, if so get from kassModelDict
  NSString *offerId = self.currentOffer.dbId;
  
  if ( !offerId || [offerId isBlank] ) {
    offerId = [[self kassGetModelDict:@"offer"] objectForKey:@"id"];
  }

  VariableStore.sharedInstance.user.delegate = self;
  [VariableStore.sharedInstance.user getOffer:offerId];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pull = [[PullToRefreshView alloc] initWithScrollView:self.scrollView];
    [self.pull setDelegate:self];
    [self.scrollView addSubview:self.pull];
    [self loadOffer];
    
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
}

- (void) receivePriceChangedNotification:(NSNotification *) notification
{
    // [notification name] should always be CHANGED_PRICE_NOTIFICATION
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:CHANGED_PRICE_NOTIFICATION]) {
        
        self.itemPriceChangedToLabel.text = (NSString *)[notification object];
        DLog (@"Successfully received price changed notification! %@", (NSString *)[notification object]);
    }
}

- (void)viewDidUnload
{
    [self setItemTitleLabel:nil];
    [self setItemDescriptionLabel:nil];
    [self setNavigationButton:nil];
    [self setItemPriceLabel:nil];
    [self setItemExpiredDate:nil];
    [self setItemPriceChangedToLabel:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CHANGED_PRICE_NOTIFICATION object:nil];
    [self setMainView:nil];
    [self setButtomView:nil];
    [self setTopView:nil];
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

- (void)accountDidModifyOffer:(NSDictionary *)dict
{
  DLog(@"BrowseItemViewController::accountDidModifyOffer");  
  [self populateData:dict];
}

- (IBAction)navigationButtonAction:(id)sender {
    if ([self.navigationButton.title isEqualToString:UI_BUTTON_LABEL_MAP]) {
        [self performSegueWithIdentifier: @"dealMapModal" 
                                  sender: self];
    } else if (self.navigationButton.title == UI_BUTTON_LABEL_SEND) {
      
      DLog(@"BrowseItemViewController::(IBAction)navigationButtonAction:modifyOffer:");
      NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     self.itemPriceLabel.text, @"price",
                                     self.messageTextField.text, @"message",nil];
      
      // modify listing
      [self showLoadingIndicator];
      VariableStore.sharedInstance.user.delegate = self;
      [VariableStore.sharedInstance.user modifyOffer:params:_currentOffer.dbId];
      [self.messageTextField resignFirstResponder];
      [self hideKeyboardAndMoveViewDown];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"changedPriceSegue"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        OfferChangingPriceViewController *ovc = (OfferChangingPriceViewController *)navigationController.topViewController;
        ovc.currentPrice = self.itemPriceLabel.text;
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
        self.navigationItem.leftBarButtonItem.title = UI_BUTTON_LABEL_CANCEL;
        //self.navigationController.navigationBar.backItem.title = @"取消";
        //self.navigationItem.leftBarButtonItem.tintColor = [UIColor redColor];
        self.navigationButton.title = UI_BUTTON_LABEL_SUBMIT;
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
    _keyboardRect = [[[notification userInfo] objectForKey:_UIKeyboardFrameEndUserInfoKey] CGRectValue];
  [self registerKeyboardRect:_keyboardRect];
    
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
  [self registerKeyboardSlider:_mainView :_scrollView :_buttomView];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) 
                                                 name:UIKeyboardWillShowNotification object:self.view.window]; 
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 
}


-(IBAction)OnClick_btnBack:(id)sender  {
    if ([self.navigationItem.leftBarButtonItem.title isEqualToString:UI_BUTTON_LABEL_BACK]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.messageTextField resignFirstResponder];
        [self hideKeyboardAndMoveViewDown];
    }
}

@end
