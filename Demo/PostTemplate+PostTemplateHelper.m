//
//  PostTemplate+PostTemplateHelper.m
//  Demo
//
//  Created by Qi He on 12-3-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PostTemplate+PostTemplateHelper.h"

@implementation PostTemplate (PostTemplateHelper)

+ (NSMutableArray *)getTemplatesByCategory:(NSArray *)templatesList :(NSString *)category
{
  NSMutableArray *templates = [NSMutableArray new];
  for(int i = 0; i < [templatesList count]; i++){
    NSDictionary *template = [templatesList objectAtIndex:i];
    PostTemplate *temp = [[PostTemplate alloc] initWithDictionaryAndCategory:template:category];
    [templates addObject:temp];
  }
  return templates;
}

+ (void)buildTemplatesView:(AppScrollView *)templateView:(NSArray *)templates:(UIPageControl *)pageControl:(BOOL *)controlBeingUsed
{
  int counter = 0;
  CGRect frame;
  
  for (PostTemplate *temp in templates) {
    
    frame.origin.y = 0;
    
    // Popular Post Template
    frame.origin.x = templateView.frame.size.width * counter;
    frame.size = templateView.frame.size;
    
    [temp initHJManagedImageView:frame];
    
    HJManagedImageV *subview = [temp getHJManagedImageView];
    [subview showLoadingWheel];
    [templateView addSubview:subview];    
    
    counter++;
    templateView.contentSize = CGSizeMake(templateView.frame.size.width * counter, templateView.frame.size.height);
    
  }
  
  *controlBeingUsed = NO;
  pageControl.currentPage = 0;
  pageControl.numberOfPages = counter;
  
}


- (HJManagedImageV *)getHJManagedImageView
{
  return hjManagedImageView;
}

- (void)initHJManagedImageView:(CGRect)frame
{
  if (hjManagedImageView) { hjManagedImageView = nil; }
  hjManagedImageView = [[HJManagedImageV alloc] initWithFrame:frame];
  hjManagedImageView.tag = [self.dbId intValue];
  hjManagedImageView.url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%@", PIC_PATH, self.picPath]];
  //  DLog(@"PostTemplate::getHJManagedImageView::url=%@", imageV.url);
}

@end
