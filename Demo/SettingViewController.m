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


- (void)setupAccount:(NSData *)data
{
  DLog(@"SettingViewController::setupAccount");
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"SettingViewController::setupAccount:dict %@", dict);
}

- (void)login
{
  
  NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
  NSString *username = [standardDefaults stringForKey:@"kApplicationUserNameKey"];
  NSString *password = @"";
  
  if (username) {
    NSError *error = nil;
    password = [SFHFKeychainUtils getPasswordForUsername:username andServiceName:@"com.company.app" error:&error];
    
    DLog(@"SettingViewController::login:user=%@, password=%@", username, password);
    
  } else {
    // No username. Prompt the user to enter username & password and store it
    username = @"kass@gmail.com";
    password = @"1111111";
    
    [standardDefaults setValue:username forKey:@"kApplicationUserName"];    
    
    NSError *error = nil;
    BOOL storeResult = [SFHFKeychainUtils storeUsername:username andPassword:password forServiceName:@"com.company.app" updateExisting:YES error:&error];
    
    DLog(@"SettingViewController::login:store=%@",  (storeResult ? @"YES" : @"NO"));
  }
  
  
  NSDictionary * userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                             username, @"email",
                             password, @"password",
                             nil];
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"setupAccount:"];
  [ka login:userInfo];
}

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
    if ([self.authButton.title isEqualToString:UI_BUTTON_LABEL_SIGIN]) {
      
      //log user in
      [self login];      
    
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
