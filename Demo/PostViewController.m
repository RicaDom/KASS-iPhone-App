//
//  PostViewController.m
//  Demo
//
//  Created by zhicai on 1/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PostViewController.h"
#import "UIResponder+VariableStore.h"

@implementation PostViewController

@synthesize hotPostScrollView = _hotPostScrollView;
@synthesize hotPostPageControl = _hotPostPageControl;
@synthesize editorPostScrollView = _editorPostScrollView;
@synthesize editorPostPageControl = _editorPostPageControl;
@synthesize creativePostScrollView = _creativePostScrollView;
@synthesize creativePostPageControl = _creativePostPageControl;
@synthesize mainScrollView = _mainScrollView;
@synthesize mainView = _mainView;
@synthesize contentView = _contentView;
@synthesize greetingLabel = _greetingLabel;

//@synthesize postTemplates = _postTemplates;
@synthesize popularTemplates = _popularTemplates;
@synthesize editorTemplates = _editorTemplates;
@synthesize creativeTemplates = _creativeTemplates;
@synthesize segueTemplate = _segueTemplate;
@synthesize addPostBackgroundView = _addPostBackgroundView;
@synthesize addPostButton = _addPostButton;
@synthesize addPostSloganLabel = _addPostSloganLabel;

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
    } else if (sender == self.creativePostScrollView) {
        if (!creativePostPageControlBeingUsed) {
            // Switch the indicator when more than 50% of the previous/next page is visible
            CGFloat pageWidth = self.creativePostScrollView.frame.size.width;
            int page = floor((self.creativePostScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
            self.creativePostPageControl.currentPage = page;
        }
    } else if (sender == self.mainScrollView) {
		if (self.mainScrollView.contentOffset.y > (self.mainScrollView.contentSize.height - self.mainScrollView.bounds.size.height - 20)) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.2];
            self.addPostBackgroundView.frame = CGRectMake((self.contentView.frame.size.width - self.addPostBackgroundView.frame.size.width) /2 , self.addPostButton.frame.origin.y - 7, self.addPostBackgroundView.frame.size.width, self.addPostBackgroundView.frame.size.height);
            self.addPostSloganLabel.hidden = NO;
            [UIView commitAnimations];
        } else {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.2];
            self.addPostBackgroundView.frame = CGRectMake(self.addPostButton.frame.origin.x - 5, self.addPostButton.frame.origin.y - 7, self.addPostBackgroundView.frame.size.width, self.addPostBackgroundView.frame.size.height);
            self.addPostSloganLabel.hidden = YES;
            [UIView commitAnimations];
        }
    }	
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.hotPostScrollView) {
        hotPostPageControlBeingUsed = NO;
    } else if (scrollView == self.editorPostScrollView) {
        editorPostPageControlBeingUsed = NO;
    } else if (scrollView == self.creativePostScrollView) {
        creativePostPageControlBeingUsed = NO;
    }
}

- (void)showManagedImageView:(NSMutableArray *)templates:(UIPageControl *)pageControl
{
  PostTemplate *pt = [templates objectAtIndex:pageControl.currentPage];
  [[self kassApp] manageObj:pt.getHJManagedImageView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.hotPostScrollView) {
      hotPostPageControlBeingUsed = NO;
      
      [self showManagedImageView:_popularTemplates:_hotPostPageControl];
      
    } else if (scrollView == self.editorPostScrollView) {
      editorPostPageControlBeingUsed = NO;
      
      [self showManagedImageView:_editorTemplates:_editorPostPageControl];
      
    } else if (scrollView == self.creativePostScrollView) {
      creativePostPageControlBeingUsed = NO;
      
      [self showManagedImageView:_creativeTemplates:_creativePostPageControl];
    }		
}

- (void)updateFrameView:(IBOutlet AppScrollView *)scrollView:(UIPageControl *)pageControl:(BOOL *)controlBeingUsed
{
  // Update the scroll view to the appropriate page
	CGRect frame;
	frame.origin.x = scrollView.frame.size.width * pageControl.currentPage;
	frame.origin.y = 0;
	frame.size = scrollView.frame.size;
	[scrollView scrollRectToVisible:frame animated:YES];
	
	// Keep track of when scrolls happen in response to the page control
	// value changing. If we don't do this, a noticeable "flashing" occurs
	// as the the scroll delegate will temporarily switch back the page
	// number.
	*controlBeingUsed = YES;     
}

- (IBAction)changeCreativePostPage {
  [self updateFrameView:_creativePostScrollView:_creativePostPageControl:&creativePostPageControlBeingUsed];      
}

- (IBAction)changeEditorPostPage {
  [self updateFrameView:_editorPostScrollView:_editorPostPageControl:&editorPostPageControlBeingUsed];    
}

- (IBAction)changeHotPostPage {
  [self updateFrameView:_hotPostScrollView:_hotPostPageControl:&hotPostPageControlBeingUsed]; 
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{ 
    //gesture 
    CGPoint touchPoint=[gesture locationInView:self.hotPostScrollView];
    DLog(@"Hot Point x: %@ , y: %@, frameWidth: %@, frameHeight: %@", 
          [NSNumber numberWithInt:touchPoint.x], 
          [NSNumber numberWithInt:touchPoint.y],
          [NSNumber numberWithInt:self.hotPostScrollView.frame.size.width],
          [NSNumber numberWithInt:self.hotPostScrollView.frame.size.height]);
    self.segueTemplate = [ListItem new];
    
    if( touchPoint.y >= 0 && touchPoint.y <= self.hotPostScrollView.frame.size.height) {
        DLog(@"Popular current page: %d", self.hotPostPageControl.currentPage);        
        if ([self.popularTemplates count] >= self.hotPostPageControl.currentPage) {
            self.segueTemplate = ((PostTemplate *)[self.popularTemplates objectAtIndex:self.hotPostPageControl.currentPage]).listItem;
        }
        
        DLog(@"Segue template title: %@", self.segueTemplate.title);
        
        [self performSegueWithIdentifier:@"TemplatePostWorkFlow" sender:self];
        return;
    }
    
    touchPoint=[gesture locationInView:self.editorPostScrollView];
    
    DLog(@"Editor Point x: %@ , y: %@", [NSNumber numberWithInt:touchPoint.x], [NSNumber numberWithInt:touchPoint.y]);
    DLog(@"The page is %@", [NSNumber numberWithInt:self.hotPostPageControl.currentPage]);
    
    if( touchPoint.y <= self.editorPostScrollView.frame.size.height) {
        DLog(@"Editor current page: %d", self.editorPostPageControl.currentPage);
        if ([self.editorTemplates count] >= self.editorPostPageControl.currentPage) {
            self.segueTemplate = ((PostTemplate *)[self.editorTemplates objectAtIndex:self.editorPostPageControl.currentPage]).listItem;
        }
        
        DLog(@"Segue template title: %@", self.segueTemplate.title);        
        [self performSegueWithIdentifier:@"TemplatePostWorkFlow" sender:self];
        return;
    }
    
    touchPoint=[gesture locationInView:self.creativePostScrollView];
    
    if( touchPoint.y <= self.creativePostScrollView.frame.size.height) {
        DLog(@"Creative current page: %d", self.creativePostPageControl.currentPage);
        if ([self.creativeTemplates count] >= self.creativePostPageControl.currentPage) {
            self.segueTemplate = ((PostTemplate *)[self.creativeTemplates objectAtIndex:self.creativePostPageControl.currentPage]).listItem;
        }
        
        DLog(@"Segue template title: %@", self.segueTemplate.title);        
        [self performSegueWithIdentifier:@"TemplatePostWorkFlow" sender:self];
        return;
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
#pragma mark - TODO
    // hardcode list item info and pass to next view
    if ([segue.identifier isEqualToString:@"TemplatePostWorkFlow"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        PostFlowViewController *pvc = (PostFlowViewController *)navigationController.topViewController;
        //pvc.delegate = self;
        pvc.postType = POST_TYPE_TEMPLATE;
        
        if (self.segueTemplate != nil) {
            [VariableStore sharedInstance].currentPostingItem = self.segueTemplate;
        }

    }
}

// Loading data from server
- (void)loadPostTemplates:(NSDictionary *)dict
{
  NSArray *popularTemplates  = [dict objectForKey:@"popular"];
  NSArray *editorTemplates   = [dict objectForKey:@"editor"];
  NSArray *creativeTemplates = [dict objectForKey:@"creative"];
  
  self.popularTemplates     = [PostTemplate getTemplatesByCategory:popularTemplates:POST_TEMPLATE_CATEGORY_POPULAR];
  self.editorTemplates      = [PostTemplate getTemplatesByCategory:editorTemplates:POST_TEMPLATE_CATEGORY_EDITOR];
  self.creativeTemplates    = [PostTemplate getTemplatesByCategory:creativeTemplates:POST_TEMPLATE_CATEGORY_CREATIVE];
  
  [PostTemplate buildTemplatesView:_hotPostScrollView:_popularTemplates:_hotPostPageControl:&hotPostPageControlBeingUsed];
  [PostTemplate buildTemplatesView:_editorPostScrollView:_editorTemplates:_editorPostPageControl:&editorPostPageControlBeingUsed];
  [PostTemplate buildTemplatesView:_creativePostScrollView:_creativeTemplates:_creativePostPageControl:&creativePostPageControlBeingUsed];
  
  [_hotPostScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)]]; 
  [_editorPostScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)]]; 
  [_creativePostScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)]]; 
  
  [self showManagedImageView:_popularTemplates:_hotPostPageControl];
  [self showManagedImageView:_editorTemplates:_editorPostPageControl];
  [self showManagedImageView:_creativeTemplates:_creativePostPageControl];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadPostTemplates:[self kassVS].postTemplatesDict];
  
    // init scroll view content size
    self.mainScrollView.contentSize = CGSizeMake(_ScrollViewContentSizeX, self.contentView.frame.size.height - self.addPostSloganLabel.frame.size.height/2);   
    self.mainView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Default.png"]];
    
    UIImage *slogan = [UIImage imageNamed:UI_IMAGE_BROWSE_POST_SLOGAN];
    self.addPostBackgroundView.frame = CGRectMake(self.addPostButton.frame.origin.x - 5, self.addPostButton.frame.origin.y - 7, slogan.size.width, slogan.size.height);
    self.addPostBackgroundView.backgroundColor = [[UIColor alloc] initWithPatternImage:slogan];
    self.addPostSloganLabel.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([[VariableStore sharedInstance] isLoggedIn]) {
        self.greetingLabel.text = [@"Hey " stringByAppendingFormat:[VariableStore sharedInstance].user.name];
    } else {
        self.greetingLabel.text = @"Hey there!";
    }
}


- (void)viewDidUnload
{
    [self setHotPostScrollView:nil];
    [self setHotPostPageControl:nil];
    [self setHotPostScrollView:nil];
    [self setEditorPostScrollView:nil];
    [self setEditorPostPageControl:nil];
    [self setMainScrollView:nil];
    [self setMainView:nil];
    [self setContentView:nil];
    [self setGreetingLabel:nil];
    [self setCreativePostScrollView:nil];
    [self setCreativePostPageControl:nil];
    [self setAddPostBackgroundView:nil];
    [self setAddPostButton:nil];
    [self setAddPostSloganLabel:nil];
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
