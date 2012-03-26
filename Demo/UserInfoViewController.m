//
//  UserInfoViewController.m
//  Demo
//
//  Created by Wesley Wang on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UIViewController+ActivityIndicate.h"
#import "VariableStore.h"
#import "ViewHelper.h"

@implementation UserInfoViewController

@synthesize imageContainerView;
@synthesize nameLabel = _nameLabel;
@synthesize userId = _userId;
@synthesize regDate = _regDate;
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

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)loadUserImage:(NSString *)imgUrl
{
  CGRect frame = CGRectMake(0, 0, 50, 50);
  
  if (imgUrl && imgUrl.isPresent) {
    if ( hjManagedImageView ) { hjManagedImageView = nil; }
    hjManagedImageView = [[HJManagedImageV alloc] initWithFrame:frame];
    hjManagedImageView.url = [NSURL URLWithString:imgUrl];
    [hjManagedImageView showLoadingWheel];
    [imageContainerView addSubview:hjManagedImageView];
  }else {
    UIImage *userImg = [UIImage imageNamed:UI_IMAGE_MESSAGE_DEFAULT_USER];
    UIImageView *userImgView = [[UIImageView alloc] initWithImage:userImg];
    userImgView.frame = frame;
    [imageContainerView addSubview:userImgView];
  }
}

- (void)appDidGetMember:(NSDictionary *)dict
{
  DLog(@"UserinfoViewController::appDidGetMember:dict=%@", dict);
  //{"id":"4f347bf1a912091e87000001","verification":{"sources":[{"type":"email","verified":false},{"type":"tsina","verified":true,"timg_url":"http://tp4.sinaimg.cn/1876646123/50/5615566644/1"}],"member_since":"2012-02-10T10:07:46+08:00"}}
  
  NSString *uId = [dict objectForKey:@"id"];
  
  self.nameLabel.text = uId;
  
  NSDictionary *veri = [dict objectForKey:@"verification"];
  
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:RUBY_DATETIME_FORMAT]; //2012-02-17T07:50:16+0000 
  NSDate *date = [dateFormat dateFromString:[veri objectForKey:@"member_since"]];
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setAMSymbol:@"AM"];
  [formatter setPMSymbol:@"PM"];
  [formatter setDateFormat:@"MM/dd/yy hh:mm a"];
  self.regDate.text = [NSString stringWithFormat:@"注册时间: %@", [formatter stringFromDate:date]];
  
  if ( hjManagedImageView && self.userId && [self.userId isEqualToString:uId]) {

  }else {
    [self loadUserImage:[dict objectForKey:@"timg_url"]];
  }
  
  self.userId = uId;
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  NSString *uId = VariableStore.sharedInstance.userToShowId ? VariableStore.sharedInstance.userToShowId : VariableStore.sharedInstance.user.userId;
  
  if (uId) { [[VariableStore.sharedInstance kassApp] getMember:uId]; }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [ViewHelper buildBackButton:self.leftButton];
}

- (void)viewDidUnload
{
  [self setImageContainerView:nil];
    [self setLeftButton:nil];
    [super viewDidUnload];
  self.nameLabel = nil;
  self.regDate   = nil;
  self.userId    = nil;
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
