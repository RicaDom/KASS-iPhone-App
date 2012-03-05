//
//  KassApp.m
//  Demo
//
//  Created by Qi He on 12-3-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KassApp.h"
#import "KassApi.h"

@implementation KassApp

@synthesize delegate = _delegate;
@synthesize kaObjManager = _kaObjManager;

- (id)initWithDelegate:(id<KassAppDelegate>)delegate
{
	if (self = [super init]) {
		_delegate     = delegate;
    _kaObjManager = KassAppObjManager.sharedInstance;
	}
	return self;
}

- (id)init
{
  if (self = [super init]) {
    _kaObjManager = KassAppObjManager.sharedInstance;
  }
  return self;
}

- (void)loadSettings
{
  DLog(@"Settings::loadSettings");
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"loadSettingsFinished:"];
  [ka loadSettings];
}

- (void)loadAndStoreSettings
{
  DLog(@"KassApp::loadAndStoreSettings");
  NSData *data = [KassApi loadSettings];
  [_delegate settingsDidLoad:[KassApi parseData:data]];
}

- (void)loadSettingsFinished:(NSData *)data
{
  if( [_delegate respondsToSelector:@selector(settingsDidLoad:)] )
    [_delegate settingsDidLoad:[KassApi parseData:data]];
}

- (BOOL)manageObj:(id<HJMOUser>)user
{
  return [_kaObjManager manage:user];
}

@end
