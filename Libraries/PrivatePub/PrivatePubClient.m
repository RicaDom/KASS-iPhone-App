//
//  PrivatePubClient.m
//  Demo
//
//  Created by Qi He on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PrivatePubClient.h"

@implementation PrivatePubClient

@synthesize fayeClients = _fayeClients;
@synthesize privatePubs = _privatePubs;
@synthesize delegate = _delegate;

- (id)initWithDelegate:(id<FayeClientDelegate>)delegate
{
  if (self = [super init]) {
    _delegate    = delegate;
    _fayeClients = [[NSMutableArray alloc] init]; 
    _privatePubs = [[NSMutableArray alloc] init];
  }
  return self;
}

- (void)clear
{
  _privatePubs = nil;
  _fayeClients = nil; 
}

- (void)addClient:(NSDictionary *)privatePubDict
{
  
  FayeClient *faye = [[FayeClient alloc] initWithURLString:@"ws://localhost:9292/faye" 
                                                   channel:[privatePubDict valueForKey:@"channel"]];
  faye.delegate = _delegate;
  
  [_fayeClients addObject:faye];
  [_privatePubs addObject:privatePubDict];
  
}

- (void)connectClients
{
  for(int i=0; i < [_privatePubs count]; i++){
    NSDictionary *privatePubDict = [_privatePubs objectAtIndex:i];
    NSDictionary *extDict = [[NSDictionary alloc]initWithObjectsAndKeys:
                             [privatePubDict valueForKey:@"timestamp"],@"private_pub_timestamp",
                             [privatePubDict valueForKey:@"signature"],@"private_pub_signature", nil ];
    
    FayeClient *faye = [_fayeClients objectAtIndex:i];
    [faye connectToServerWithExt:extDict];
  }
}

- (void)disconnectClients
{
  for(int i=0; i < [_fayeClients count]; i++){
    FayeClient *faye = [_fayeClients objectAtIndex:i];
    [faye disconnectFromServer];
  }
}

@end
