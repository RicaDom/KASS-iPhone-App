//
//  ListItemTest.h
//  Demo
//
//  Created by Qi He on 12-1-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>
#include <OCMock/OCMock.h>
#import "ListItem.h"
#import "ListItem+ListItemHelper.h"

@interface ListItemTest : SenTestCase{
  ListItem *listItem;
}


@end
