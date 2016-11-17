//
//  ViewController.m
//  CTNetworking
//
//  Created by casa on 15/12/31.
//  Copyright © 2015年 casa. All rights reserved.
//

#import "TestViewController.h"
#import <UIView+LayoutMethods.h>
#import "TestCaseFactory.h"

NSString * const kBSDataSourceItemKeyTestCaseType = @"kBSDataSourceItemKeyTestCaseType";
NSString * const kBSDataSourceItemKeyTestCaseTitle = @"kBSDataSourceItemKeyTestCaseTitle";

@interface TestViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) TestCaseFactory *testCaseFactory;

@end

@implementation TestViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView fill];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *testCase = [self.testCaseFactory testCaseWithType:[self.dataSource[indexPath.row][kBSDataSourceItemKeyTestCaseType] unsignedIntegerValue]];
    [self.navigationController pushViewController:testCase animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataSource[indexPath.row][kBSDataSourceItemKeyTestCaseTitle];
    return cell;
}

#pragma mark - getters and setters
// 这种方式太太不爽了，接受吧!（if里面的语句就是初始化的方法）

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //注册
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

// 数据源
- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = @[
                        @{
                            kBSDataSourceItemKeyTestCaseType:@(TestCaseTypeFireSingleAPI),
                            kBSDataSourceItemKeyTestCaseTitle:@"fire single api"
                            }
                          ,@{
                            kBSDataSourceItemKeyTestCaseType:@(TestCaseTypeFireDoubleAPI),
                            kBSDataSourceItemKeyTestCaseTitle:@"fire double api"
                            }
                        ];
    }
    return _dataSource;
}

// 为什么要有一个工厂模式呢？？？
- (TestCaseFactory *)testCaseFactory
{
    if (_testCaseFactory == nil) {
        _testCaseFactory = [[TestCaseFactory alloc] init];
    }
    return _testCaseFactory;
}

@end
