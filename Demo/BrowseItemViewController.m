//
//  BrowseItemViewController.m
//  Demo
//
//  Created by zhicai on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BrowseItemViewController.h"

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
@synthesize tpScrollView = _tpScrollView;

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

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pull = [[PullToRefreshView alloc] initWithScrollView:self.scrollView];
    [self.pull setDelegate:self];
    [self.scrollView addSubview:self.pull];
    [self loadMessageView];
    
//    self.scrollView.scrollEnabled = NO;
//    self.scrollView.scrollEnabled = YES;
//    self.pull = [[PullToRefreshView alloc] initWithScrollView:self.tpScrollView];
//    [self.pull setDelegate:self];
//    [self.tpScrollView addSubview:self.pull];    
    
    self.itemTitleLabel.text = self.currentItem.title;
    self.itemDescriptionLabel.text = self.currentItem.description;
    self.itemPriceLabel.text = [NSString stringWithFormat:@"%@", self.currentItem.askPrice];
    self.itemPriceChangedToLabel.text = [NSString stringWithFormat:@"%@", self.currentItem.askPrice];
    
    NSTimeInterval theTimeInterval = [self.currentItem.postDuration integerValue];
    NSDate *postedDate = [[NSDate alloc] initWithTimeInterval:theTimeInterval sinceDate:self.currentItem.postedDate];
     
    //Set the required date format
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    //Get the string date
    self.itemExpiredDate.text = [formatter stringFromDate:postedDate];   
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:UI_BUTTON_LABEL_BACK
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(OnClick_btnBack:)];
    self.navigationItem.leftBarButtonItem = btnBack;  
    
//    UIImage *tableHeaderViewImage = [UIImage imageNamed:@"middleRow.png"];
//    UIImageView *tableHeaderView = [[UIImageView alloc] initWithImage:tableHeaderViewImage];
//    self.messageTableView.tableHeaderView = tableHeaderView;
//    
//    UIImage *tableFooterViewImage = [UIImage imageNamed:@"middleRow.png"];
//    UIImageView *tableFooterView = [[UIImageView alloc] initWithImage:tableFooterViewImage];
//    self.messageTableView.tableFooterView = tableFooterView;    

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:) 
                                                 name:CHANGED_PRICE_NOTIFICATION
                                               object:nil];
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:CHANGED_PRICE_NOTIFICATION]) {
        
        self.itemPriceChangedToLabel.text = (NSString *)[notification object];
        NSLog (@"Successfully received the test notification! %@", (NSString *)[notification object]);
    }
}

-(IBAction)OnClick_btnBack:(id)sender  {
    if ([self.navigationItem.leftBarButtonItem.title isEqualToString:UI_BUTTON_LABEL_BACK]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.messageTextField resignFirstResponder];
    }
    //[self.navigationController pushViewController:self.navigationController.parentViewController animated:YES];
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.messageTextField) {
        self.navigationItem.leftBarButtonItem.title = UI_BUTTON_LABEL_CANCEL;
        //self.navigationController.navigationBar.backItem.title = @"取消";
        //self.navigationItem.leftBarButtonItem.tintColor = [UIColor redColor];
        self.navigationButton.title = UI_BUTTON_LABEL_SUBMIT;
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

- (IBAction)navigationButtonAction:(id)sender {
    if ([self.navigationButton.title isEqualToString:UI_BUTTON_LABEL_MAP]) {
        [self performSegueWithIdentifier: @"dealMapModal" 
                                  sender: self];
    } else if (self.navigationButton.title == UI_BUTTON_LABEL_SUBMIT) {
        // TODO - submitting data to backend server
          
        
      
      
        [self.messageTextField resignFirstResponder];
    }
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
// called when the date shown needs to be updated, optional
//- (NSDate *)pullToRefreshViewLastUpdated:(PullToRefreshView *)view
//{
//    
//}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"changedPriceSegue"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        OfferChangingPriceViewController *ovc = (OfferChangingPriceViewController *)navigationController.topViewController;
        ovc.currentPrice = self.itemPriceLabel.text;
    }
}

@end
