//
//  Alert.h
//  Demo
//
//  Created by Wesley Wang on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface Alert : NSObject

@property(nonatomic, strong) NSString *keyword;
@property(nonatomic, strong) NSString *minPrice;
@property(nonatomic, strong) NSString *radius;
@property(nonatomic, strong) Location *userCurrentLocation;
@property(nonatomic, strong) NSString *userSpecifyLocation;

@end
