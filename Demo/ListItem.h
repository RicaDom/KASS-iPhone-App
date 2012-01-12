//
//  ListItem.h
//  Demo
//
//  Created by zhicai on 12/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSDate *needItBy;
@property (nonatomic, strong) NSDecimalNumber *askPrice;
@property (nonatomic, strong) NSString *picFileName;

@end
