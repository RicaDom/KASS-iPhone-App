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

+ (VariableStore *) sharedInstance {
    // the instance of this class is stored here
    static VariableStore *myInstance;
    
    @synchronized(self){
        // check to see if an instance already exists
        if (nil == myInstance) {
            myInstance  = [[[self class] alloc] init];
            // initialize variables here
            myInstance.currentPostingItem = [[ListItem alloc] init];
            [myInstance initExpiredTime];
            
            myInstance.allListings = [[NSMutableArray alloc] init];
            myInstance.mySellingListings = [[NSMutableArray alloc] init];
            myInstance.myBuyingListings = [[NSMutableArray alloc] init];
            [myInstance initListingsData];
          
            myInstance.user = [[User alloc] init];
            myInstance.locateMeManager = [[LocateMeManager alloc] init];
          
            myInstance.modelDict = [[NSMutableDictionary alloc] init];
            
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
  if(!self.user) self.user = [[User alloc] init];
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
    self.user = nil;
  } 
  return YES;
}

- (void) clearCurrentPostingItem {
    self.currentPostingItem = [[ListItem alloc] init];
}

- (void) addToModelDict:(NSString *)controller:(NSDictionary *)model
{
  [_modelDict setObject:model forKey:controller];
  DLog(@"modeldict=%@", _modelDict);
}

- (void) removeFromModelDict:(NSString *)controller
{
  [_modelDict removeObjectForKey:controller];
}

- (NSDictionary *) getModelDict:(NSString *)controller:(NSString *)modelName
{  
  NSDictionary *myModelDict = [_modelDict objectForKey:controller];
  NSDictionary *dict = [myModelDict objectForKey:@"errors"];
  DLog(@"dict=%@", dict);
  if ( dict ) { return dict; } 
  return [myModelDict objectForKey:modelName];
}

- (void)appendPostingItemToListings:(NSDictionary *)dict
{
  ListItem *listItem = [[ListItem alloc] initWithDictionary:dict];
  [self.allListings addObject:listItem];
  [self clearCurrentPostingItem];
}





//Loading sample data, for TESTING ONLY!
- (void) initListingsData {
    ListItem *item = [ListItem new];
    
    item = [ListItem new];
    [item setTitle:@"求购2012年东方卫视跨年演唱会门票"];
    [item setDescription:@"听说有很多明星，阵容强大啊，求门票啊~~ 听说有很多明星，阵容强大啊，求门票啊~~ 听说有很多明星，阵容强大啊，求门票啊~~"];
    item.askPrice = [NSDecimalNumber decimalNumberWithDecimal:
                     [[NSNumber numberWithFloat:89.75f] decimalValue]];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:22];
    [comps setMonth:1];
    [comps setYear:2012];
    item.postedDate = [[NSCalendar currentCalendar] dateFromComponents:comps];

    item.postDuration = [NSNumber numberWithInt:172800];
    [self.allListings addObject:item];
    
    item = [ListItem new];
    [item setTitle:@"什么都不想吃了……给我找辆车让我回家吧"];
    [item setDescription:@"什么都不想吃了……给我找辆车让我回家吧 什么都不想吃了……给我找辆车让我回家吧 什么都不想吃了……给我找辆车让我回家吧"];
    
    [comps setDay:29];
    [comps setMonth:1];
    [comps setYear:2012];
    item.postedDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    item.postDuration = [NSNumber numberWithInt:43200];
    item.askPrice = [NSDecimalNumber decimalNumberWithDecimal:
                     [[NSNumber numberWithFloat:18.55f] decimalValue]];
    
    [self.allListings addObject:item];
}

- (void) initExpiredTime {
    // convert to seconds
    self.expiredTime = [[NSDictionary alloc] initWithObjectsAndKeys:
                        [NSNumber numberWithInt:0], @"选择时间",
                        [NSNumber numberWithInt:3600], @"1 小时",
                        [NSNumber numberWithInt:7200], @"2 小时",
                        [NSNumber numberWithInt:21600], @"6 小时", 
                        [NSNumber numberWithInt:43200], @"12 小时",
                        [NSNumber numberWithInt:86400], @"24 小时",
                        [NSNumber numberWithInt:172800], @"2 天",
                        [NSNumber numberWithInt:259200], @"3 天",
                        [NSNumber numberWithInt:345600], @"4 天",
                        [NSNumber numberWithInt:432000], @"5 天",
                        [NSNumber numberWithInt:518400], @"6 天",
                        [NSNumber numberWithInt:604800], @"7 天",
                        nil];
    
    self.durationToServerDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                @"0h", [NSNumber numberWithInt:0], 
                                @"1h", [NSNumber numberWithInt:3600],
                                @"2h", [NSNumber numberWithInt:7200],
                                @"6h", [NSNumber numberWithInt:21600], 
                                @"12h",[NSNumber numberWithInt:43200], 
                                @"24h",[NSNumber numberWithInt:86400],
                                @"2d", [NSNumber numberWithInt:172800],
                                @"3d", [NSNumber numberWithInt:259200],
                                @"4d", [NSNumber numberWithInt:345600],
                                @"5d", [NSNumber numberWithInt:432000], 
                                @"6d", [NSNumber numberWithInt:518400], 
                                @"7d", [NSNumber numberWithInt:604800],
                                nil];
}
@end
