//
//  KeyboardSliderDelegate.h
//  Demo
//
//  Created by Qi He on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KeyboardSliderDelegate <NSObject>

@optional
- (void) keyboardMainViewMovedDown;
- (void) keyboardMainViewMovedUp;


@end
