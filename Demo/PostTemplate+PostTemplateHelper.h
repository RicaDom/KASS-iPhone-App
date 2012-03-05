//
//  PostTemplate+PostTemplateHelper.h
//  Demo
//
//  Created by Qi He on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PostTemplate.h"
#import "AppScrollView.h"

@interface PostTemplate (PostTemplateHelper)

- (HJManagedImageV *)getHJManagedImageView;
- (void)initHJManagedImageView:(CGRect)frame;

+ (NSMutableArray *)getTemplatesByCategory:(NSArray *)dict:(NSString *)category;
+ (void)buildTemplatesView:(IBOutlet AppScrollView *)templateView:(NSArray *)templates:(UIPageControl *)pageControl:(BOOL *)controllBeingUsed;

@end
