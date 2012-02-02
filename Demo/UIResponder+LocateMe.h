//
//  UIResponder+LocateMe.h
//  Demo
//
//  Created by Qi He on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface UIResponder (LocateMe) <CLLocationManagerDelegate>

- (void)locateFinished;
- (void)locateFailed;

@end
