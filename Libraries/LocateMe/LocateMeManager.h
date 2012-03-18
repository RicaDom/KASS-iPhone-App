//
//  LocateMeManager.h
//  Demo
//
//  Created by Qi He on 12-2-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "NSObject+LocateMe.h"
#import "LocateMeDelegate.h"

@interface LocateMeManager : NSObject

@property (nonatomic,assign) id<LocateMeDelegate> delegate;

- (CLLocation *)location;
- (void)locateMe;
- (BOOL) hasLocation;

@end
