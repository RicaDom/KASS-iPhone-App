//
//  Location.h
//  Demo
//
//  Created by Qi He on 12-1-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Location : NSObject

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSDecimalNumber *latitude;
@property (nonatomic, strong) NSDecimalNumber *longitude;

- (id) initWithDictionary:(NSDictionary *) theDictionary;
- (CLLocation *) toCLLocation;

@end
