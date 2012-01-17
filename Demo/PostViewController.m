//
//  PostViewController.m
//  Demo
//
//  Created by zhicai on 1/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PostViewController.h"

@implementation PostViewController
@synthesize hotPostScrollView;
@synthesize hotPostPageControl;
@synthesize editorPostScrollView;
@synthesize editorPostPageControl;

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

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    NSLog(@"Im in");
    if (sender == self.hotPostScrollView) {
        if (!hotPostPageControlBeingUsed) {
            // Switch the indicator when more than 50% of the previous/next page is visible
            CGFloat pageWidth = self.hotPostScrollView.frame.size.width;
            int page = floor((self.hotPostScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
            self.hotPostPageControl.currentPage = page;
        }
    } else if (sender == self.editorPostScrollView) {
        if (!editorPostPageControlBeingUsed) {
            // Switch the indicator when more than 50% of the previous/next page is visible
            CGFloat pageWidth = self.editorPostScrollView.frame.size.width;
            int page = floor((self.editorPostScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
            self.editorPostPageControl.currentPage = page;
        }
    }	
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.hotPostScrollView) {
        hotPostPageControlBeingUsed = NO;
    } else if (scrollView == self.editorPostScrollView) {
        editorPostPageControlBeingUsed = NO;
    }	
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.hotPostScrollView) {
        hotPostPageControlBeingUsed = NO;
    } else if (scrollView == self.editorPostScrollView) {
        editorPostPageControlBeingUsed = NO;
    }	
}

- (IBAction)changeEditorPostPage {
    // Update the scroll view to the appropriate page
	CGRect frame;
	frame.origin.x = self.editorPostScrollView.frame.size.width * self.editorPostPageControl.currentPage;
	frame.origin.y = 0;
	frame.size = self.editorPostScrollView.frame.size;
	[self.editorPostScrollView scrollRectToVisible:frame animated:YES];
	
	// Keep track of when scrolls happen in response to the page control
	// value changing. If we don't do this, a noticeable "flashing" occurs
	// as the the scroll delegate will temporarily switch back the page
	// number.
	editorPostPageControlBeingUsed = YES;    
}

- (IBAction)changeHotPostPage {
    // Update the scroll view to the appropriate page
	CGRect frame;
	frame.origin.x = self.hotPostScrollView.frame.size.width * self.hotPostPageControl.currentPage;
	frame.origin.y = 0;
	frame.size = self.hotPostScrollView.frame.size;
	[self.hotPostScrollView scrollRectToVisible:frame animated:YES];
	
	// Keep track of when scrolls happen in response to the page control
	// value changing. If we don't do this, a noticeable "flashing" occurs
	// as the the scroll delegate will temporarily switch back the page
	// number.
	hotPostPageControlBeingUsed = YES;
}

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{
    if ([self isFirstResponder]){
        NSLog(@"Touching first responder");
    } else { 
        NSLog(@"touching... ");
    }
    
    UITouch *touch = [[event allTouches] anyObject];
    
//    UITouch *touch2 = [touches anyObject];
//    CGPoint tapLocation = [touch2 locationInView:self];
//    NSLog(@"Post Location: %@", tapLocation);
    if ([touch view] == hotPostScrollView) {
        NSLog(@"touching... hotPostScrollView...");
        // do stuff here
    }
    // Process the single tap here
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // assign a UITouch object to the current touch
    UITouch *touch = [[event allTouches] anyObject];
     NSLog(@"touching... 1hotPostScrollView...");
    // if the view in which the touch is found is myScrollView
    // (assuming myScrollView is the UIScrollView and is a subview of the UIView)
    if ([touch view] == hotPostScrollView) {
        NSLog(@"touching... hotPostScrollView...");
        // do stuff here
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"hitTest:withEvent called :");
    NSLog(@"Event: %@", event);
    NSLog(@"Point: %@", NSStringFromCGPoint(point));
    NSLog(@"Event Type: %d", event.type);
    NSLog(@"Event SubType: %d", event.subtype);
    NSLog(@"---");
    return nil;
    //return [super hitTest:point withEvent:event];
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{ 
    //CGPoint touchPoint=[gesture locationInView:hotPostScrollView];
    
    [self performSegueWithIdentifier:@"startPostFlowSegue" sender:self];
    NSLog(@"The page is %@", [NSNumber numberWithInt:self.hotPostPageControl.currentPage]);
}

//- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"loadPostSegue"]) {
//       // PostFlowViewController *pvc = [segue destinationViewController];
//        //printf("Select index: %@", self.tabBarItem.title);
//        NSLog(@"Current tab controller: %@", self.tabBarController.viewControllers);
//        //pvc.currentTabBarController = self.tabBarController;
//    }
//}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView
//{
//    //[self performSegueWithIdentifier:@"loadPostSegue" sender:self];
//}

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
    
    // HOT POST EXAMPLES:
	hotPostPageControlBeingUsed = NO;	
//	NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
//	for (int i = 0; i < colors.count; i++) {
//		CGRect frame;
//		frame.origin.x = self.hotPostScrollView.frame.size.width * i;
//		frame.origin.y = 0;
//		frame.size = self.hotPostScrollView.frame.size;
//		
//		UIView *subview = [[UIView alloc] initWithFrame:frame];
//		subview.backgroundColor = [colors objectAtIndex:i];
//		[self.hotPostScrollView addSubview:subview];
//	}
    CGRect frame;
    frame.origin.x = self.hotPostScrollView.frame.size.width * 0;
    frame.origin.y = 0;
    frame.size = self.hotPostScrollView.frame.size;
    
    UIView *subview = [[UIView alloc] initWithFrame:frame];
    subview.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Zaarly_logo3-300x143.png"]];
    [self.hotPostScrollView addSubview:subview];

    frame.origin.x = self.hotPostScrollView.frame.size.width * 1;
    frame.origin.y = 0;
    frame.size = self.hotPostScrollView.frame.size;
    subview = [[UIView alloc] initWithFrame:frame];
    subview.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"martin_luther_king-2012-hp.png"]];
    [self.hotPostScrollView addSubview:subview];    

    frame.origin.x = self.hotPostScrollView.frame.size.width * 2;
    frame.origin.y = 0;
    frame.size = self.hotPostScrollView.frame.size;
    subview = [[UIView alloc] initWithFrame:frame];
    subview.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"images.png"]];
    [self.hotPostScrollView addSubview:subview]; 
    
	self.hotPostScrollView.contentSize = CGSizeMake(self.hotPostScrollView.frame.size.width * 3, self.hotPostScrollView.frame.size.height);
	
	self.hotPostPageControl.currentPage = 0;
	self.hotPostPageControl.numberOfPages = 3;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [hotPostScrollView addGestureRecognizer:singleTap]; 
    
    
    // EDITOR POST EXAMPLES:
	editorPostPageControlBeingUsed = NO;	
    frame.origin.x = self.editorPostScrollView.frame.size.width * 0;
    frame.origin.y = 0;
    frame.size = self.editorPostScrollView.frame.size;
    
    subview = [[UIView alloc] initWithFrame:frame];
    subview.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Zaarly_logo3-300x143.png"]];
    [self.editorPostScrollView addSubview:subview];
    
    frame.origin.x = self.editorPostScrollView.frame.size.width * 1;
    frame.origin.y = 0;
    frame.size = self.editorPostScrollView.frame.size;
    subview = [[UIView alloc] initWithFrame:frame];
    subview.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"martin_luther_king-2012-hp.png"]];
    [self.editorPostScrollView addSubview:subview];    
    
    frame.origin.x = self.editorPostScrollView.frame.size.width * 2;
    frame.origin.y = 0;
    frame.size = self.editorPostScrollView.frame.size;
    subview = [[UIView alloc] initWithFrame:frame];
    subview.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"images.png"]];
    [self.editorPostScrollView addSubview:subview]; 
    
	self.editorPostScrollView.contentSize = CGSizeMake(self.editorPostScrollView.frame.size.width * 3, self.editorPostScrollView.frame.size.height);
	
	self.editorPostPageControl.currentPage = 0;
	self.editorPostPageControl.numberOfPages = 3;
    
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [editorPostScrollView addGestureRecognizer:singleTap];     
    NSLog(@"Self = %@", self);
   // NSLog(@"Current responder = %@", [self.view findFirstResponder]);
}


- (void)viewDidUnload
{
    [self setHotPostScrollView:nil];
    [self setHotPostPageControl:nil];
    [self setHotPostScrollView:nil];
    [self setEditorPostScrollView:nil];
    [self setEditorPostPageControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
