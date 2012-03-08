//
//  OfferTableCell.m
//  Demo
//
//  Created by zhicai on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OfferTableCell.h"

@implementation OfferTableCell

@synthesize title = _title;
@synthesize price = _price;
@synthesize distance = _distance;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)buildCellByOffer:(Offer *)offer
{
  UIImage *rowBackground = [UIImage imageNamed:UI_IMAGE_TABLE_CELL_BG];
  UIImageView *imageView = [[UIImageView alloc] initWithImage:rowBackground];
  self.backgroundView = imageView;
  
  UIImage *selectedBackground = [UIImage imageNamed:UI_IMAGE_TABLE_CELL_BG_PRESS];
  UIImageView *selectedImageView = [[UIImageView alloc] initWithImage:selectedBackground];
  self.selectedBackgroundView = selectedImageView;

  NSString *priceText =  [NSString stringWithFormat:@"¥ %@", [offer.price stringValue]];
  self.price.text = priceText;
  
  self.distance.text = [offer.distance stringValue];
  self.title.text = offer.lastMessage.body;
}

@end
