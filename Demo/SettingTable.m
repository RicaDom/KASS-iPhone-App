//
//  Setting.m
//  kass
//
//  Created by Wesley Wang on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingTable.h"

@implementation SettingTable

@synthesize displayName = _displayName;
@synthesize segueName = _segueName;

+(NSArray *)userDidLoginArray
{
    NSMutableArray *settingArray = [NSMutableArray new];
    SettingTable *st = [SettingTable new];
    
    st.displayName = @"个人信息";
    st.segueName = @"SettingToProfileView";
    [settingArray addObject:st];
    
    st = [SettingTable new];
    st.displayName = @"商家提醒";
    st.segueName = @"SettingToSellerAlert";
    [settingArray addObject:st];
    
    st = [SettingTable new];
    st.displayName = @"设置";
    st.segueName = @"SettingToConfigView";
    [settingArray addObject:st];
    
    st = [SettingTable new];
    st.displayName = @"关于街区";
    st.segueName = @"SettingToAbout";
    [settingArray addObject:st];
    
    return settingArray;
}

+(NSArray *)guessArray
{
    NSMutableArray *settingArray = [NSMutableArray new];
    SettingTable *st = [SettingTable new];
    st.displayName = @"注册或登陆";
    [settingArray addObject:st];
    
    st = [SettingTable new];
    st.displayName = @"设置";
    [settingArray addObject:st];
    
    st = [SettingTable new];
    st.displayName = @"关于街区";
    st.segueName = @"SettingToAbout";
    [settingArray addObject:st];
    
    return settingArray;
}

@end
