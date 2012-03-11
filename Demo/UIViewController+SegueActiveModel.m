//
//  UIViewController+SegueActiveModel.m
//  Demo
//
//  Created by Qi He on 12-3-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+SegueActiveModel.h"

@implementation UIViewController (SegueActiveModel)

- (void)performSegueByModel:(ListItem *)item
{
  NSDictionary *pair = [self getItemJsonAndSegueIdentifier:item];
  if ([pair count] == 2) {
    [self performSegueWithModelJson:[pair valueForKey:@"json"]:[pair valueForKey:@"segue"]:self];
  }
}

- (void)performSegueWithModelJson:(NSDictionary *)modelJson:(NSString *)identifier:(id)sender
{
  [self kassVS].modelJson = modelJson;          
  [self performSegueWithIdentifier:identifier sender:sender];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  UINavigationController *uvc = segue.destinationViewController;
  if ( [uvc isKindOfClass:UINavigationController.class]) {
    NSString *controllerName = NSStringFromClass(uvc.topViewController.class);
    [self kassAddToModelDict:controllerName:[self kassVS].modelJson];
  }
  DLog(@"prepareForSegue");
}

- (void) kassAddToModelDict:(NSString *)controller:(NSDictionary *)model
{
  DLog(@"UIViewController+SegueActiveModel::kassAddToModelDict:controller=%@", controller);
  [[self kassVS] addToModelDict:controller:model];
}

- (NSDictionary *) kassGetModelDict:(NSString *)modelName
{
  DLog(@"UIViewController+SegueActiveModel::kassGetModelDict:controller=%@", NSStringFromClass(self.class));
  return [[self kassVS] getModelDict:NSStringFromClass(self.class):modelName];
}

- (void) kassRemoveFromModelDict
{
  [[self kassVS] removeFromModelDict:NSStringFromClass(self.class)];
}

- (NSDictionary *)getItemJsonAndSegueIdentifier:(ListItem *)item
{
  NSMutableDictionary *pair = [[NSMutableDictionary alloc] init ];
  
  // if not login
  if ( ![self kassVS].isLoggedIn ) {
    
    DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:not login");
    [pair setObject:item.toJson forKey:@"json"];
    [pair setObject:@"showBrowseItemUnlogin" forKey:@"segue"];
    
  }else if ( [[self kassVS ].user hasListItem:item] ){
    
    //if you are the buyer and you already accepted it
    if (item.isAccepted) {
      
      DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:you already accepted! ");
      [pair setObject:item.acceptedOffer.toJson forKey:@"json"];
      [pair setObject:@"BrowseListingToBuyerPay" forKey:@"segue"];
      
    }else{
      //if you are the buyer go to buyers listing page
      DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:you are buyer");
      [pair setObject:item.toJson forKey:@"json"];
      [pair setObject:@"BrowseListingToBuyerOffers" forKey:@"segue"];
    }
  }else if ( [item hasOfferer:[self currentUser]]){
    
    // if you have an offer
    DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:you've offered!");
    Offer *offer = [item getOfferFromOfferer:[self currentUser]];
    [pair setObject:offer.toJson forKey:@"json"];
    [pair setObject:@"showBrowseItem" forKey:@"segue"];
    
    
  }else{
    //you are not buyer and you've not offered
    DLog(@"BrowseTableViewController::didSelectRowAtIndexPath:logged in user");
    [pair setObject:item.toJson forKey:@"json"];
    [pair setObject:@"showBrowseItemNoMessage" forKey:@"segue"];
  }
  
  return pair;
}



@end
