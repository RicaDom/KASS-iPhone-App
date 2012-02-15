//
//  ActivityOfferMessageViewController.m
//  Demo
//
//  Created by zhicai on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActivityOfferMessageViewController.h"

@implementation ActivityOfferMessageViewController

@synthesize scrollView = _scrollView;
@synthesize pull = _pull;
@synthesize currentItem = _currentItem;
@synthesize currentOffer = _currentOffer;
@synthesize listingTitle = _listingTitle;
@synthesize listingDescription = _listingDescription;
@synthesize offerPrice = _offerPrice;
@synthesize listingExpiredDate = _listingExpiredDate;

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
    
    for (int i=0;i<20;i++) {
        yOffset += 5;
        UILabel* lblHeaderTitle = [[UILabel alloc] initWithFrame:CGRectMake(8, yOffset, 310, 21)];
        [lblHeaderTitle setTextAlignment:UITextAlignmentLeft];
        //[lblHeaderTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16.0f]];
        [lblHeaderTitle setBackgroundColor:[UIColor lightGrayColor]];
        
        if (i%2 == 1) {
            [lblHeaderTitle setText:@"买家： 便宜你妹。"];
        } else {
            [lblHeaderTitle setText:@"您： 出价太便宜了。"]; 
        }
        
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


#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.listingTitle.text = self.currentItem.title;
    self.listingDescription.text = self.currentItem.description;
    self.offerPrice.text = self.currentOffer.price;
    self.listingExpiredDate.text = @"TODO 7 Days";
    
    self.pull = [[PullToRefreshView alloc] initWithScrollView:self.scrollView];
    [self.pull setDelegate:self];
    [self.scrollView addSubview:self.pull];
    
    [self loadMessageView];
}


- (void)viewDidUnload
{
    [self setListingTitle:nil];
    [self setListingDescription:nil];
    [self setOfferPrice:nil];
    [self setListingExpiredDate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)stopLoading
{
	[self.pull finishedLoading];
}
// called when the user pulls-to-refresh
- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view
{
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];	
}

- (IBAction)sellerInfoAction:(id)sender {
}
@end
