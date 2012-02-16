//
//  ItemViewController.m
//  Demo
//
//  Created by zhicai on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ItemViewController.h"

@implementation ItemViewController

@synthesize itemTitle = _itemTitle;
@synthesize itemDescription = _itemDescription;
@synthesize currentItem = _currentItem;
@synthesize infoScrollView = _infoScrollView;
@synthesize offerTableView = _offerTableView;
@synthesize offers = _offers;
@synthesize offersCount = _offersCount;
@synthesize itemPrice = _itemPrice;
@synthesize itemExpiredDate = _itemExpiredDate;

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

- (BOOL) loadingOffers
{
    // TODO
    // get data from API using self.currentItem.dbId
//    if (Successful) {
//        return YES;
//    } 
//    return NO;
    
    self.offers = [[NSMutableArray alloc] init];
    Offer *offer = [Offer new];
    offer.price = [NSDecimalNumber decimalNumberWithDecimal:
                   [[NSNumber numberWithDouble:30] decimalValue]];
    offer.distance = [NSNumber numberWithInt:80];
    Message *lastMessage = [Message new ];
    lastMessage.body = @"太贵了吧";
    offer.lastMessage = lastMessage;
    [self.offers addObject:offer];
    
    offer = [Offer new];
    offer.price = [NSDecimalNumber decimalNumberWithDecimal:
                   [[NSNumber numberWithDouble:50] decimalValue]];
    offer.distance = [NSNumber numberWithInt:100];
    lastMessage = [Message new ];
    lastMessage.body = @"SBSBSB";
    offer.lastMessage = lastMessage;
    [self.offers addObject:offer];
    
    self.offersCount.text = [NSString stringWithFormat:@"%d",[self.offers count]] ;
    [self.offerTableView reloadData];
    return YES;
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
    self.itemTitle.text = self.currentItem.title;
    self.itemDescription.text = self.currentItem.description;
    self.itemPrice.text =[NSString stringWithFormat:@"%@", self.currentItem.askPrice];
    self.itemExpiredDate.text = @"TODO 7 天";
    
    [super viewDidLoad];
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:UI_BUTTON_LABEL_BACK
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(OnClick_btnBack:)];
    self.navigationItem.leftBarButtonItem = btnBack;  
    
    // Loading Offer
    // TODO
    if ([self loadingOffers]) {

    }
    
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.offerTableView.bounds.size.height, self.view.frame.size.width, self.offerTableView.bounds.size.height)];
		view.delegate = self;
		[self.offerTableView addSubview:view];
		_refreshHeaderView = view;
		
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.offerTableView];
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:2.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

-(IBAction)OnClick_btnBack:(id)sender  {
    if ([self.navigationItem.leftBarButtonItem.title isEqualToString:UI_BUTTON_LABEL_BACK]) {
        [self dismissModalViewControllerAnimated:YES];
        //[self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidUnload
{    
    [self setItemTitle:nil];
    [self setItemDescription:nil];
    [self setInfoScrollView:nil];
    [self setOfferTableView:nil];
    [self setOffersCount:nil];
    [self setItemPrice:nil];
    [self setItemExpiredDate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)backButtonAction:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)editAction:(id)sender {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:UI_BUTTON_LABEL_CANCEL destructiveButtonTitle:nil otherButtonTitles:UI_BUTTON_LABEL_UPDATE, UI_BUTTON_LABEL_DELETE, nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    popupQuery.tag = 1;
    [popupQuery showInView:self.view];
}

- (IBAction)shareAction:(id)sender {
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:UI_BUTTON_LABEL_SHARE_WITH_FRIEND delegate:self cancelButtonTitle:UI_BUTTON_LABEL_CANCEL destructiveButtonTitle:nil otherButtonTitles:UI_BUTTON_LABEL_WEIBO_SHARE, UI_BUTTON_LABEL_SEND_MESSAGE, UI_BUTTON_LABEL_SEND_EMAIL, nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    popupQuery.tag = 2;
    [popupQuery showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 1) {
        DLog(@"Action sheet tag 1");
        DLog(@"Action sheet tag 1 index %d", buttonIndex);
        if (buttonIndex == 0) {
            
            //self.label.text = @"Destructive Button Clicked";
        } else if (buttonIndex == 1) {

            //self.label.text = @"Other Button 1 Clicked";
        } else if (buttonIndex == 2) {

            //self.label.text = @"Other Button 2 Clicked";
        } else if (buttonIndex == 3) {

            //self.label.text = @"Cancel Button Clicked";
        }
    } else if (actionSheet.tag == 2){
        DLog(@"Action sheet tag 2");
        DLog(@"Action sheet tag 2 index %d", buttonIndex);
        if (buttonIndex == 0) {
            
            //self.label.text = @"Destructive Button Clicked";
        } else if (buttonIndex == 1) {
            
            //self.label.text = @"Other Button 1 Clicked";
        } else if (buttonIndex == 2) {
            
            //self.label.text = @"Other Button 2 Clicked";
        } else if (buttonIndex == 3) {
            
            //self.label.text = @"Cancel Button Clicked";
        }
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"offerMessageSegue"]) {
        ActivityOfferMessageViewController  *avc = [segue destinationViewController];
        
        NSIndexPath *path = [self.offerTableView indexPathForSelectedRow];
        int row = [path row];
        avc.currentOffer = [self.offers objectAtIndex:row];
        avc.currentItem = self.currentItem;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // #warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    return [self.offers count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"offerCell";
    OfferTableCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[OfferTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIImage *rowBackground = [UIImage imageNamed:@"middleRow.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:rowBackground];
    cell.backgroundView = imageView;
    
    UIImage *selectedBackground = [UIImage imageNamed:@"middleRowSelected.png"];
    UIImageView *selectedImageView = [[UIImageView alloc] initWithImage:selectedBackground];
    cell.selectedBackgroundView = selectedImageView;
    
    // Configure the cell...
    Offer *offer = [self.offers objectAtIndex:indexPath.row];
    cell.price.text = [offer.price stringValue];
    cell.distance.text = [offer.distance stringValue];
    cell.title.text = offer.lastMessage.body;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     // <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    
}

//// Reloading data
//- (void)refresh {
//    [self performSelector:@selector(addItem) withObject:nil afterDelay:2.0];
//}
//
//- (void)addItem {
//    // TODO
//    // Adding item to the list
//    
//    [self.tableView reloadData];
//    
//    [self stopLoading];
//}



@end
