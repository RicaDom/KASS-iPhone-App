//
//  PostViewController.m
//  Demo
//
//  Created by zhicai on 1/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PostViewController.h"

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

@synthesize postTemplates = _postTemplates;
@synthesize popularTemplates = _popularTemplates;
@synthesize editorTemplates = _editorTemplates;
@synthesize creativeTemplates = _creativeTemplates;
@synthesize segueTemplate = _segueTemplate;

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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.hotPostScrollView) {
        hotPostPageControlBeingUsed = NO;
    } else if (scrollView == self.editorPostScrollView) {
        editorPostPageControlBeingUsed = NO;
    } else if (scrollView == self.creativePostScrollView) {
        creativePostPageControlBeingUsed = NO;
    }		
}

- (IBAction)changeCreativePostPage {
    // Update the scroll view to the appropriate page
	CGRect frame;
	frame.origin.x = self.creativePostScrollView.frame.size.width * self.creativePostPageControl.currentPage;
	frame.origin.y = 0;
	frame.size = self.creativePostScrollView.frame.size;
	[self.creativePostScrollView scrollRectToVisible:frame animated:YES];
	
	// Keep track of when scrolls happen in response to the page control
	// value changing. If we don't do this, a noticeable "flashing" occurs
	// as the the scroll delegate will temporarily switch back the page
	// number.
	creativePostPageControlBeingUsed = YES;        
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
- (void)postTemplatesDataLoad
{
    self.postTemplates = [NSMutableArray new];
    
    PostTemplate *temp = [PostTemplate new];
    temp.dbId = @"abc1";
    temp.category = POST_TEMPLATE_CATEGORY_POPULAR;
    temp.picPath = @"Zaarly_logo3-300x143.png";
    
    ListItem *item = [ListItem new];
    item.title = @"Popular post item title1";
    item.description = @"Popular post item description1";
    item.askPrice = [NSDecimalNumber decimalNumberWithString:@"888.99"];
    item.postDuration = [NSNumber numberWithInt:7200];
    
    temp.listItem = item;
    
    [self.postTemplates addObject:temp];
    
    //////////////////////////////////////
    temp = [PostTemplate new];
    temp.dbId = @"abc2";
    temp.category = POST_TEMPLATE_CATEGORY_POPULAR;
    temp.picPath = @"martin_luther_king-2012-hp.png";
    
    item = [ListItem new];
    item.title = @"Popular post item title2";
    item.description = @"Popular post item description2";
    item.askPrice = [NSDecimalNumber decimalNumberWithString:@"888.99"];
    item.postDuration = [NSNumber numberWithInt:7200];
    
    temp.listItem = item;

    [self.postTemplates addObject:temp];
    
    //////////////////////////////////////
    temp = [PostTemplate new];
    temp.dbId = @"abc3";
    temp.category = POST_TEMPLATE_CATEGORY_POPULAR;
    temp.picPath = @"images.png";
    
    item = [ListItem new];
    item.title = @"Popular post item title3";
    item.description = @"Popular post item description3";
    item.askPrice = [NSDecimalNumber decimalNumberWithString:@"888.99"];
    item.postDuration = [NSNumber numberWithInt:7200];
    
    temp.listItem = item;

    [self.postTemplates addObject:temp];
    
    /* Editor examples */
    temp = [PostTemplate new];
    temp.dbId = @"Editorabc1";
    temp.category = POST_TEMPLATE_CATEGORY_EDITOR;
    temp.picPath = @"Zaarly_logo3-300x143.png";
    
    item = [ListItem new];
    item.title = @"Editor post item title1";
    item.description = @"Editor post item description1";
    item.askPrice = [NSDecimalNumber decimalNumberWithString:@"888.99"];
    item.postDuration = [NSNumber numberWithInt:7200];
    
    temp.listItem = item;
    
    [self.postTemplates addObject:temp];
    
    //////////////////////////////////////
    temp = [PostTemplate new];
    temp.dbId = @"Editorabc2";
    temp.category = POST_TEMPLATE_CATEGORY_EDITOR;
    temp.picPath = @"martin_luther_king-2012-hp.png";
    
    item = [ListItem new];
    item.title = @"Editor post item title2";
    item.description = @"Editor post item description2";
    item.askPrice = [NSDecimalNumber decimalNumberWithString:@"888.99"];
    item.postDuration = [NSNumber numberWithInt:7200];
    
    temp.listItem = item;
    
    [self.postTemplates addObject:temp];
    
    //////////////////////////////////////
    temp = [PostTemplate new];
    temp.dbId = @"Editorabc3";
    temp.category = POST_TEMPLATE_CATEGORY_EDITOR;
    temp.picPath = @"images.png";
    
    item = [ListItem new];
    item.title = @"Editor post item title3";
    item.description = @"Editor post item description3";
    item.askPrice = [NSDecimalNumber decimalNumberWithString:@"888.99"];
    item.postDuration = [NSNumber numberWithInt:7200];
    
    temp.listItem = item;
    
    [self.postTemplates addObject:temp];

    /* Creative examples */
    temp = [PostTemplate new];
    temp.dbId = @"Creativeabc1";
    temp.category = POST_TEMPLATE_CATEGORY_CREATIVE;
    temp.picPath = @"Zaarly_logo3-300x143.png";
    
    item = [ListItem new];
    item.title = @"Creative post item title1";
    item.description = @"Creative post item description1";
    item.askPrice = [NSDecimalNumber decimalNumberWithString:@"888.99"];
    item.postDuration = [NSNumber numberWithInt:7200];
    
    temp.listItem = item;
    
    [self.postTemplates addObject:temp];
    
    //////////////////////////////////////
    temp = [PostTemplate new];
    temp.dbId = @"Creativeabc2";
    temp.category = POST_TEMPLATE_CATEGORY_CREATIVE;
    temp.picPath = @"martin_luther_king-2012-hp.png";
    
    item = [ListItem new];
    item.title = @"Creative post item title2";
    item.description = @"Creative post item description2";
    item.askPrice = [NSDecimalNumber decimalNumberWithString:@"888.99"];
    item.postDuration = [NSNumber numberWithInt:7200];
    
    temp.listItem = item;
    
    [self.postTemplates addObject:temp];
    
    //////////////////////////////////////
    temp = [PostTemplate new];
    temp.dbId = @"Creativeabc3";
    temp.category = POST_TEMPLATE_CATEGORY_CREATIVE;
    temp.picPath = @"images.png";
    
    item = [ListItem new];
    item.title = @"Creative post item title3";
    item.description = @"Creative post item description3";
    item.askPrice = [NSDecimalNumber decimalNumberWithString:@"888.99"];
    item.postDuration = [NSNumber numberWithInt:7200];
    
    temp.listItem = item;
    
    [self.postTemplates addObject:temp];
}

- (void)postTemplatesViewLoad
{
    if ([self.postTemplates count] > 0) {
        int popularCounter = 0;
        int editorCounter = 0;
        int creativeCounter = 0;
        self.popularTemplates = [NSMutableArray new];
        self.editorTemplates = [NSMutableArray new];
        self.creativeTemplates = [NSMutableArray new];
        
        for (PostTemplate *temp in self.postTemplates) {
            CGRect frame;
            frame.origin.y = 0;
            
            if ([temp.category isEqualToString:POST_TEMPLATE_CATEGORY_POPULAR]) {
                // Popular Post Template
                frame.origin.x = self.hotPostScrollView.frame.size.width * popularCounter;
                frame.size = self.hotPostScrollView.frame.size;
                
                popularCounter++;
                
                UIView *subview = [[UIView alloc] initWithFrame:frame];
                subview.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:temp.picPath]];
                [self.hotPostScrollView addSubview:subview];                                
                self.hotPostScrollView.contentSize = CGSizeMake(self.hotPostScrollView.frame.size.width * popularCounter, self.hotPostScrollView.frame.size.height);
                 
                [self.popularTemplates addObject:temp];
                
            } else if ([temp.category isEqualToString:POST_TEMPLATE_CATEGORY_EDITOR]) {
                // Editor Post Template
                frame.origin.x = self.editorPostScrollView.frame.size.width * editorCounter;
                frame.size = self.editorPostScrollView.frame.size;
                
                editorCounter++;
                
                UIView *subview = [[UIView alloc] initWithFrame:frame];
                subview.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:temp.picPath]];
                [self.editorPostScrollView addSubview:subview];                                
                self.editorPostScrollView.contentSize = CGSizeMake(self.editorPostScrollView.frame.size.width * editorCounter, self.editorPostScrollView.frame.size.height);
                
                [self.editorTemplates addObject:temp];
                
            } else if ([temp.category isEqualToString:POST_TEMPLATE_CATEGORY_CREATIVE]) {
                // Creative Post Template
                frame.origin.x = self.creativePostScrollView.frame.size.width * creativeCounter;
                frame.size = self.creativePostScrollView.frame.size;
                
                creativeCounter++;
                
                UIView *subview = [[UIView alloc] initWithFrame:frame];
                subview.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:temp.picPath]];
                [self.creativePostScrollView addSubview:subview];                                
                self.creativePostScrollView.contentSize = CGSizeMake(self.creativePostScrollView.frame.size.width * creativeCounter, self.creativePostScrollView.frame.size.height);    
                
                [self.creativeTemplates addObject:temp];
            }
        }
        
        hotPostPageControlBeingUsed = NO;
        self.hotPostPageControl.currentPage = 0;
        self.hotPostPageControl.numberOfPages = popularCounter;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
        [self.hotPostScrollView addGestureRecognizer:singleTap];   
        
        editorPostPageControlBeingUsed = NO;
        self.editorPostPageControl.currentPage = 0;
        self.editorPostPageControl.numberOfPages = editorCounter;
        singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
        [self.editorPostScrollView addGestureRecognizer:singleTap]; 
        
        creativePostPageControlBeingUsed = NO;
        self.creativePostPageControl.currentPage = 0;
        self.creativePostPageControl.numberOfPages = creativeCounter;
        singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
        [self.creativePostScrollView addGestureRecognizer:singleTap]; 
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self postTemplatesDataLoad];
    [self postTemplatesViewLoad];
    
    // init scroll view content size
    self.mainScrollView.contentSize = CGSizeMake(_ScrollViewContentSizeX, 600);

    // self.mainScrollView.contentInset = UIEdgeInsetsMake(150, 0, 0, 0);    
    self.mainView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Default.png"]];
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
