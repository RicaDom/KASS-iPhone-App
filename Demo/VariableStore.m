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
        }
        // return the instance of this class
        return myInstance;    
    }
}

- (BOOL) isLoggedIn
{
  return (self.user != nil) && (self.user.userId != nil);
}

- (BOOL) signInAccount:(NSString *)email:(NSString *)password
{
  DLog(@"VariableStore::signInAccount:email=%@,password=%@",email,password);
  [self.user accountLogin:email:password];
  return YES;
}

- (BOOL) signInWeibo
{
  DLog(@"VariableStore::signInWeibo");
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
    [item setTitle:@"gently used kindle"];
    [item setDescription:@"good condition with wifi"];
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
    [item setTitle:@"games for ps3"];
    [item setDescription:@"any shooting games"];
    
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
                        [NSNumber numberWithInteger: 0], @"选择时间",
                        [NSNumber numberWithInteger: 3600], @"1 小时",
                        [NSNumber numberWithInteger: 7200], @"2 小时",
                        [NSNumber numberWithInteger: 21600], @"6 小时", 
                        [NSNumber numberWithInteger: 43200], @"12 小时",
                        [NSNumber numberWithInteger: 86400], @"24 小时",
                        [NSNumber numberWithInteger: 172800], @"2 天",
                        [NSNumber numberWithInteger: 259200], @"3 天",
                        [NSNumber numberWithInteger: 345600], @"4 天",
                        [NSNumber numberWithInteger: 432000], @"5 天",
                        [NSNumber numberWithInteger: 518400], @"6 天",
                        [NSNumber numberWithInteger: 604800], @"7 天",
                        nil];
}
@end
