//
//  TestCaseFactory.m
//  CTNetworking
//
//  Created by casa on 15/12/31.
//  Copyright © 2015年 casa. All rights reserved.
//

#import "TestCaseFactory.h"

#import "FireSingleAPI.h"
#import "FireDoubleAPIController.h"

@implementation TestCaseFactory

- (UIViewController *)testCaseWithType:(TestCaseType)testCaseType
{
    UIViewController *testCase = nil;
    
    if (testCaseType == TestCaseTypeFireSingleAPI) {
        testCase = [[FireSingleAPI alloc] init];
    }
    
    if (testCaseType == TestCaseTypeFireDoubleAPI) {
        testCase = [FireDoubleAPIController new];
    }
    return testCase;
}

@end
