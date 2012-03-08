//
//  UIViewController+SegueActiveModel.h
//  Demo
//
//  Created by Qi He on 12-3-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIResponder+VariableStore.h"

@interface UIViewController (SegueActiveModel)

- (void)performSegueWithModelJson:(NSDictionary *)modelJson:(NSString *)identifier:(id)sender;
- (NSDictionary *) kassGetModelDict:(NSString *)modelName;
- (void) kassAddToModelDict:(NSString *)controller:(NSDictionary *)model;
- (void) kassRemoveFromModelDict;

@end
