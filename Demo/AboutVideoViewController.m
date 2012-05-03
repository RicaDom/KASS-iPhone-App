//
//  AboutVideoViewController.m
//  kass
//
//  Created by zhicai on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutVideoViewController.h"
#import "Constants.h"
#import "ViewHelper.h"

@implementation AboutVideoViewController
@synthesize leftNavigationButton;
@synthesize videoWebView;

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
    
    [ViewHelper buildBackButton:self.leftNavigationButton];
    //NSString *urlAddress = @"http://3g.youku.com/smartphone/video.jsp?vid=XMzgzNTQxNTcy";
            
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:JIEQOO_YOUKU_VIDEO];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [self.videoWebView loadRequest:requestObj];
}

- (void)viewDidUnload
{
    [self setVideoWebView:nil];
    [self setLeftNavigationButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showLoadingIndicator];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideIndicator];
}

- (IBAction)leftNavigationButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
