//
//  MainTabBarViewController.m
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "MTPopupWindow.h"

@implementation MainTabBarViewController

static BOOL alreadyShowedIntro = false;

#define DEFAULT_SELECTED_TAB_INDEX 1

- (void)setTabBarImage:(int)index:(UIImage *)image {
  UITabBarItem *barItem = [[[self tabBar] items] objectAtIndex:index];
  [barItem setFinishedSelectedImage:image withFinishedUnselectedImage:image];   
}

- (void)tabBarController:(UITabBarController *)tbc didSelectViewController:(UIViewController *)vc {
    // Middle tab bar item in question.
    if (vc == [tbc.viewControllers objectAtIndex:4]) {
        [tbc presentModalViewController:vc animated:YES];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      NSLog(@"MainTabBarViewController::initWithNibName ");
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
  int i=0;
  for (UITabBarItem *tItem in [tabBar items]) {
    [self setTabBarImage:i:( item == tItem ?  ((i == 0 || i == 3) ? selectedLowImage : selectedImage) : nil)];
    i++;
  }
}

- (void)viewSetup
{
  [self tabBar].selectionIndicatorImage = [UIImage imageNamed:UI_IMAGE_EMPTY];
  [[self tabBar] setBackgroundImage:[UIImage imageNamed:UI_IMAGE_TABBAR_BACKGROUND]];
  selectedImage = [UIImage imageNamed:UI_IMAGE_TABBAR_SELECTED_TRANS];
  selectedLowImage = [UIImage imageNamed:UI_IMAGE_TABBAR_IMAGE];
  [self setTabBarImage:DEFAULT_SELECTED_TAB_INDEX:selectedImage];
  [self setSelectedIndex:DEFAULT_SELECTED_TAB_INDEX];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{   
    DLog(@"MainTabBarViewController::viewDidLoad ");
    [super viewDidLoad];
    [self viewSetup];

    [VariableStore sharedInstance].mainTabBar = self;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(receiveNewPostNotification:) 
                                               name:NEW_POST_NOTIFICATION
                                             object:nil];
  
    singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    closeFingerTap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleCloseTap:)];

  
    if ( !VariableStore.sharedInstance.isAutoLogin && ![[VariableStore sharedInstance] isLoggedIn]) {
      [MTPopupWindow showWindowWithUIView:self.view];
      if (!alreadyShowedIntro) {
        [ViewHelper showIntroView:self.view:singleFingerTap:closeFingerTap];
        alreadyShowedIntro = true;
      }
    }
}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
  CGPoint location = [recognizer locationInView:recognizer.view];
  
  if (location.x > 19.0 && location.x < 156.0 && location.y > 625.0 && location.y < 675.0) {
    [ViewHelper hideIntroView:self.view];
  }
  
}

- (void)handleCloseTap:(UITapGestureRecognizer *)recognizer {
  [ViewHelper hideIntroView:self.view];
}


- (void) receiveNewPostNotification:(NSNotification *) notification
{
    // [notification name] should always be NEW_POST_NOTIFICATION
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:NEW_POST_NOTIFICATION]) {        
        DLog (@"MainTabBarViewController::receiveNewPostNotification");
        self.selectedIndex = 0;
        selectedLowImage = [UIImage imageNamed:UI_IMAGE_TABBAR_IMAGE];
        [self setTabBarImage:0:selectedLowImage];
        [self setTabBarImage:1:nil];
        
        CustomImageViewPopup *pop = [[CustomImageViewPopup alloc] initWithType:POPUP_IMAGE_NEW_POST_SUCCESS];
        [self.view addSubview: pop];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
            [pop removeFromSuperview];
        });
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload]; 
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NEW_POST_NOTIFICATION object:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
