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

- (void)viewSetup
{
    if ([[self tabBar] respondsToSelector:@selector(setBackgroundImage:)])
    {
        // set it just for this instance
        [[self tabBar] setBackgroundImage:[UIImage imageNamed:UI_IMAGE_TABBAR_BACKGROUND]];
        [self tabBar].selectionIndicatorImage = [UIImage imageNamed:UI_IMAGE_TABBAR_SELECTED_TRANS];
        //[[[[self tabBar] items] objectAtIndex:0] setBadgeValue:@"77"];
        //[[self tabBar] setBackgroundColor:[UIColor redColor]];
        // set for all
        // [[UITabBar appearance] setBackgroundImage: ...
    }
    else
    {
        // ios 4 code here
    }    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{   
    DLog(@"MainTabBarViewController::viewDidLoad ");
    [super viewDidLoad];
    [self viewSetup];

    [VariableStore sharedInstance].mainTabBar = self;

    if ( ![[VariableStore sharedInstance] isLoggedIn]) {
        [MTPopupWindow showWindowWithUIView:self.view];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(receivePriceChangedNotification:) 
                                               name:NEW_POST_NOTIFICATION
                                             object:nil];
    
}

- (void) receivePriceChangedNotification:(NSNotification *) notification
{
    // [notification name] should always be NEW_POST_NOTIFICATION
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:NEW_POST_NOTIFICATION]) {        
        DLog (@"MainTabBarViewController::receivePriceChangedNotification");
        self.selectedIndex = 0;
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
