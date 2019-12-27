//
//  LDAllshoppingViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/20.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDAllshoppingViewController.h"
#import "LDShoppingTableViewCell.h"
#import "LDStoreModel.h"
#import "LDShoppingDetailViewController.h"
#import "LDSmallClassDetailViewController.h"
#import "LDStoreViewController.h"
#import "LDVideoDetailViewController.h"

@interface LDAllshoppingViewController ()<UIScrollViewDelegate>
{
    NSInteger page;
    
}

@end

@implementation LDAllshoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    if (!self.isSearchModel) {
        [self requestAllStore];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestAllStore];
        }];
    }
}
- (void)requestAllStore {
    NSDictionary *dic = @{@"title":@"",
                          @"page":@(page),
                          @"pageSize":@20};
    QMUITips *tip = [QMUITips showLoadingInView:self.view];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"goods/getallgoods" requestParameters:dic requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
           self.dataSource = [NSArray yy_modelArrayWithClass:[LDStoreModel class] json:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
            [tip hideAnimated:YES];
        }else{
            [tip hideAnimated:YES];
            [QMUITips showError:@"网络错误,请稍微再试"];
        }
        [self.tableView.mj_header endRefreshing];
    } faild:^(NSError *error) {
        [tip hideAnimated:YES];
        [QMUITips showError:@"网络错误,请稍微再试"];
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)requestSource:(NSString *)title back:(backSourceCountBlock)blcok {
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"goods/getallgoods" requestParameters:@{@"title":title} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDStoreModel class] json:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
                        if (blcok) {
                blcok(self.dataSource.count);
            }
        }
    } faild:^(NSError *error) {
        
    }];
}
#pragma  mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDShoppingTableViewCell *cell = [LDShoppingTableViewCell dequeueReusableWithTableView:tableView];
    LDStoreModel *model = self.dataSource[indexPath.row];
    [cell refreshWithModel: model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LDStoreModel *model = self.dataSource[indexPath.row];
    if ([model.type isEqualToString:@"1"]) {
        LDShoppingDetailViewController *vc = [LDShoppingDetailViewController new];
        vc.shopID = model.s_id;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        LDVideoDetailViewController *vc = [LDVideoDetailViewController new];
        LDStoreModel *model = self.dataSource[indexPath.row];
        vc.videoID = model.s_id;
        vc.isSmallClass = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PtHeight(80);
}
#pragma  mark - Scrollview

@end
