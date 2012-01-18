//
//  PostViewController.h
//  Demo
//
//  Created by zhicai on 1/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppScrollView.h"
#import "ListItem.h"
#import "PostFlowViewController.h"

@interface PostViewController : UIViewController <UIScrollViewDelegate> {
    @private
    BOOL hotPostPageControlBeingUsed;
    BOOL editorPostPageControlBeingUsed;
}

@property (weak, nonatomic) IBOutlet AppScrollView *hotPostScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *hotPostPageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *editorPostScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *editorPostPageControl;

- (IBAction)changeEditorPostPage;
- (IBAction)changeHotPostPage;
//- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event;
@end
