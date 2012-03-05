//
//  PostTemplate.h
//  Demo
//
//  Created by Wesley Wang on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListItem.h"
#import "HJManagedImageV.h"

@interface PostTemplate : NSObject{
  HJManagedImageV *hjManagedImageView;
}

@property (strong, nonatomic) NSString *dbId;
@property (strong, nonatomic) NSString *category; //popular post, editor, creative ideas
@property (strong, nonatomic) NSString *picPath;
@property (strong, nonatomic) ListItem *listItem;

- (id) initWithDictionaryAndCategory:(NSDictionary *)theDict:(NSString *)category;

@end
