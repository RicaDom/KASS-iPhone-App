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

@synthesize allListings = _allListings;
@synthesize myBuyingListings = _myBuyingListings;
@synthesize mySellingListings = _mySellingListings;
@synthesize user = _user;
@synthesize locateMeManager = _locateMeManager;

@synthesize recentBrowseListings = _recentBrowseListings;
@synthesize nearBrowseListings = _nearBrowseListings;
@synthesize priceBrowseListings = _priceBrowseListings;

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
                        @"0h", @"选择时间",
                        @"1h", @"1 小时",
                        @"2h", @"2 小时",
                        @"6h", @"6 小时", 
                        @"12h", @"12 小时",
                        @"24h", @"24 小时",
                        @"2d", @"2 天",
                        @"3d", @"3 天",
                        @"4d", @"4 天",
                        @"5d", @"5 天",
                        @"6d", @"6 天",
                        @"7d", @"7 天",
                        nil];
}
@end
