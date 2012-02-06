//
//  SettingViewController.m
//  Demo
//
//  Created by zhicai on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"


@implementation SettingViewController
@synthesize welcomeMessageLabel;
@synthesize authButton;

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)welcomeMessage
{
    if ([[VariableStore sharedInstance].isLoggedIn isEqualToString:@"YES"]) {     
        self.authButton.title = UI_BUTTON_LABEL_SIGOUT;
        self.welcomeMessageLabel.text = [@"你好! " stringByAppendingString:[VariableStore sharedInstance].user.name]; 
    } else {
        self.authButton.title = UI_BUTTON_LABEL_SIGIN;
        self.welcomeMessageLabel.text = @"欢迎来到全世界最帅的KASS！！"; 
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self welcomeMessage];
}

- (void)viewDidUnload
{
    [self setWelcomeMessageLabel:nil];
    [self setAuthButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)authButtonAction:(id)sender {
    
    //[MTPopupWindow showWindowWithHTMLFile:@"testContent.html" insideView:self.tabBarController.view];
    [MTPopupWindow showWindowWithUIView:self.tabBarController.view];
    
    if ([self.authButton.title isEqualToString:UI_BUTTON_LABEL_SIGIN]) {
      
      if ([[VariableStore sharedInstance] signIn]) {
          self.authButton.title = UI_BUTTON_LABEL_SIGOUT;
      }
    } else {
      if ([[VariableStore sharedInstance] signOut]) {
          self.authButton.title = UI_BUTTON_LABEL_SIGIN;
      }
    }
    [self welcomeMessage];
}
@end
