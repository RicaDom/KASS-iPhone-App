//
//  UserInfoWebViewController.m
//  kass
//
//  Created by zhicai on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserInfoWebViewController.h"
#import "Constants.h"
#import "ViewHelper.h"

@implementation UserInfoWebViewController

@synthesize userSNSInfo = _userSNSInfo;
@synthesize userInfoWebView = _userInfoWebView;
@synthesize goBackButton = _goBackButton;
@synthesize stopButton = _stopButton;
@synthesize refreshButton = _refreshButton;
@synthesize forwardButton = _forwardButton;
@synthesize leftNavigationButton = _leftNavigationButton;
@synthesize webNavToolBar = _webNavToolBar;

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

- (void)loadSNSWebView
{
    if (self.userSNSInfo != nil) {
        NSString *urlAddress = nil;
        
        if (self.userSNSInfo.userName.length > 0) {
            self.navigationItem.title = self.userSNSInfo.userName;
        }
        
        if (self.userSNSInfo.userId.length > 0) {
            if ([self.userSNSInfo.SNSType isEqualToString:@"tsina"]) {
                DLog(@"UserInfoWebViewController::loadSNSWebView userid: %@", self.userSNSInfo.userId);
                urlAddress = [WEIBO_VIEW_PROFILE_PATH stringByAppendingFormat: self.userSNSInfo.userId];
            } else if ([self.userSNSInfo.SNSType isEqualToString:@"renren"]) {
                
                urlAddress = [RENREN_VIEW_PROFILE_PATH stringByAppendingFormat:self.userSNSInfo.userId];
            }
        }

        if (urlAddress.length > 0) {
            DLog(@"UserInfoWebViewController::loadSNSWebView urlAddress: %@", urlAddress);
            
            //Create a URL object.
            NSURL *url = [NSURL URLWithString:urlAddress];
            
            //URL Requst Object
            NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            
            //Load the request in the UIWebView.
            [self.userInfoWebView loadRequest:requestObj];
        }
    }
}

- (void)updateButtons
{
    self.forwardButton.enabled = self.userInfoWebView.canGoForward;
    self.goBackButton.enabled = self.userInfoWebView.canGoBack;
    self.stopButton.enabled = self.userInfoWebView.loading;
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
    
    [ViewHelper buildBackButton:self.leftNavigationButton];
    [self loadSNSWebView];
}

- (void)viewDidUnload
{
    [self setUserInfoWebView:nil];
    [self setLeftNavigationButton:nil];
    [self setGoBackButton:nil];
    [self setStopButton:nil];
    [self setRefreshButton:nil];
    [self setForwardButton:nil];
    [self setWebNavToolBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)leftNavigationButtonAction:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showLoadingIndicator];
    [self updateButtons];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideIndicator];
    [self updateButtons];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [ViewHelper showErrorAlert:ERROR_MSG_CONNECTION_FAILURE :self];
    [self updateButtons];
}
@end
