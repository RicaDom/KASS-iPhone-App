//
//  MainTabBarViewController.m
//  Demo
//
//  Created by zhicai on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "MTPopupWindow.h"

#import "NSData+Crypto.h"
#import "NSString+Crypto.h"
#import "SFHFKeychainUtils.h"

@implementation MainTabBarViewController

@synthesize weibo;

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

- (void)viewDidAppear:(BOOL)animated
{
  NSLog(@"MainTabBarViewController::viewDidAppear ");
  [self showMessage];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{   
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
//    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"KASS Get Started" 
//                                                      message:@"Buy and Sell Anything with People Nearby " 
//                                                     delegate:self 
//                                            cancelButtonTitle:@"or just skip this for now" 
//                                            otherButtonTitles:@"Sign Up", @"Login", @"Sign in with Facebook", nil];
    
    //UIImageView *Image =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images.png"]];
    
    //[message addSubview:Image];
    
    //[message show];

    //[MTPopupWindow showWindowWithHTMLFile:@"testContent.html" insideView:self.view];
    [MTPopupWindow showWindowWithUIView:self.view];
    //[ALToastView toastInView:self.view withText:@"Hello ALToastView"];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
	
	if([title isEqualToString:@"Sign in with Facebook"])
	{
        [[VariableStore sharedInstance] signIn];
		NSLog(@"Sign in with Facebook was selected.");
	}
	else if([title isEqualToString:@"Sign Up"])
	{
		NSLog(@"Sign Up was selected.");
	}
	else if([title isEqualToString:@"Login"])
	{
        [[VariableStore sharedInstance] signIn];
        NSLog(@"Sign in: %@", [VariableStore sharedInstance].isLoggedIn);
		NSLog(@"Login was selected.");
	} 
	else if([title isEqualToString:@"or just skip this for now"])
    {
        NSLog(@"or just skip this for now was selected.");
    }
}

- (void) weiboLogin
{
  if( weibo ) { weibo = nil; }
  
  weibo = [[WeiBo alloc]initWithAppKey:SinaWeiBoSDKDemo_APPKey 
                         withAppSecret:SinaWeiBoSDKDemo_APPSecret];
  weibo.delegate = self;
  
  DLog(@"MainTabBarViewController::weiboLogin:weibo=%@", weibo);
  [weibo startAuthorize];
}

- (NSString*)stringFromDictionary:(NSDictionary*)info
{
	NSMutableArray* pairs = [NSMutableArray array];
	
	NSArray* keys = [info allKeys];
	keys = [keys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	for (NSString* key in keys) 
	{
		if( ([[info objectForKey:key] isKindOfClass:[NSString class]]) == FALSE)
			continue;
		
		[pairs addObject:[NSString stringWithFormat:@"%@=%@", key, [[info objectForKey:key]URLEncodedString]]];
	}
	
	return [pairs componentsJoinedByString:@"&"];
}

- (void)weiboDidLogin
{
	DLog(@"MainTabBarViewController::weiboDidLogin:userID=%@", [weibo userID]);
	DLog(@"MainTabBarViewController::weiboDidLogin:Token=%@", [weibo accessToken]);
	DLog(@"MainTabBarViewController::weiboDidLogin:Secret=%@", [weibo accessTokenSecret]);
  // User logins in using weibo successfully
  
  NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 [weibo accessToken],@"oauth_access_token",
                                 [weibo accessTokenSecret],@"oauth_access_token_secret",
                                 [weibo userID],@"oauth_customer_id",
                                 @"AES",@"oauth_signature_method",
                                 [NSString stringWithFormat:@"%.0f",[[NSDate date]timeIntervalSince1970]],@"oauth_timestamp",nil];
	
	
	NSString* baseString = [self stringFromDictionary:params];
	NSString* keyString = [NSString stringWithFormat:@"%@&%@",[SinaWeiBoSDKDemo_APPKey URLEncodedString],[SinaWeiBoSDKDemo_APPSecret URLEncodedString]];

  DLog(@"keyString=%@", keyString);
  
  NSData              *plain = [baseString dataUsingEncoding: NSUTF8StringEncoding];
  NSData              *key = [NSData dataWithBytes: [[keyString sha256] bytes] length: kCCKeySizeAES128];
  NSData              *cipher = [plain aesEncryptedDataWithKey: key];
  NSString            *base64 = [cipher base64Encoding];
  
  DLog(@"Base 64 encoded = %@",base64);
  
  
  
  //[SFHFKeychainUtils storeUsername:[weibo userID] andPassword: forServiceName:KassServiceName updateExisting:YES error:nil];
  
}

- (void)weiboLoginFailed:(BOOL)userCancelled withError:(NSError*)error
{
	DLog(@"MainTabBarViewController::weiboLoginFailed");
}

@end
