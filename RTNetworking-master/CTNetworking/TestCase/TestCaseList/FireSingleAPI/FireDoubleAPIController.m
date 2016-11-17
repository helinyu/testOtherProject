//
//  FireDoubleAPIController.m
//  CTNetworking
//
//  Created by felix on 2016/11/16.
//  Copyright © 2016年 Long Fan. All rights reserved.
//

#import "FireDoubleAPIController.h"
#import "UIView+LayoutMethods.h"

@interface FireDoubleAPIController ()

@property (strong, nonatomic) UILabel *resultLable;
@end

@implementation FireDoubleAPIController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    [self resultLable];
    [self.view addSubview:_resultLable];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self layoutViewResultLabel];
}

- (void)layoutViewResultLabel {

    [self.resultLable sizeToFit];
    [self.resultLable centerXEqualToView:self.view];
    [self.resultLable centerYEqualToView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
