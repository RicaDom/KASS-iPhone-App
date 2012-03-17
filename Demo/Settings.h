//
//  Settings.h
//  Demo
//
//  Created by Qi He on 12-3-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

@property (strong, nonatomic) NSMutableDictionary *expiredTimeDict;
@property (strong, nonatomic) NSMutableDictionary *durationToServerDic;
@property (strong, nonatomic) NSMutableDictionary *postTemplatesDict;
@property (strong, nonatomic) NSMutableDictionary *messageTypesDict;
@property (strong, nonatomic) NSMutableDictionary *weiboShareDict;
@property (strong, nonatomic) NSMutableDictionary *siteDict;
@property (strong, nonatomic) NSMutableArray *alertKeywordsArray;

- (id) initWithDictionary:(NSDictionary *)dict;
- (NSString *) getTextForMessageType:(NSString *)type;

@end
