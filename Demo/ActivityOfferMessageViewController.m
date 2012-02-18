//
//  ActivityOfferMessageViewController.m
//  Demo
//
//  Created by zhicai on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActivityOfferMessageViewController.h"
#import "UIViewController+ActivityIndicate.h"

@implementation ActivityOfferMessageViewController

@synthesize scrollView = _scrollView;
@synthesize pull = _pull;
@synthesize currentOffer = _currentOffer;
@synthesize listingTitle = _listingTitle;
@synthesize listingDescription = _listingDescription;
@synthesize offerPrice = _offerPrice;
@synthesize listingExpiredDate = _listingExpiredDate;
@synthesize changingPrice = _changingPrice;

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
    CGFloat yOffset = 155;
    
    UIImage *line = [UIImage imageNamed:@"line.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:line];
    imageView.frame = CGRectMake(3, yOffset + 10, imageView.frame.size.width, imageView.frame.size.height);
    [self.scrollView addSubview:imageView];
    yOffset += 10;
    
    for (int i=0; i< [_currentOffer.messages count]; i++) {
      yOffset += 5;
      UILabel* lblHeaderTitle = [[UILabel alloc] initWithFrame:CGRectMake(8, yOffset, 310, 21)];
      [lblHeaderTitle setTextAlignment:UITextAlignmentLeft];
      //[lblHeaderTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16.0f]];
      [lblHeaderTitle setBackgroundColor:[UIColor lightGrayColor]];
      
      Message *message = [_currentOffer.messages objectAtIndex:i];
      
      NSString *title;
      
      if (VariableStore.sharedInstance.user.userId == message.dbId) {
        title = @"您";
      }else if(_currentOffer.buyerId == message.dbId) {
        title = @"买家";
      }else{
        title = @"卖家";
      }
      
      [lblHeaderTitle setText:[NSString stringWithFormat:@"%@ %@", title, message.body]];
      
      [lblHeaderTitle setTextColor:[UIColor blackColor]];
      
      [self.scrollView addSubview:lblHeaderTitle];
      
      UIImage *line = [UIImage imageNamed:@"line.png"];
      UIImageView *imageView = [[UIImageView alloc] initWithImage:line];
      imageView.frame = CGRectMake(3, yOffset + 25, imageView.frame.size.width, imageView.frame.size.height);
      [self.scrollView addSubview:imageView];
      
      //INCREMNET in yOffset 
      yOffset += 30;
      
      [self.scrollView setContentSize:CGSizeMake(320, yOffset)];    
    }
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)sellerInfoAction:(id)sender {
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"changedPriceSegue"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        OfferChangingPriceViewController *ovc = (OfferChangingPriceViewController *)navigationController.topViewController;
        ovc.currentPrice = self.changingPrice.text;
    }
}
@end
