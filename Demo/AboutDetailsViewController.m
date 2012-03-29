//
//  AboutDetailsViewController.m
//  kass
//
//  Created by Wesley Wang on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutDetailsViewController.h"
#import "ViewHelper.h"
#import "HJManagedImageV.h"
#import "UIResponder+VariableStore.h"
#import "UIView+Subviews.h"

@implementation AboutDetailsViewController
@synthesize contentView;
@synthesize mainView;
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
  
  //load settings
  if ( [self kassVS].settings.siteDict ) {
    NSDictionary *aboutDict = [[self kassVS].settings.siteDict objectForKey:@"about"];
    NSDictionary *introDict = [aboutDict objectForKey:@"intro"];
    
    NSString *imgUrl   = [introDict objectForKey:@"image"];
    NSInteger height   = [[introDict objectForKey:@"height"] intValue];
   
    if (imgUrl.isPresent) {
      CGRect frame = CGRectMake(0, 0, 320, height);
      HJManagedImageV *imgV = [[HJManagedImageV alloc] initWithFrame:frame]; 
      imgV.url = [NSURL URLWithString: imgUrl];
      imgV.tag = INTRO_IMAGE_TAG;
      [imgV showLoadingWheel];
      [self.mainView removeViewsWithTag:INTRO_IMAGE_TAG];
      
      self.contentView.contentSize = CGSizeMake(320, height);
      
      self.mainView.frame = frame;
      [self.mainView addSubview:imgV];
      [[self kassApp] manageObj:imgV];
    }
  }
}

- (void)viewDidUnload
{
    [self setLeftButton:nil];
    [self setContentView:nil];
  [self setMainView:nil];
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
    [self.navigationController popViewControllerAnimated:YES];
}
@end
