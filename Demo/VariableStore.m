//
//  VariableStore.m
//  Demo
//
//  Created by zhicai on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VariableStore.h"

@implementation VariableStore 

@synthesize currentPostingItem = _currentPostingItem;
@synthesize expiredTime = _expiredTime;
@synthesize durationToServerDic = _durationToServerDic;
@synthesize postTemplatesDict = _postTemplatesDict;

@synthesize allListings = _allListings;
@synthesize myBuyingListings = _myBuyingListings;
@synthesize mySellingListings = _mySellingListings;
@synthesize user = _user;
@synthesize locateMeManager = _locateMeManager;

@synthesize recentBrowseListings = _recentBrowseListings;
@synthesize nearBrowseListings = _nearBrowseListings;
@synthesize priceBrowseListings = _priceBrowseListings;

@synthesize modelDict = _modelDict;
@synthesize mainTabBar = _mainTabBar;

@synthesize currentViewControllerDelegate = _currentViewControllerDelegate;

+ (VariableStore *) sharedInstance {
    // the instance of this class is stored here
    static VariableStore *myInstance;
    
    @synchronized(self){
        // check to see if an instance already exists
        if (nil == myInstance) {
            myInstance  = [[[self class] alloc] init];
            // initialize variables here
            myInstance.currentPostingItem = [[ListItem alloc] init];
            
            myInstance.allListings = [[NSMutableArray alloc] init];
            myInstance.mySellingListings = [[NSMutableArray alloc] init];
            myInstance.myBuyingListings = [[NSMutableArray alloc] init];
          
            myInstance.user = [[User alloc] init];
            myInstance.locateMeManager = [[LocateMeManager alloc] init];
          
            myInstance.modelDict = [[NSMutableDictionary alloc] init];
          
            myInstance.durationToServerDic = [[NSMutableDictionary alloc] init];
            myInstance.expiredTime = [[NSMutableDictionary alloc] init];
            
//            myInstance.recentBrowseListings = [[NSMutableArray alloc] init];
//            myInstance.nearBrowseListings = [[NSMutableArray alloc] init];
//            myInstance.priceBrowseListings = [[NSMutableArray alloc] init];
        }
        // return the instance of this class
        return myInstance;    
    }
}

- (CLLocation *)location
{
  return _locateMeManager == nil ? nil : _locateMeManager.location;
}

- (BOOL) isLoggedIn
{
  return (self.user != nil) && (self.user.userId != nil);
}

- (BOOL) signInAccount:(NSString *)email:(NSString *)password
{
  DLog(@"VariableStore::signInAccount:email=%@,password=%@",email,password);
  if( !self.user ) self.user = [[User alloc] init];
  if( !self.user.delegate ) self.user.delegate = _currentViewControllerDelegate;
  
  [self.user accountLogin:email:password];
  return YES;
}

- (BOOL) signInWeibo
{
  DLog(@"VariableStore::signInWeibo");
  if(!self.user) self.user = [[User alloc] init];
  [self.user weiboLogin];
  return YES;
}

- (BOOL) signOut {
  DLog(@"VariableStore::signOut");
  if ( self.user ) {
    [self.user logout];
  } 
  return YES;
}

- (void) clearCurrentPostingItem {
    self.currentPostingItem = [[ListItem alloc] init];
}

- (void) addToModelDict:(NSString *)controller:(NSDictionary *)model
{
  [_modelDict setObject:model forKey:controller];
  DLog(@"VariableStore:addToModelDict:modelDict=%@", _modelDict);
}

- (void) removeFromModelDict:(NSString *)controller
{
  [_modelDict removeObjectForKey:controller];
}

- (NSDictionary *) getModelDict:(NSString *)controller:(NSString *)modelName
{  
  DLog(@"VariableStore::getModelDict:controller=%@,modelName=%@", controller, modelName);
  NSDictionary *myModelDict = [_modelDict objectForKey:controller];
  NSDictionary *dict = [myModelDict objectForKey:@"errors"];
  DLog(@"VariableStore::getModelDict:dictForError=%@", dict);
  if ( dict ) { return dict; } 
  return [myModelDict objectForKey:modelName];
}

- (void)appendPostingItemToListings:(NSDictionary *)dict
{
  ListItem *listItem = [[ListItem alloc] initWithDictionary:dict];
  [self.allListings addObject:listItem];
  [self clearCurrentPostingItem];
}

- (void)storeSettings:(NSDictionary *)dict
{
  DLog(@"VariableStore::storeSettings:dict");
  
  // save to variable store
  NSDictionary *settings = [dict objectForKey:@"settings"];
  NSDictionary *duration = [settings objectForKey:@"duration"];
  
  NSDictionary *secToString = [duration objectForKey:@"sec_string"];
  NSDictionary *secToText   = [duration objectForKey:@"sec_text"];
  
  for (id key in secToString) {
    [self.durationToServerDic setObject:[secToString objectForKey:key] forKey:[NSNumber numberWithInt:[key intValue]]];
  }
  
  for (id key in secToText) {
    [self.expiredTime setObject:[NSNumber numberWithInt:[key intValue]] forKey:[secToText objectForKey:key]];
  }
  
  self.postTemplatesDict = [settings objectForKey:@"post_templates"];
}

@end
