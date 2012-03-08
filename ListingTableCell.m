//
//  ListingTableCell.m
//  Demo
//
//  Created by zhicai on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListingTableCell.h"
#import "VariableStore.h"

@implementation ListingTableCell

@synthesize title = _title;
@synthesize subTitle = _subTitle;
@synthesize distance = _distance;
@synthesize duration = _duration;
@synthesize price = _price;
@synthesize infoView = _infoView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)buildCellByListItem:(ListItem *)item
{
    UIImage *rowBackground = [UIImage imageNamed:UI_IMAGE_TABLE_CELL_BG];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:rowBackground];
    self.backgroundView = imageView;
      
    UIImage *selectedBackground = [UIImage imageNamed:UI_IMAGE_TABLE_CELL_BG_PRESS];
    UIImageView *selectedImageView = [[UIImageView alloc] initWithImage:selectedBackground];
    self.selectedBackgroundView = selectedImageView;
  
    if (item.askPrice != nil) {
    NSString *price = [[item askPrice] stringValue];

    self.title.text = [item title];
    self.subTitle.text = [item description];
    [self.price setTitle:price forState:UIControlStateNormal];
    }
    self.price.enabled = NO;

    [self.distance setTitle:[item getDistanceFromLocationText:VariableStore.sharedInstance.location] forState:UIControlStateNormal];
    self.distance.enabled = NO;

    [self.duration setTitle:[item getTimeLeftText]forState:UIControlStateNormal];
    self.duration.enabled = NO;
}

@end
