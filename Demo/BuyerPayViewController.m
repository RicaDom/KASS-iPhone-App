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
#import "ViewHelper.h"

@implementation BuyerPayViewController

@synthesize scrollView = _scrollView;
@synthesize pull = _pull;
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

- (void)populateData:(NSDictionary *)dict
{
  NSDictionary *offer = [dict objectForKey:@"offer"];
  self.currentOffer = [[Offer alloc]initWithDictionary:offer];
  
  [ViewHelper buildOfferScrollView:self.scrollView:[self currentUser]:_currentOffer];
  [self hideIndicator];
  [self stopLoading];
  
  self.listingTitle.text = self.currentOffer.title;
  self.descriptionTextField.text = self.currentOffer.description;
  
  if (self.currentOffer.price) {
    self.offerPrice.text = [self.currentOffer.price stringValue];
  }
}

- (void)accountDidGetOffer:(NSDictionary *)dict
{
  DLog(@"BuyerPayViewController::accountDidGetOffer");  
  [self populateData:dict];
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
  }
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // navigation bar background color
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:NAVIGATION_BAR_BACKGROUND_COLOR_RED green:NAVIGATION_BAR_BACKGROUND_COLOR_GREEN blue:NAVIGATION_BAR_BACKGROUND_COLOR_BLUE alpha:NAVIGATION_BAR_BACKGROUND_COLOR_ALPHA];
    
    self.pull = [[PullToRefreshView alloc] initWithScrollView:self.scrollView];
    [self.pull setDelegate:self];
    [self.scrollView addSubview:self.pull];
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:UI_BUTTON_LABEL_BACK
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(OnClick_btnBack:)];
    self.navigationItem.leftBarButtonItem = btnBack; 
    
    // Bottom view load
    //[CommonView setMessageWithPriceView:self.bottomView priceButton:self.priceButton messageField:self.messageTextField ];
    [ViewHelper buildBackButton:self.backButton];
}

-(IBAction)OnClick_btnBack:(id)sender  {
    if ([self.navigationItem.leftBarButtonItem.title isEqualToString:UI_BUTTON_LABEL_BACK]) {
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (void)viewDidUnload
{
    [self setUserInfoButton:nil];
    [self setUserInfoButton:nil];
    [self setPriceButton:nil];
    [self setBottomView:nil];
    [self setMessageTextField:nil];
    [self setDescriptionTextField:nil];
    [self setChangedPriceLabel:nil];
    [self setChangedPriceMessage:nil];
    [self setBackButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// called when the user pulls-to-refresh
- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view
{
    [self performSelector:@selector(loadDataSource) withObject:nil afterDelay:2.0];	
}
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
