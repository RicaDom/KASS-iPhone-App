//
//  ListingTableCell.h
//  Demo
//
//  Created by zhicai on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListItem+ListItemHelper.h"

@interface ListingTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
//@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UIButton *distance;
@property (weak, nonatomic) IBOutlet UIButton *duration;
@property (weak, nonatomic) IBOutlet UIButton *price;
@property (weak, nonatomic) IBOutlet UIView *infoView;

- (void)buildCellByListItem:(ListItem *)item;

@end
