//
//  LDToolBooksViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/20.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDToolBooksViewController.h"
#import "LDShoppingTableViewCell.h"
#import "LDShoppingDetailViewController.h"
#import "LDStoreViewController.h"
@interface LDToolBooksViewController ()<UIScrollViewDelegate>
{
    NSInteger page;
}

@end

@implementation LDToolBooksViewController

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
                          @"pageSize":@20,
                          @"type": @1, //1书籍 2课程
    };
    QMUITips *tip = [QMUITips showLoadingInView:self.view];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"goods/getallgoods" requestParameters:dic requestHeader:nil success:^(id responseObject) {
        [tip hideAnimated:YES];
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDStoreModel class] json:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
        }else{
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
    NSDictionary *dic = @{@"title":title,
                          @"page":@(page),
                          @"pageSize":@20,
                          @"type": @1, //1书籍 2课程
    };
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"goods/getallgoods" requestParameters:dic requestHeader:nil success:^(id responseObject) {
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
- (void)addShopCar:(LDStoreModel *)model{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:@"shoppingcat/addgoods" requestParameters:@{@"goodsId":model.s_id,@"goodsType":model.type} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            [QMUITips showSucceed:@"添加成功"];
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
    _weakself;
    cell.addShopCarActionBlock = ^{
        [weakself addShopCar:model];
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LDShoppingDetailViewController *vc = [LDShoppingDetailViewController new];
    LDStoreModel *model = self.dataSource[indexPath.row];
    vc.shopID = model.s_id;
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PtHeight(80);
}

@end
