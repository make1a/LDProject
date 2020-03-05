//
//  LDBookListViewController.m
//  LeDaoCollege
//
//  Created by make on 2020/2/28.
//  Copyright © 2020 Make. All rights reserved.
//

#import "LDBookListViewController.h"
#import "LDStoreModel.h"
#import "LDDicBookCell.h"
#import "LDShoppingDetailViewController.h"

@interface LDBookListViewController ()

@end

@implementation LDBookListViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestDataSource];
}

- (void)requestDataSource{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"book/books" requestParameters:@{@"type":@(self.type)} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDStoreModel class] json:responseObject[@"data"][@"list"]];

            [self.tableView reloadData];
        
        }
        [self.tableView.mj_header endRefreshing];
    } faild:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}
#pragma  mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDDicBookCell *cell = [LDDicBookCell dequeueReusableWithTableView:tableView];
    if (self.dataSource) {
        LDStoreModel *model = self.dataSource[indexPath.row];
        [cell refreshWithModel:model];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     LDShoppingDetailViewController *vc = [LDShoppingDetailViewController new];
    LDStoreModel *model = self.dataSource[indexPath.row];
     vc.shopID = model.s_id;
     [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kTableViewCellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
@end
