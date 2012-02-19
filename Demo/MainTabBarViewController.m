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

//- (void)viewDidAppear:(BOOL)animated
//{ 
////  NSLog(@"MainTabBarViewController::viewDidAppear ");
////  if ( ![[VariableStore sharedInstance] isLoggedIn]) {
////    //[self showMessage];
////    [MTPopupWindow showWindowWithUIView:self.view];
////  }
//}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{   
   [super viewDidLoad];
    //[self.mainTabBar setBackgroundColor:[UIColor redColor]];
   //[self.tabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar2.png"]];  
    //UITabBar *tabBar= self.mainTabBar;
    //[self.mainTabBar setBackgroundImage:[UIImage imageNamed:@"tabbar2.png"]];  
//    if ([self.mainTabBar respondsToSelector:@selector(setBackgroundImage:)]) {
//        // set it just for this instance
//        //[tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar2.png"]];
//        [self.mainTabBar setBackgroundImage:[UIImage imageNamed:@"tabbar2.png"]];  
//    }
    
   NSLog(@"MainTabBarViewController::viewDidAppear ");
   if ( ![[VariableStore sharedInstance] isLoggedIn]) {
       [MTPopupWindow showWindowWithUIView:self.view];
   }
}


- (void)viewDidUnload
{
    [super viewDidUnload]; 
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//- (void)showMessage {
////    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"KASS Get Started" 
////                                                      message:@"Buy and Sell Anything with People Nearby " 
////                                                     delegate:self 
////                                            cancelButtonTitle:@"or just skip this for now" 
////                                            otherButtonTitles:@"Sign Up", @"Login", @"Sign in with Facebook", nil];
//    
//    //UIImageView *Image =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images.png"]];
//    
//    //[message addSubview:Image];
//    
//    //[message show];
//
//    //[MTPopupWindow showWindowWithHTMLFile:@"testContent.html" insideView:self.view];
//    //[MTPopupWindow showWindowWithUIView:self.view];
//    //[ALToastView toastInView:self.view withText:@"Hello ALToastView"];
//}
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//	NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
//	
//	if([title isEqualToString:@"Sign in with Facebook"])
//	{
//		NSLog(@"Sign in with Facebook was selected.");
//	}
//	else if([title isEqualToString:@"Sign Up"])
//	{
//		NSLog(@"Sign Up was selected.");
//	}
//	else if([title isEqualToString:@"Login"])
//	{
//    NSLog(@"Sign in: %@", [VariableStore sharedInstance].isLoggedIn);
//		NSLog(@"Login was selected.");
//	} 
//	else if([title isEqualToString:@"or just skip this for now"])
//    {
//        NSLog(@"or just skip this for now was selected.");
//    }
//}

-(void)offerMessageToPayPage{
    DLog(@"BrowseTableViewController::offerMessageToPayPage");
    DLog(@"BrowseTableViewController::offerMessageToPayPage");
    DLog(@"BrowseTableViewController::offerMessageToPayPage");
    DLog(@"BrowseTableViewController::offerMessageToPayPage");
    DLog(@"BrowseTableViewController::offerMessageToPayPage");
    DLog(@"BrowseTableViewController::offerMessageToPayPage");
    DLog(@"BrowseTableViewController::offerMessageToPayPage");
    DLog(@"BrowseTableViewController::offerMessageToPayPage");
    DLog(@"BrowseTableViewController::offerMessageToPayPage");
    DLog(@"BrowseTableViewController::offerMessageToPayPage");
    DLog(@"BrowseTableViewController::offerMessageToPayPage");
    DLog(@"BrowseTableViewController::offerMessageToPayPage");
    DLog(@"BrowseTableViewController::offerMessageToPayPage");
    DLog(@"BrowseTableViewController::offerMessageToPayPage");
    DLog(@"BrowseTableViewController::offerMessageToPayPage");
}


@end
