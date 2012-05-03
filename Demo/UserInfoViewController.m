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
#import "UserInfoWebViewController.h"

@implementation UserInfoViewController

@synthesize imageContainerView;
@synthesize nameLabel = _nameLabel;
@synthesize userId = _userId;
@synthesize contentView = _contentView;
@synthesize regDate = _regDate;
@synthesize leftButton = _leftButton;
@synthesize userSNSInfo = _userSNSInfo;

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
  imgView.frame = CGRectMake(50 + offset, 10, 50, 50);
  imgView.tag   = USER_INFO_ICON_TAG;
  [_contentView addSubview:imgView];
  return imgView;
}

- (void)buildIconView:(NSString *)iconUrl:(int)offset
{
  UIImage *img = [UIImage imageNamed:iconUrl];
  UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
  imgView.frame = CGRectMake(50 + offset, 10, 50, 50);
    
    //DLog(@"origin x: %f", imgView.frame.origin.x);
    DLog(@"%f , %f , %f , %f  ", imgView.frame.origin.x, imgView.frame.origin.y, imgView.frame.size.height, imgView.frame.size.width);
  imgView.tag   = USER_INFO_ICON_TAG;
  [_contentView addSubview:imgView];
}

- (void)appDidGetMember:(NSDictionary *)dict
{
  DLog(@"UserinfoViewController::appDidGetMember:dict=%@", dict);
  //{"id":"4f347bf1a912091e87000001","verification":{"sources":[{"type":"email","verified":false},{"type":"tsina","verified":true,"timg_url":"http://tp4.sinaimg.cn/1876646123/50/5615566644/1"}],"member_since":"2012-02-10T10:07:46+08:00"}}
  
  _name = [dict objectForKey:@"name"];
  NSString *uId  = [dict objectForKey:@"id"];
   
  self.nameLabel.text = _name.isBlank ? uId : _name;
  
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
      _email_address = [NSString stringWithFormat:@"%@",[source objectForKey:@"email"]];
      
    }else if ([type isEqualToString:@"tsina"]) {
      
      NSString *weiboV = [NSString stringWithFormat:@"%@",[source objectForKey:@"verified"]];
      _weiboVerified = [weiboV isEqualToString:@"1"];
      _weibo_id = [NSString stringWithFormat:@"%@",[source objectForKey:@"uid"]];
    }else if ([type isEqualToString:@"renren"]) {
      
      NSString *renrenV = [NSString stringWithFormat:@"%@",[source objectForKey:@"verified"]];
      _renrenVerified = [renrenV isEqualToString:@"1"];
      _renren_id = [NSString stringWithFormat:@"%@",[source objectForKey:@"uid"]];
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
    [self buildIconView:@"veri-weibo-on.png":55];
  }else{
    [self buildIconView:@"veri-weibo-off.png":55];
  }
  
  if (_renrenVerified) {
    [self buildIconView:@"veri-renren-on.png":110];
  }else{
    [self buildIconView:@"veri-renren-off.png":110];
  }
  
  if (_phoneVerified) {
    [self buildIconView:@"veri-phone-on.png":165];
//    if ( ![[self currentUser] isSameUser:_userId] ) {
//      [_contentView addGestureRecognizer:singleFingerTap];
//    }
  }else{
    [self buildIconView:@"veri-phone-off.png":165];
  }
    
  if (_emailVerified || _weiboVerified || _renrenVerified || _phoneVerified) {
    [_contentView addGestureRecognizer:singleFingerTap];
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
  
  if (location.x > 215 && location.x < 265 && location.y > 10 && location.y < 60) {
    DLog(@"Pressing phone...");
    if (_phoneVerified && _phone_number && ![[self currentUser] isSameUser:_userId]) {
      
      NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [VariableStore.sharedInstance.itemClassAndIdToShow objectAtIndex:0], @"class",
                            [VariableStore.sharedInstance.itemClassAndIdToShow objectAtIndex:1], @"dbId", 
                            self.currentUser.userId, @"callerId",
                            _userId, @"calleeId", nil];
      
      [self.currentUser createStatusCall:dict];
      
      NSString *call_phone_number = [[NSString alloc] initWithFormat:@"tel:%@",_phone_number];
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:call_phone_number]];
    }
  } else if (location.x > 105 && location.x < 155 && location.y > 10 && location.y < 60) {
      DLog(@"Pressing weibo...");
      if(_weibo_id.length > 0 && _weiboVerified) {
          self.userSNSInfo = [UserSNSInfo new];
          self.userSNSInfo.userId = _weibo_id;
          self.userSNSInfo.userName = _name;
          self.userSNSInfo.SNSType = @"tsina";
          [self performSegueWithIdentifier:@"userInfoToUserInfoWebView" sender:self];
      }
  } else if (location.x > 160 && location.x < 210 && location.y > 10 && location.y < 60) {
      DLog(@"Pressing renren...");
      if(_renren_id.length > 0 && _renrenVerified) {
          self.userSNSInfo = [UserSNSInfo new];
          self.userSNSInfo.userId = _renren_id;
          self.userSNSInfo.userName = _name;
          self.userSNSInfo.SNSType = @"renren";
          [self performSegueWithIdentifier:@"userInfoToUserInfoWebView" sender:self];
      }
  } else if (location.x > 50 && location.x < 100 && location.y > 10 && location.y < 60) {
      DLog(@"Pressing email...");
      if (_email_address.length > 0 && _emailVerified) {
          NSString *mailString = [NSString stringWithFormat:@"mailto:%@",
                                  _email_address];
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailString]];
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"userInfoToUserInfoWebView"]) {
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        
        if ([nc.topViewController isKindOfClass:[UserInfoWebViewController class]]) {
            UserInfoWebViewController *uv = (UserInfoWebViewController *)nc.topViewController;
            uv.userSNSInfo = self.userSNSInfo;
        }
    }
}

@end
