//
//  PostFlowViewController.m
//  Demo
//
//  Created by zhicai on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PostFlowViewController.h"

@implementation PostFlowViewController

@synthesize titleTextField = _titleTextField;
@synthesize currentTabBarController = _currentTabBarController;

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
    [super viewDidLoad];
    [self.titleTextField becomeFirstResponder];
    //NSLog(@"Current tab controller: %@", NSStringFromClass([currentTabBarController class]));
}


- (void)viewDidUnload
{
    [self setTitleTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)CancelAction:(id)sender {
    [self.titleTextField resignFirstResponder];
    NSLog(@"controller class: %@", NSStringFromClass([self.navigationController.tabBarController class]));
    printf("Index: %d", self.navigationController.tabBarController.selectedIndex);
    //[self.navigationController dismissModalViewControllerAnimated:YES];
    //[self.navigationController removeFromParentViewController];
    //[self.navigationController dismissModalViewControllerAnimated:YES];
    //[self dismissModalViewControllerAnimated:YES];
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
    
    //self.navigationController.tabBarController.selectedIndex = 2;
    //[self.navigationController.tabBarController.selectedViewController viewDidAppear:YES];
    //[self.navigationController.tabBarController
}
@end
