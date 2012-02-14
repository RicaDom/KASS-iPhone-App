//
//  UIResponder+LocateMe.h
//  Demo
//
//  Created by Qi He on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NSObject (LocateMe) <CLLocationManagerDelegate>

- (void)locateFinished;
- (void)locateFailed;

@end
