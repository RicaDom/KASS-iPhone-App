//
//  ListingTableCell.m
//  Demo
//
//  Created by zhicai on 2/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListingTableCell.h"

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

@end
