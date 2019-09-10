//
//  LDMineViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDMineViewController.h"
#import "LDNormalTableViewCell.h"
#import "LDCustomerManagerViewController.h"
#import "LDConfigTableViewController.h"
#import "LDCollectViewController.h"

@interface LDMineViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSArray * titlesArray;
@end

@implementation LDMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self masLayoutSubviews];
}

- (void)masLayoutSubviews{
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
#pragma  mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDNormalTableViewCell *cell = [LDNormalTableViewCell dequeueReusableWithTableView:tableView];
    cell.textLabel.text = self.titlesArray[indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return  [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            LDCustomerManagerViewController *vc = [LDCustomerManagerViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            LDCollectViewController *vc = [LDCollectViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7 :{
            LDConfigTableViewController *vc = [[LDConfigTableViewController alloc]initWithStyle:UITableViewStylePlain];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma  mark - GET && SET
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSArray *)titlesArray {
    if (!_titlesArray) {
        _titlesArray = @[@"我的管理",@"我的收藏",@"我的订单",@"我的购物车",@"我的书架",@"我的积分",@"我的乐币",@"设置"];
    }
    return _titlesArray;
}
@end
