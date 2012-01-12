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
    // Update the page when more than 50% of the previous/next page is visible
//    CGFloat pageWidth = self.scrollView.frame.size.width;
//    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"Im a");
	//pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"Im e");
	//pageControlBeingUsed = NO;
}

- (IBAction)changeHotPostPage {
    NSLog(@"Im eaction");
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
    
	//pageControlBeingUsed = NO;
	
	NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
	for (int i = 0; i < colors.count; i++) {
		CGRect frame;
		frame.origin.x = self.hotPostScrollView.frame.size.width * i;
		frame.origin.y = 0;
		frame.size = self.hotPostScrollView.frame.size;
		
		UIView *subview = [[UIView alloc] initWithFrame:frame];
		subview.backgroundColor = [colors objectAtIndex:i];
		[self.hotPostScrollView addSubview:subview];
	}
	
	self.hotPostScrollView.contentSize = CGSizeMake(self.hotPostScrollView.frame.size.width * colors.count, self.hotPostScrollView.frame.size.height);
	
	self.hotPostPageControl.currentPage = 0;
	self.hotPostPageControl.numberOfPages = colors.count;
    
    NSLog(@"Self = %@", self);
   // NSLog(@"Current responder = %@", [self.view findFirstResponder]);
}


- (void)viewDidUnload
{
    [self setHotPostScrollView:nil];
    [self setHotPostPageControl:nil];
    [self setHotPostScrollView:nil];
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
