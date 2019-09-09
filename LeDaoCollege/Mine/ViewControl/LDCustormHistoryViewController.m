//
//  LDCustormHistoryViewController.m
//  LeDaoCollege
//
//  Created by make on 2019/9/7.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDCustormHistoryViewController.h"

@interface LDCustormHistoryViewController ()<QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic,strong)QMUITableView * tableView;
@end

@implementation LDCustormHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self masLayoutSubviews];
}
- (void)masLayoutSubviews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.equalTo(self.view.mas_safeAreaLayoutGuide);
        } else {
            make.edges.equalTo(self.view);
        }
    }];
}

#pragma  mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"make";
    return cell;
}
#pragma  mark - GET SET
- (QMUITableView *)tableView {
    if (!_tableView) {
        _tableView = [[QMUITableView alloc]init];
        _tableView.delegate = self;
        self.tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
@end
