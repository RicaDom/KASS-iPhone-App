//
//  AboutViewController.m
//  kass
//
//  Created by Wesley Wang on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"
#import "ViewHelper.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation AboutViewController

@synthesize aboutArray = _aboutArray;
@synthesize leftButton = _leftButton;

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

- (void)loadTableData
{
    self.aboutArray = [NSArray arrayWithObjects:@"街区视频", @"如何玩转街区", @"街区A&Q", @"评价街区", @"关注街区微博", @"关于我们",nil] ;
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
    [self loadTableData];
    [ViewHelper buildBackButton:self.leftButton];
}

- (void)viewDidUnload
{
    [self setLeftButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	/*
	 If the requesting table view is the search display controller's table view, return the count of
     the filtered list, otherwise return the count of the main list.
	 */
    return self.aboutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"AboutTableCell";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //set cell using data
    cell.textLabel.text = [self.aboutArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:DEFAULT_FONT size:14];
    return cell;     
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableCellString = [self.aboutArray objectAtIndex:indexPath.row];
    if ([tableCellString isEqualToString:@"如何玩转街区"]) {
        singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self.tabBarController action:@selector(handleSingleTap:)];
        closeFingerTap  = [[UITapGestureRecognizer alloc] initWithTarget:self.tabBarController action:@selector(handleCloseTap:)];
        
        [ViewHelper showIntroView:self.tabBarController.view:singleFingerTap:closeFingerTap];
    } else if ([tableCellString isEqualToString:@"街区视频"]) {
        [self performSegueWithIdentifier:@"AboutToVideoSegue" sender:self];
//        
//        NSBundle *bundle = [NSBundle mainBundle];
//        NSString *moviePath = [bundle pathForResource:@"Movie-1" ofType:@"m4v"];
//        NSURL *url = [NSURL fileURLWithPath:moviePath];
//         
//        MPMoviePlayerController *moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];  
//        
//        [moviePlayer.view setFrame:CGRectMake(145, 20, 155, 100)];
//        [self.view addSubview:moviePlayer.view];
//        
//        // Register to receive a notification when the movie has finished playing.  
//        [[NSNotificationCenter defaultCenter] addObserver:self  
//                                                 selector:@selector(moviePlayBackDidFinish:)  
//                                                     name:MPMoviePlayerPlaybackDidFinishNotification  
//                                                   object:moviePlayer];  
//        [moviePlayer setFullscreen:YES];
//        [moviePlayer play];
        
    } else {
        [self performSegueWithIdentifier:@"AboutToAllSegue" sender:self];
    }
}
- (IBAction)leftButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:recognizer.view];
    
    if (location.x > 19.0 && location.x < 156.0 && location.y > 625.0 && location.y < 675.0) {
        [ViewHelper hideIntroView:self.tabBarController.view];
    }
    
}

@end
