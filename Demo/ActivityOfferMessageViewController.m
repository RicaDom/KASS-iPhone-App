//
//  ActivityOfferMessageViewController.m
//  Demo
//
//  Created by zhicai on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActivityOfferMessageViewController.h"
#import "UIViewController+ActivityIndicate.h"
#import "ViewHelper.h"

@implementation ActivityOfferMessageViewController

@synthesize scrollView = _scrollView;
@synthesize pull = _pull;
@synthesize currentOffer = _currentOffer;
@synthesize listingTitle = _listingTitle;
@synthesize listingDescription = _listingDescription;
@synthesize offerPrice = _offerPrice;
@synthesize listingExpiredDate = _listingExpiredDate;
@synthesize changingPrice = _changingPrice;
@synthesize sendMessageTextField = _sendMessageTextField;
@synthesize mainView = _mainView;
@synthesize buttomView = _buttomView;

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

-(void)stopLoading
{
	[self.pull finishedLoading];
}

// called when the user pulls-to-refresh
- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view
{
  [self performSelector:@selector(loadOffer) withObject:nil afterDelay:2.0];	
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
- (void) accountDidGetOffer:(NSDictionary *)dict{
  DLog(@"ActivityOfferMessageViewController::accountDidGetOffer:dict=%@", dict);
  NSDictionary *offer = [dict objectForKey:@"offer"];
  _currentOffer = [[Offer alloc]initWithDictionary:offer];
  [self loadMessageView];
  [self hideIndicator];
  [self stopLoading];
}

- (void)loadOffer
{
  DLog(@"ActivityOfferMessageViewController::loadingOffer");
  [self showLoadingIndicator];
  VariableStore.sharedInstance.user.delegate = self;
  [VariableStore.sharedInstance.user getOffer:self.currentOffer.dbId];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.listingTitle.text = self.currentOffer.title;
    self.listingDescription.text = self.currentOffer.description;
    self.offerPrice.text = [NSString stringWithFormat:@"%@ 元", [self.currentOffer.price stringValue]]; 
    self.listingExpiredDate.text = @"TODO 7 Days";
    self.changingPrice.text = [self.currentOffer.price stringValue];
    
    self.pull = [[PullToRefreshView alloc] initWithScrollView:self.scrollView];
    [self.pull setDelegate:self];
    [self.scrollView addSubview:self.pull];
    
    [self loadOffer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivePriceChangedNotification:) 
                                                 name:CHANGED_PRICE_NOTIFICATION
                                               object:nil];
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:UI_BUTTON_LABEL_BACK
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(OnClick_btnBack:)];
    self.navigationItem.leftBarButtonItem = btnBack;   
}

- (void) receivePriceChangedNotification:(NSNotification *) notification
{
    // [notification name] should always be CHANGED_PRICE_NOTIFICATION
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:CHANGED_PRICE_NOTIFICATION]) {        
        self.changingPrice.text = (NSString *)[notification object];
        DLog (@"Successfully received price changed notification! %@", (NSString *)[notification object]);
    }
}


- (void)viewDidUnload
{
    [self setListingTitle:nil];
    [self setListingDescription:nil];
    [self setOfferPrice:nil];
    [self setListingExpiredDate:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CHANGED_PRICE_NOTIFICATION object:nil];
    [self setChangingPrice:nil];
    [self setSendMessageTextField:nil];
    [self setMainView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/* Keyboard avoiding start */

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
    
    CGRect rect = self.mainView.frame;

    if (movedUp){
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= _keyboardRect.size.height;
        rect.size.height += _keyboardRect.size.height;
        self.navigationItem.leftBarButtonItem.title = UI_BUTTON_LABEL_CANCEL;
        self.navigationItem.rightBarButtonItem.title = UI_BUTTON_LABEL_SEND;
    }else{
        // revert back to the normal state.
        rect.origin.y += _keyboardRect.size.height;
        rect.size.height -= _keyboardRect.size.height;
        self.navigationItem.leftBarButtonItem.title = UI_BUTTON_LABEL_BACK;
        self.navigationItem.rightBarButtonItem.title = UI_BUTTON_LABEL_MAP;
    }
    self.mainView.frame = rect;
 
    // use the above if else will not work
    if (movedUp) {
        CGRect scrollViewRect = self.scrollView.frame;
        DLog(@"Scoll View move up Before: (%f, %f, %f, %f) ", scrollViewRect.origin.x, scrollViewRect.origin.y, scrollViewRect.size.width, scrollViewRect.size.height );
        scrollViewRect.origin.y = _keyboardRect.size.height;
        scrollViewRect.size.height = rect.size.height - _keyboardRect.size.height*2 - self.buttomView.frame.size.height;
        DLog(@"Scoll View move up After: (%f, %f, %f, %f) ", scrollViewRect.origin.x, scrollViewRect.origin.y, scrollViewRect.size.width, scrollViewRect.size.height );
        self.scrollView.frame = scrollViewRect;
    } else {
        CGRect scrollViewRect = self.scrollView.frame;
        DLog(@"Scoll View move down Before: (%f, %f, %f, %f) ", scrollViewRect.origin.x, scrollViewRect.origin.y, scrollViewRect.size.width, scrollViewRect.size.height );
        scrollViewRect.origin.y = 0;
        scrollViewRect.size.height = rect.size.height - self.buttomView.frame.size.height;
        DLog(@"Scoll View move down After: (%f, %f, %f, %f) ", scrollViewRect.origin.x, scrollViewRect.origin.y, scrollViewRect.size.width, scrollViewRect.size.height );
        self.scrollView.frame = scrollViewRect;        
    }

    [UIView commitAnimations];
//    DLog(@"After: (%f, %f, %f, %f) ", scrollViewRect.origin.x, scrollViewRect.origin.y, scrollViewRect.size.width, scrollViewRect.size.height );
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:_sendMessageTextField])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.mainView.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    //keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
     _keyboardRect = [[[notification userInfo] objectForKey:_UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if ([_sendMessageTextField isFirstResponder] && self.mainView.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
}

/* Keyboard avoiding end */

- (void)viewWillAppear:(BOOL)animated
{
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
        [self.sendMessageTextField resignFirstResponder];
        [self setViewMovedUp:NO];
    }
}

- (IBAction)sellerInfoAction:(id)sender {
}

- (IBAction)confirmDealAction:(id)sender {
    
    // TODO if confirm deal successful, then go to pay page
    //[self performSegueWithIdentifier:@"OfferMessageToPayView" sender:self];
    UINavigationController *navController = self.navigationController;
    [navController dismissModalViewControllerAnimated:NO];
    
    [[NSNotificationCenter defaultCenter] 
     postNotificationName:OFFER_TO_PAY_VIEW_NOTIFICATION 
     object:self.currentOffer];
}

- (IBAction)sendMessageOrMapAction:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:UI_BUTTON_LABEL_MAP]) {
        // TODO get the lat/alt and segue to map
        
        [self performSegueWithIdentifier:@"ActOfferToMapView" sender:self];
    } else if ([sender.title isEqualToString:UI_BUTTON_LABEL_SEND]){
        // TODO submitting message
        
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"changedPriceSegue"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        OfferChangingPriceViewController *ovc = (OfferChangingPriceViewController *)navigationController.topViewController;
        ovc.currentPrice = self.changingPrice.text;
        
    } else if ([segue.identifier isEqualToString:@"ActOfferToMapView"]) {
        
    }
}

@end
