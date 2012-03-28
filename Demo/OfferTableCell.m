//
//  OfferTableCell.m
//  Demo
//
//  Created by zhicai on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OfferTableCell.h"
#import "Offer+OfferHelper.h"
#import "ViewHelper.h"

@implementation OfferTableCell

@synthesize title = _title;
@synthesize price = _price;
@synthesize cellView = _cellView;

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

  NSString *priceText =  [offer getPriceText];
  self.price.text = priceText;
  self.title.text = offer.lastMessage.body;
  
  if (offer.sellerImageUrl.isPresent) {
    [ViewHelper buildRoundCustomImageViewWithFrame:_cellView:offer.sellerImageUrl:CGRectMake(7.5,7.5,45,45)];
  }
  
}

@end
