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
#import "Constants.h"
#import "PostFlowViewController.h"
#import "PostTemplate.h"

@interface PostViewController : UIViewController <UIScrollViewDelegate> {
    @private
    BOOL hotPostPageControlBeingUsed;
    BOOL editorPostPageControlBeingUsed;
    BOOL creativePostPageControlBeingUsed;
}

@property (weak, nonatomic) IBOutlet AppScrollView *hotPostScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *hotPostPageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *editorPostScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *editorPostPageControl;
@property (strong, nonatomic) IBOutlet UIScrollView *creativePostScrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *creativePostPageControl;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *greetingLabel;

@property (strong, nonatomic) NSMutableArray *postTemplates;
@property (strong, nonatomic) NSMutableArray *popularTemplates;
@property (strong, nonatomic) NSMutableArray *editorTemplates;
@property (strong, nonatomic) NSMutableArray *creativeTemplates;
@property (strong, nonatomic) ListItem *segueTemplate;

- (IBAction)changeCreativePostPage;
- (IBAction)changeEditorPostPage;
- (IBAction)changeHotPostPage;

@end
