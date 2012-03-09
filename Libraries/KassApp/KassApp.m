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

- (void)getListing:(NSString *)dbId
{
  DLog(@"KassApp::getListing:dbId=%@", dbId);
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getListingFinished:"];
  [ka getListing:dbId];
}

- (void)getListingFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"KassApp::getListingFinished:dict");
  
  if( [_delegate respondsToSelector:@selector(appDidGetListing:)] )
    [_delegate appDidGetListing:dict];
}

- (void)getListingsNearby:(NSMutableDictionary *)dictionary
{
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getListingsNearbyFinished:"];
  [ka getListings:dictionary];
}

- (void)getListingsNearbyFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"KassApp::getListingsNearbyFinished:dict");
  
  if( [_delegate respondsToSelector:@selector(appDidGetListingsNearby:)] )
    [_delegate appDidGetListingsNearby:dict];
}

- (void)getListingsRecent:(NSMutableDictionary *)dictionary
{
  [dictionary setObject:@"ended_at" forKey:@"sort"];
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getListingsRecentFinished:"];
  [ka getListings:dictionary];
}

- (void)getListingsRecentFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"KassApp::getListingsRecentFinished:dict");
  
  if( [_delegate respondsToSelector:@selector(appDidGetListingsRecent:)] )
    [_delegate appDidGetListingsRecent:dict];
}

- (void)getListingsMostPrice:(NSMutableDictionary *)dictionary
{
  [dictionary setObject:@"price" forKey:@"sort"];
  KassApi *ka = [[KassApi alloc]initWithPerformerAndAction:self:@"getListingsMostPriceFinished:"];
  [ka getListings:dictionary];
}

- (void)getListingsMostPriceFinished:(NSData *)data
{
  NSDictionary *dict = [KassApi parseData:data];
  DLog(@"KassApp::getListingsMostPriceFinished:dict");
  
  if( [_delegate respondsToSelector:@selector(appDidGetListingsMostPrice:)] )
    [_delegate appDidGetListingsMostPrice:dict];
}

- (void)requestFailed:(NSDictionary *)errors
{
  DLog(@"KassApp::requestFailed:delegate=%@", _delegate); 
  
  if( [_delegate respondsToSelector:@selector(appRequestFailed:)] )
    [_delegate appRequestFailed:errors];
}


@end
