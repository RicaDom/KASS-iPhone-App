//
//  ItemViewController.m
//  Demo
//
//  Created by zhicai on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ItemViewController.h"
#import "ViewHelper.h"
#import "UIViewController+ActivityIndicate.h"
#import "UIViewController+SegueActiveModel.h"
#import "UIViewController+TableViewRefreshPuller.h"

@implementation ItemViewController

@synthesize itemTitle = _itemTitle;
@synthesize currentItem = _currentItem;
@synthesize infoScrollView = _infoScrollView;
@synthesize offerTableView = _offerTableView;
@synthesize offers = _offers;
@synthesize offersCount = _offersCount;
@synthesize itemPrice = _itemPrice;
@synthesize itemExpiredDate = _itemExpiredDate;
@synthesize descriptionTextField = _descriptionTextField;
@synthesize modifyButton = _modifyButton;
@synthesize shareButton = _shareButton;
@synthesize backButton = _backButton;
@synthesize mapButton = _mapButton;

NSString *remoteNotificationOfferId = nil;

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

- (void)hideViews
{
  self.modifyButton.hidden = TRUE;
  self.shareButton.hidden = TRUE;
}

- (void) accountDidGetListing:(NSDictionary *)dict
{
  DLog(@"ItemViewController::accountDidGetListing:dict=%@", dict);
  NSDictionary *listing = [dict objectForKey:@"listing"];
  self.currentItem = [[ListItem alloc] initWithDictionary:listing];
  
  self.itemTitle.text = self.currentItem.title;
  self.descriptionTextField.text = self.currentItem.description;
  self.itemPrice.text = [self.currentItem getPriceText];
  self.itemExpiredDate.text = [self.currentItem getTimeLeftTextlong];

  if (self.currentItem.acceptedOffer) {
    [self hideViews];
    NSString *msg = [[NSString alloc] initWithFormat:@"您的此需求已经以￥%@成交了！", self.currentItem.askPrice];
    [ViewHelper showAlert:self.currentItem.title:msg:self];
  }else{
    self.offers = [[Offers alloc] initWithDictionary:listing].offers;
    self.offersCount.text = [NSString stringWithFormat:@"%d",[self.offers count]] ;
    [self.offerTableView reloadData];
  }
  
  [self hideIndicator];
  [self doneLoadingTableViewData];
}

- (void) loadDataSource
{
  DLog(@"ItemViewController::loadDataSource");
  [self showLoadingIndicator];
  
  NSString *listItemId = [[self kassGetModelDict:@"listItem"] objectForKey:@"id"];
  if ( listItemId && ![listItemId isBlank] ) {
    [self.currentUser getListing:listItemId];
  } else {
    [ViewHelper showErrorAlert:ERROR_MSG_CONNECTION_FAILURE:self];
    [self hideViews];
  }
  
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    DLog(@"ItemViewController::viewDidLoad");
    [super viewDidLoad];
    
    [ViewHelper buildMapButton:self.mapButton];  
    [ViewHelper buildBackButton:self.backButton];
    [ViewHelper buildActivityModifyButton:self.modifyButton];
    [ViewHelper buildActivityShareButton:self.shareButton];
}

- (void)viewDidUnload
{    
    [self setItemTitle:nil];
    [self setInfoScrollView:nil];
    [self setOfferTableView:nil];
    [self setOffersCount:nil];
    [self setItemPrice:nil];
    [self setItemExpiredDate:nil];
    [self setDescriptionTextField:nil];
    [self setModifyButton:nil];
    [self setShareButton:nil];
    [self setMapButton:nil];
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

- (IBAction)backButtonAction:(id)sender {
    if (self.backButton == sender) {
        [self dismissModalViewControllerAnimated:YES];
    }
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

- (void) accountWeiboShareFinished
{
  DLog(@"ItemViewController::accountWeiboShareFinished");
  
}

- (void)accountDidDeleteListing
{
  DLog(@"ItemViewController::accountDidDeleteListing");
  
  [VariableStore.sharedInstance resetActivityListings];
  
  UINavigationController *navController = self.navigationController;
  [navController dismissModalViewControllerAnimated:YES];
  
}

- (IBAction)mapButtonAction:(id)sender
{
  VariableStore.sharedInstance.itemToShowOnMap = _currentItem; 
  [self performSegueWithIdentifier: @"toMapSegue" 
                            sender: self];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 1) {
        DLog(@"Action sheet tag 1");
        DLog(@"Action sheet tag 1 index %d", buttonIndex);
        if (buttonIndex == 0) {// Editing Listing           
            [self performSegueWithIdentifier:@"ActEditingToPostFlow" sender:self];
        } else if (buttonIndex == 1) { 
            
          //delete listing
          [[self currentUser] deleteListing:_currentItem.dbId];
          
        } else if (buttonIndex == 2) {

            //self.label.text = @"Other Button 2 Clicked";
        } else if (buttonIndex == 3) {

            //self.label.text = @"Cancel Button Clicked";
        }
    } else if (actionSheet.tag == 2){
        DLog(@"Action sheet tag 2");
        DLog(@"Action sheet tag 2 index %d", buttonIndex);
        if (buttonIndex == 0) {
            
          //share weibo
          [[self currentUser] weiboShare:_currentItem];
          
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
      DLog(@"ItemViewController::prepareForSegue:offerMessageSegue");
        ActivityOfferMessageViewController  *avc = [segue destinationViewController];
        
        NSIndexPath *path = [self.offerTableView indexPathForSelectedRow];
        int row = [path row];
        avc.currentOffer = [self.offers objectAtIndex:row];
        
        if (remoteNotificationOfferId != nil) {
            Offer *segueOffer = [Offer new];
            segueOffer.dbId = remoteNotificationOfferId;
            avc.currentOffer = segueOffer;
            remoteNotificationOfferId = nil;
        }
    } else if ([segue.identifier isEqualToString:@"ActEditingToPostFlow"]) {
        UINavigationController *nc = [segue destinationViewController];
        PostFlowViewController *pvc = (PostFlowViewController *) nc.topViewController;
        pvc.postType = POST_TYPE_EDITING;
        [VariableStore sharedInstance].currentPostingItem = self.currentItem; 
    } 
}

- (void)remoteNotificationSegue
{
    NSString *flag = [[self kassGetModelDict:@"listItem"] objectForKey:@"flag"];
    remoteNotificationOfferId = nil;
    if ([flag isEqualToString:REMOTE_NOTIFICATION_NEW_MESSAGE]) {
        remoteNotificationOfferId = [[self kassGetModelDict:@"listItem"] objectForKey:@"offerId"];
        NSDictionary *offer = [[NSDictionary alloc] initWithObjectsAndKeys:remoteNotificationOfferId, @"id", nil];
        NSDictionary *offerJson = [[NSDictionary alloc] initWithObjectsAndKeys:offer, @"offer", nil];
        [[[[VariableStore sharedInstance].modelDict objectForKey:@"ItemViewController"] objectForKey:@"listItem"] removeObjectForKey:@"flag"];
        [[[[VariableStore sharedInstance].modelDict objectForKey:@"ItemViewController"] objectForKey:@"listItem"] removeObjectForKey:@"offerId"];
        [self performSegueWithModelJson:offerJson:@"offerMessageSegue":self];     
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
  
  [cell buildCellByOffer:[self.offers objectAtIndex:indexPath.row]];
    
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

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self registerTableViewRefreshPuller:self.offerTableView:self.view];
    

}

- (void)viewDidAppear:(BOOL)animated
{
  [self remoteNotificationSegue];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [self unregisterTableViewRefreshPuller];
}

- (void)refreshing
{
  [self loadDataSource];
}

@end
