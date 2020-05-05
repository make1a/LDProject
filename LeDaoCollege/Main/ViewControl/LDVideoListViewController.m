//
//  LDVideoListViewController.m
//  LeDaoCollege
//
//  Created by make on 2019/12/8.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDVideoListViewController.h"
#import "LDVideoTableViewCell.h"
#import "LDVideoModel.h"
#import "LDWebViewViewController.h"
#import "LDVideoDetailViewController.h"
@interface LDVideoListViewController ()



@end

@implementation LDVideoListViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    if (!_isSearchModel) {
        [self requestSource:@"" mark:self.tagID back:^(NSInteger count) {}];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestSource:@"" mark:self.tagID back:^(NSInteger count){}];
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark - Request
- (void)requestSource:(NSString *)title mark:(NSString *)mark back:(backSourceCountBlock)blcok{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"video/getlist" requestParameters:@{@"title":title,@"mark":mark,@"pageSize":@1000} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDVideoModel class] json:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
            if (blcok) {
                blcok(self.dataSource.count);
            }
        }
        [self.tableView.mj_header endRefreshing];
    } faild:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)requestCollection:(LDVideoModel*)model index:(NSInteger)index{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:@"collection/addanddelete" requestParameters:@{@"collectionId":model.v_id,@"collectionType":@"2"} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            [QMUITips showSucceed:responseObject[@"returnMsg"]];
            if ([model.collectionFlag isEqualToString:@"N"]) {
                model.collectionFlag = @"Y";
            } else {
                model.collectionFlag = @"N";
            }
            
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
    } faild:^(NSError *error) {
        
    }];
}

#pragma  mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDVideoTableViewCell *cell = [LDVideoTableViewCell dequeueReusableWithTableView:tableView];
    LDVideoModel *model = self.dataSource[indexPath.row];
    [cell refreshWithModel:model];
    _weakself;
    cell.didSelectCollectionActionBlock = ^{
        [weakself requestCollection:model index:indexPath.row];
    };
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kTableViewCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LDVideoModel *model = self.dataSource[indexPath.row];
    LDVideoDetailViewController *vc = [[LDVideoDetailViewController alloc]init];
    vc.videoID = model.v_id;
    vc.isSmallClass = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
