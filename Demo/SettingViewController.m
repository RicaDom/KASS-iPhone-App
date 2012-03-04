//
//  SettingViewController.m
//  Demo
//
//  Created by zhicai on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"
#import "UIViewController+ActivityIndicate.h"


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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [super viewDidLoad];
  self.navigationController.navigationBar.tintColor = [UIColor brownColor];
}

- (void)loadDataSource
{
    if ([[VariableStore sharedInstance] isLoggedIn] ) {     
        self.authButton.title = UI_BUTTON_LABEL_SIGOUT;
        self.welcomeMessageLabel.text = [@"你好! " stringByAppendingString:[VariableStore sharedInstance].user.name]; 
    } else {
        self.authButton.title = UI_BUTTON_LABEL_SIGIN;
        self.welcomeMessageLabel.text = @"欢迎来到全世界最帅的KASS！！"; 
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
  if ([self.authButton.title isEqualToString:UI_BUTTON_LABEL_SIGIN]) {
    [MTPopupWindow showWindowWithUIView:self.tabBarController.view];
  } else {
    [[VariableStore sharedInstance] signOut];
  }
}
@end
