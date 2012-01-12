//
//  PostViewController.h
//  Demo
//
//  Created by zhicai on 1/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppScrollView.h"

@interface PostViewController : UIViewController <UIScrollViewDelegate> 

@property (weak, nonatomic) IBOutlet AppScrollView *hotPostScrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *hotPostPageControl;

- (IBAction)changeHotPostPage;
//- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event;
@end
