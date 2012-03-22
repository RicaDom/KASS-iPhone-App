//
//  SettingViewController.m
//  Demo
//
//  Created by zhicai on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"
#import "UIViewController+ActivityIndicate.h"
#import "NotificationRenderHelper.h"

@implementation SettingViewController

@synthesize rightButton;
@synthesize welcomeMessageLabel;

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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // navigation bar background color
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:NAVIGATION_BAR_BACKGROUND_COLOR_RED green:NAVIGATION_BAR_BACKGROUND_COLOR_GREEN blue:NAVIGATION_BAR_BACKGROUND_COLOR_BLUE alpha:NAVIGATION_BAR_BACKGROUND_COLOR_ALPHA];
    
    if ([VariableStore sharedInstance].isLoggedIn) {
        [ViewHelper buildLogoutButton:self.rightButton];
        self.rightButton.tag = RIGHT_BAR_BUTTON_LOGOUT;        
    } else{
        [ViewHelper buildLoginButton:self.rightButton];
        self.rightButton.tag = RIGHT_BAR_BUTTON_LOGIN;
    }
}

- (void)loadDataSource
{
    if ([[VariableStore sharedInstance] isLoggedIn] ) {     
        [ViewHelper buildLogoutButton:self.rightButton];
        self.rightButton.tag = RIGHT_BAR_BUTTON_LOGOUT;   
        self.welcomeMessageLabel.text = [@"你好! " stringByAppendingString:[VariableStore sharedInstance].user.name]; 
    } else {
        [ViewHelper buildLoginButton:self.rightButton];
        self.rightButton.tag = RIGHT_BAR_BUTTON_LOGIN;
        self.welcomeMessageLabel.text = @"欢迎来到街区！！"; 
    }
    [self hideIndicator];
}

- (void) accountLoginFinished
{
  DLog(@"SettingViewController::accountLoginFinished");
  [self loadDataSource];
}

- (void)accountLogoutFinished
{
  DLog(@"SettingViewController::accountLogoutFinished");
  [self loadDataSource];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadDataSource];
}

- (void)viewDidUnload
{
    [self setWelcomeMessageLabel:nil];
    [self setRightButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)rightButtonAction:(id)sender {
    if (self.rightButton.tag == RIGHT_BAR_BUTTON_LOGIN) {
        [MTPopupWindow showWindowWithUIView:self.tabBarController.view];
    } else {
        [[VariableStore sharedInstance] signOut];
    }
    
}

@end
