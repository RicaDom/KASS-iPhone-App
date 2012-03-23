//
//  Setting.h
//  kass
//
//  Created by Wesley Wang on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingTable : NSObject

@property (strong, nonatomic) NSString *displayName;
@property (strong, nonatomic) NSString *segueName;

+(NSArray *)userDidLoginArray;
+(NSArray *)guessArray;

@end
