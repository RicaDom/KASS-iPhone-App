//
//  KassAppObjManager.m
//  Demo
//
//  Created by Qi He on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "KassAppObjManager.h"

@implementation KassAppObjManager

@synthesize objMan;

- (void)initHJObjManager
{
  // Create the object manager
  objMan = [[HJObjManager alloc] initWithLoadingBufferSize:6 memCacheSize:20];
  
  //if you are using for full screen images, you'll need a smaller memory cache than the defaults,
  //otherwise the cached images will get you out of memory quickly
  //objMan = [[HJObjManager alloc] initWithLoadingBufferSize:6 memCacheSize:1];
  
  [self changeFileCacheDirectory:PIC_CACHE_PATH];
  
}

- (void)changeFileCacheDirectory:(NSString *)cacheDir
{
  // Create a file cache for the object manager to use
  // A real app might do this durring startup, allowing the object manager and cache to be shared by several screens
  NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:cacheDir] ;
  HJMOFileCache* fileCache = [[HJMOFileCache alloc] initWithRootPath:cacheDirectory];
  objMan.fileCache = fileCache;
  
  // Have the file cache trim itself down to a size & age limit, so it doesn't grow forever
  fileCache.fileCountLimit = 100;
  fileCache.fileAgeLimit = 60*60*24*7; //1 week
  [fileCache trimCacheUsingBackgroundThread];
}

+ (KassAppObjManager *) sharedInstance {
  // the instance of this class is stored here
  static KassAppObjManager *myInstance;
  
  @synchronized(self){
    // check to see if an instance already exists
    if (nil == myInstance) {
      myInstance = [[[self class] alloc] init];
      [myInstance initHJObjManager];
    }
    // return the instance of this class
    return myInstance;    
  }
}

- (BOOL) manage:(id<HJMOUser>)user
{
  return [objMan manage:user];
}


@end
