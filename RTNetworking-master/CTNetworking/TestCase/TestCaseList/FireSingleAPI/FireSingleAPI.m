//
//  FireSingleAPI.m
//  CTNetworking
//
//  Created by casa on 15/12/31.
//  Copyright © 2015年 casa. All rights reserved.
//

#import "FireSingleAPI.h"
#import "TestAPIManager.h"
#import <UIView+LayoutMethods.h>


///之所以会有一个datasource 和delegate ，一个是提供显示的数据，一个是代理是掌管了具体的行为；

@interface FireSingleAPI () <CTAPIManagerParamSource, CTAPIManagerCallBackDelegate>

@property (nonatomic, strong) TestAPIManager *testAPIManager;
@property (nonatomic, strong) UILabel *resultLable;

@end

@implementation FireSingleAPI

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.resultLable];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self layoutResultLable];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 这个进行发送了请求，发送请求需要参数，参数是在下面的paramsForApi 这个方法进行准备，这样有什么好处？如果我要发送不同的参数呢？那将会怎么样进行处理?
    [self.testAPIManager loadData];
}

- (void)layoutResultLable
{
    [self.resultLable sizeToFit];
    [self.resultLable centerXEqualToView:self.view];
    [self.resultLable centerYEqualToView:self.view];
}

#pragma mark - CTAPIManagerParamSource

- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager
{
    NSDictionary *params = @{};
    
    if (manager == self.testAPIManager) {
        params = @{
                   kTestAPIManagerParamsKeyLatitude:@(31.228000),
                   kTestAPIManagerParamsKeyLongitude:@(121.454290)
                   };
    }
    
    return params;
}

#pragma mark - CTAPIManagerCallBackDelegate

- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager
{
    if (manager == self.testAPIManager) {
        self.resultLable.text = @"success";
        NSLog(@"%@", [manager fetchDataWithReformer:nil]);
        [self layoutResultLable];
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager
{
    if (manager == self.testAPIManager) {
        self.resultLable.text = @"fail";
        NSLog(@"%@", [manager fetchDataWithReformer:nil]);
        [self layoutResultLable];
    }
}

// 不太喜欢这种写法，应该尽可能的避免
#pragma mark - getters and setters

- (TestAPIManager *)testAPIManager
{
    if (_testAPIManager == nil) {
        _testAPIManager = [[TestAPIManager alloc] init];
        _testAPIManager.delegate = self;
        _testAPIManager.paramSource = self;
    }
    return _testAPIManager;
}

- (UILabel *)resultLable
{
    if (_resultLable == nil) {
        _resultLable = [[UILabel alloc] init];
        _resultLable.text = @"loading API...";
    }
    return _resultLable;
}

@end
