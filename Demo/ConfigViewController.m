//
//  ConfigViewController.m
//  kass
//
//  Created by Wesley Wang on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConfigViewController.h"
#import "ViewHelper.h"

@implementation ConfigViewController
@synthesize pushNotificationSwitch;
@synthesize leftButton;

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
    [ViewHelper buildBackButton:self.leftButton];
}

- (void)viewDidUnload
{
    [self setLeftButton:nil];
    [self setPushNotificationSwitch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)leftButtonAction:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)pushNotificationAction:(id)sender {
    if (self.pushNotificationSwitch.on) {
        UIApplication* application = [UIApplication sharedApplication];
        NSArray* scheduledNotifications = [NSArray arrayWithArray:application.scheduledLocalNotifications];
        application.scheduledLocalNotifications = scheduledNotifications;
    } else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}
@end
