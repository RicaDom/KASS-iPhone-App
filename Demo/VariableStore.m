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
@synthesize currentAddAlert = _currentAddAlert;

@synthesize allListings = _allListings;
@synthesize myBuyingListings = _myBuyingListings;
@synthesize mySellingListings = _mySellingListings;
@synthesize user = _user;
@synthesize locateMeManager = _locateMeManager;

@synthesize recentBrowseListings = _recentBrowseListings;
@synthesize nearBrowseListings = _nearBrowseListings;
@synthesize priceBrowseListings = _priceBrowseListings;

@synthesize modelJson = _modelJson;
@synthesize modelDict = _modelDict;
@synthesize mainTabBar = _mainTabBar;
@synthesize kassApp = _kassApp;
@synthesize settings = _settings;

@synthesize priceToModify = _priceToModify;
@synthesize itemToShowOnMap = _itemToShowOnMap;
@synthesize userToShowId = _userToShowId;
@synthesize itemClassAndIdToShow = _itemClassAndIdToShow;

@synthesize currentViewControllerDelegate = _currentViewControllerDelegate;
@synthesize remoteNotification = _remoteNotification;
@synthesize appDelegate = _appDelegate;

+ (VariableStore *) sharedInstance {
    // the instance of this class is stored here
    static VariableStore *myInstance;
    
    @synchronized(self){
        // check to see if an instance already exists
        if (nil == myInstance) {
            myInstance  = [[[self class] alloc] init];
            // initialize variables here
            myInstance.currentPostingItem = [[ListItem alloc] init];
            myInstance.currentAddAlert = [Alert new];
            
            myInstance.allListings = [[NSMutableArray alloc] init];
            myInstance.mySellingListings = [[NSMutableArray alloc] init];
            myInstance.myBuyingListings = [[NSMutableArray alloc] init];
          
            myInstance.user = [[User alloc] init];
            myInstance.locateMeManager = [[LocateMeManager alloc] init];
          
            myInstance.modelDict = [[NSMutableDictionary alloc] init];
          
            myInstance.itemClassAndIdToShow = [[NSMutableArray alloc] init];
          
            myInstance.kassApp = [[KassApp alloc] init];
            
//            myInstance.recentBrowseListings = [[NSMutableArray alloc] init];
//            myInstance.nearBrowseListings = [[NSMutableArray alloc] init];
//            myInstance.priceBrowseListings = [[NSMutableArray alloc] init];
        }
        // return the instance of this class
        return myInstance;    
    }
}

- (void)assignItemToShow:(ActiveModel *)am
{
  _itemClassAndIdToShow = [NSArray arrayWithObjects:am.dbClass,am.dbId,nil];
}

- (CLLocation *)location
{
  return _locateMeManager == nil ? nil : _locateMeManager.location;
}

- (BOOL) isLoggedIn
{
  return (self.user != nil) && (self.user.userId != nil);
}

- (BOOL) isCurrentUser:(NSString *)userId
{
  return [self isLoggedIn] && [self.user isSameUser:userId];
}

- (BOOL) signInAccount:(NSString *)email:(NSString *)password
{
  DLog(@"VariableStore::signInAccount:email=%@,password=%@",email,password);
  if ( [email isBlank] || [password isBlank]) { return NO; }
  if( !self.user ) self.user = [[User alloc] init];
  if( !self.user.delegate ) self.user.delegate = _currentViewControllerDelegate;
  
  [self.user accountLogin:email:password];
  return YES;
}


- (BOOL) signUpAccount:(NSDictionary *)userInfo
{
  DLog(@"VariableStore::signUpAccount:userInfo=%@",userInfo);
  if( !self.user ) self.user = [[User alloc] init];
  if( !self.user.delegate ) self.user.delegate = _currentViewControllerDelegate;
  
  [self.user accountSignUp:userInfo];

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

- (void) clearCurrentAddAlert {
    self.currentAddAlert = [Alert new];
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
  dict = [myModelDict objectForKey:modelName];
  DLog(@"VariableStore::getModelDict:dictForModel=%@", dict);
  return dict;
}

- (void)appendPostingItemToListings:(NSDictionary *)dict
{
  ListItem *listItem = [[ListItem alloc] initWithDictionary:dict];
  [self.allListings addObject:listItem];
  [self clearCurrentPostingItem];
}

- (void)loadAndStoreSettings:(id<KassAppDelegate>)delegate
{
  self.kassApp.delegate = delegate;
  [self.kassApp loadAndStoreSettings];
}

- (void)loadSettings:(id<KassAppDelegate>)delegate
{
  self.kassApp.delegate = delegate;
  [self.kassApp loadSettings];
}

- (void)storeSettings:(NSDictionary *)dict
{
  if (dict) {
    DLog(@"VariableStore::storeSettings:dict");
    self.settings = [[Settings alloc] initWithDictionary:dict];
  }
}

- (void)resetActivityListings
{
  _myBuyingListings = nil;
  _mySellingListings= nil;
}

- (NSMutableDictionary *)getDefaultCriteria
{
  NSString *latlng = [NSString stringWithFormat:@"%+.6f,%+.6f", 
                      self.location.coordinate.latitude, 
                      self.location.coordinate.longitude]; 
  
  return [NSMutableDictionary dictionaryWithObjectsAndKeys:latlng, @"center",
                                      @"10", @"radius",
                                      @"1", @"page",
                                      nil];
}

@end
