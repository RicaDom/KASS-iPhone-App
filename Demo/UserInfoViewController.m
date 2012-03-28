//
//  UserInfoViewController.m
//  Demo
//
//  Created by Wesley Wang on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UIViewController+ActivityIndicate.h"
#import "UIResponder+VariableStore.h"
#import "VariableStore.h"
#import "ViewHelper.h"
#import "UIView+Subviews.h"

@implementation UserInfoViewController

@synthesize imageContainerView;
@synthesize nameLabel = _nameLabel;
@synthesize userId = _userId;
@synthesize contentView = _contentView;
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

- (NSString *)getHDWeiboImage:(NSString *)url
{
  //tp4.sinaimg.cn/1876646123/50/5615566644/1
  
  NSRange range = [url rangeOfString:@"/50/"];
  
  if (range.location != NSNotFound) {
    url = [url stringByReplacingCharactersInRange:range withString:@"/180/"];
  }
  
  return url;
}

- (void)loadUserImage:(NSString *)imgUrl
{
  if (imgUrl && imgUrl.isPresent) {
    if ( hjManagedImageView ) { hjManagedImageView = nil; }
    hjManagedImageView = [[HJManagedImageV alloc] initWithFrame:CGRectMake(70, 0, 180, 180)];
    hjManagedImageView.url = [NSURL URLWithString:[self getHDWeiboImage:imgUrl]];
    [hjManagedImageView showLoadingWheel];
    hjManagedImageView.layer.cornerRadius = 5;
    hjManagedImageView.layer.masksToBounds = YES;
    hjManagedImageView.tag = USER_AVATAR_VIEW_TAG;
    [imageContainerView addSubview:hjManagedImageView];
    [VariableStore.sharedInstance.kassApp manageObj:hjManagedImageView];
  }else {
    UIImage *userImg = [UIImage imageNamed:UI_IMAGE_DEFAULT_USER];
    UIImageView *userImgView = [[UIImageView alloc] initWithImage:userImg];
    userImgView.frame = CGRectMake(0, 0, 320, 205);
    userImgView.tag = USER_AVATAR_VIEW_TAG;
    [imageContainerView addSubview:userImgView];
  }
}

- (UIView *)getIconView:(NSString *)iconUrl:(int)offset
{
  UIImage *img = [UIImage imageNamed:iconUrl];
  UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
  imgView.frame = CGRectMake(50 + offset, 10, 25, 25);
  imgView.tag   = USER_INFO_ICON_TAG;
  [_contentView addSubview:imgView];
  return imgView;
}

- (void)buildIconView:(NSString *)iconUrl:(int)offset
{
  UIImage *img = [UIImage imageNamed:iconUrl];
  UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
  imgView.frame = CGRectMake(50 + offset, 10, 25, 25);
  imgView.tag   = USER_INFO_ICON_TAG;
  [_contentView addSubview:imgView];
}

- (void)appDidGetMember:(NSDictionary *)dict
{
  DLog(@"UserinfoViewController::appDidGetMember:dict=%@", dict);
  //{"id":"4f347bf1a912091e87000001","verification":{"sources":[{"type":"email","verified":false},{"type":"tsina","verified":true,"timg_url":"http://tp4.sinaimg.cn/1876646123/50/5615566644/1"}],"member_since":"2012-02-10T10:07:46+08:00"}}
  
  NSString *name = [dict objectForKey:@"name"];
  NSString *uId  = [dict objectForKey:@"id"];
   
  self.nameLabel.text = name.isBlank ? uId : name;
  
  NSDictionary *veri = [dict objectForKey:@"verification"];
  
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:RUBY_DATETIME_FORMAT]; //2012-02-17T07:50:16+0000 
  NSDate *date = [dateFormat dateFromString:[veri objectForKey:@"member_since"]];
  
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setAMSymbol:@"AM"];
  [formatter setPMSymbol:@"PM"];
  [formatter setDateFormat:@"MM/dd/yy hh:mm a"];
  self.regDate.text = [NSString stringWithFormat:@"注册时间: %@", [formatter stringFromDate:date]];
  
  NSArray *sources = [veri objectForKey:@"sources"];
  
  for (NSDictionary *source in sources) {
    if (!source || ![source isKindOfClass:NSDictionary.class]) { continue; }
    
    NSString *type = [source objectForKey:@"type"];
    if ([type isEqualToString:@"email"]) {
      
      NSString *emailV = [NSString stringWithFormat:@"%@",[source objectForKey:@"verified"]];
      _emailVerified = [emailV isEqualToString:@"1"];
      
    }else if ([type isEqualToString:@"tsina"]) {
      
      NSString *weiboV = [NSString stringWithFormat:@"%@",[source objectForKey:@"verified"]];
      _weiboVerified = [weiboV isEqualToString:@"1"];
    } else if ([type isEqualToString:@"phone"]) {
      
      NSString *phoneV = [NSString stringWithFormat:@"%@",[source objectForKey:@"verified"]];
      _phoneVerified = [phoneV isEqualToString:@"1"];
      _phone_number  = [source objectForKey:@"phone"];
      
    }
  }
  
  if ( hjManagedImageView && self.userId && [self.userId isEqualToString:uId]) {

  }else {
    [self loadUserImage:[dict objectForKey:@"timg_url"]];
  }
  
  [_contentView removeViewsWithTag:USER_INFO_ICON_TAG];
  
  if (_emailVerified) {
    [self buildIconView:@"veri-email-on.png":0];
  }else{
    [self buildIconView:@"veri-email-off.png":0];
  }
  
  if (_weiboVerified) {
    [self buildIconView:@"veri-weibo-on.png":30];
  }else{
    [self buildIconView:@"veri-weibo-off.png":30];
  }
  
  if (_phoneVerified) {
    UIView *view = [self getIconView:@"veri-phone-on.png":60];
    [_contentView addGestureRecognizer:singleFingerTap];
  }else{
    [self buildIconView:@"veri-phone-off.png":60];
  }
  
  self.userId = uId;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  NSString *uId = VariableStore.sharedInstance.userToShowId ? VariableStore.sharedInstance.userToShowId : VariableStore.sharedInstance.user.userId;
  
  if (uId) { [[self kassApp] getMember:uId]; }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    _weiboVerified = FALSE;
    _emailVerified = FALSE;
    _phoneVerified = FALSE;
    [ViewHelper buildBackButton:self.leftButton];
  
  singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
  
}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
  CGPoint location = [recognizer locationInView:recognizer.view];
  
  if (location.x > 125.5 && location.x < 146.0 && location.y > 13.0 && location.y < 30.0) {
    if (_phoneVerified && _phone_number) {
      NSString *call_phone_number = [[NSString alloc] initWithFormat:@"tel:%@",_phone_number];
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:call_phone_number]];
    }
  }

}

- (void)viewDidUnload
{
  [self setImageContainerView:nil];
    [self setLeftButton:nil];
  [self setContentView:nil];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  imageContainerView.frame = CGRectMake(0, -scrollView.contentOffset.y/10, 320, 205);
}

@end
