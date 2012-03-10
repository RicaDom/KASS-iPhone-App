//
//  ItemViewController.h
//  Demo
//
//  Created by zhicai on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListItem+ListItemHelper.h"
#import "Offer.h"
#import "Offers.h"
#import "Message.h"
#import "OfferTableCell.h"
#import "Constants.h"
#import "EGORefreshTableHeaderView.h"
#import "ActivityOfferMessageViewController.h"
#import "VariableStore.h"
#import "AccountActivityDelegate.h"
#import "PostFlowViewController.h"
#import "DataSourceViewController.h"

@interface ItemViewController : DataSourceViewController <UIActionSheetDelegate, EGORefreshTableHeaderDelegate, AccountActivityDelegate>{
	
	EGORefreshTableHeaderView *_refreshHeaderView;
	
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes 
	BOOL _reloading;
  
}


@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (nonatomic, strong) ListItem *currentItem;
@property (strong, nonatomic) IBOutlet UIScrollView *infoScrollView;
@property (strong, nonatomic) IBOutlet UITableView *offerTableView;
@property (strong, nonatomic) NSMutableArray *offers;
@property (strong, nonatomic) IBOutlet UILabel *offersCount;
@property (strong, nonatomic) IBOutlet UILabel *itemPrice;
@property (strong, nonatomic) IBOutlet UILabel *itemExpiredDate;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextField;
@property (strong, nonatomic) IBOutlet UIButton *modifyButton;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;

- (IBAction)backButtonAction:(id)sender;
- (IBAction)editAction:(id)sender;
- (IBAction)shareAction:(id)sender;
@end
