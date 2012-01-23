//
//  MainTabBarViewController.m
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainTabBarViewController.h"

@implementation MainTabBarViewController

- (void)tabBarController:(UITabBarController *)tbc didSelectViewController:(UIViewController *)vc {
    // Middle tab bar item in question.
    NSLog(@"AVVVVVVVVVVVVVVVVVVVVV");
    if (vc == [tbc.viewControllers objectAtIndex:4]) {
        NSLog(@"VVVVVVVVVVVVVVVVVVVVV");
        //ScanVC *scanView = [[ScanVC alloc] initWithNibName:@"ScanViewController" bundle:nil];
        
        // set properties of scanView's ivars, etc
        
        //UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:scanView];
        
        [tbc presentModalViewController:vc animated:YES];
        //[navigationController release];
        //[scanView release];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{   
    NSLog(@"Testing ............ ");
    [self showMessage];
    [super viewDidLoad];
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

- (void)showMessage {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"KASS Get Started" 
                                                      message:@"Buy and Sell Anything with People Nearby " 
                                                     delegate:self 
                                            cancelButtonTitle:@"or just skip this for now" 
                                            otherButtonTitles:@"Sign Up", @"Login", @"Sign in with Facebook", nil];
    [message show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
	
	if([title isEqualToString:@"Sign in with Facebook"])
	{
		NSLog(@"Sign in with Facebook was selected.");
	}
	else if([title isEqualToString:@"Sign Up"])
	{
		NSLog(@"Sign Up was selected.");
	}
	else if([title isEqualToString:@"Login"])
	{
		NSLog(@"Login was selected.");
	} 
	else if([title isEqualToString:@"or just skip this for now"])
    {
        NSLog(@"or just skip this for now was selected.");
    }
}

@end
