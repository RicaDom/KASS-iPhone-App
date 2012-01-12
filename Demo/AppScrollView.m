//
//  AppScrollView.m
//  Demo
//
//  Created by zhicai on 1/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppScrollView.h"

@implementation AppScrollView

- (id)initWithFrame:(CGRect)frame 
{
    return [super initWithFrame:frame];
}

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	
    // If not dragging, send event to next responder
    if (!self.dragging) {
       // NSLog(@"Scroll View = %@", self);
       // NSLog(@"nextResponder = %@", self.nextResponder);
       //  NSLog(@"nextResponder = %@", self.nextResponder.nextResponder);
//        UITouch *touch = [touches anyObject];
//        CGPoint tapLocation = [touch locationInView:self];
//        NSLog(@"Post Location: %@", tapLocation);
        [self.nextResponder.nextResponder touchesEnded: touches withEvent:event]; 
    } else {
        [super touchesEnded: touches withEvent: event];
    }
}

@end
