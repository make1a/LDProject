//
//  LDShopClassViewController.m
//  LeDaoCollege
//
//  Created by make on 2020/2/19.
//  Copyright © 2020 Make. All rights reserved.
//

#import "LDShopClassViewController.h"
#import "LDDicBookCell.h"
#import "LDSmallClassDetailViewController.h"
#import "LDVideoDetailViewController.h"
@interface LDShopClassViewController ()<UIScrollViewDelegate>

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@end

@implementation LDShopClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 5, 0);
    if (!self.isSearchModel) {
        [self requestSource:@"" back:nil];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestSource:@"" back:nil];
        }];
    }
}
- (void)updateType{
    type = 1;
}
- (void)requestSource:(NSString *)title back:(backSourceCountBlock)blcok {
    [self updateType];
    NSDictionary *dic = @{@"title":title,
                          @"page":@(1),
                          @"pageSize":@1000,
                          @"type": @(type), //1书籍 2课程
    };
    NSString *url = [NSString stringWithFormat:@"goods/getallgoods"];
    QMUITips *tip = [QMUITips showLoadingInView:self.view];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:url requestParameters:dic requestHeader:nil success:^(id responseObject) {
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
#pragma  mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDDicBookCell *cell = [LDDicBookCell dequeueReusableWithTableView:tableView];
    LDStoreModel *model = self.dataSource[indexPath.row];
    [cell refreshWithModel: model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
LDSmallClassDetailViewController *vc = [LDSmallClassDetailViewController new];
 LDStoreModel *model = self.dataSource[indexPath.row];
 vc.videoID = model.s_id;
 [self.navigationController pushViewController:vc animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableViewCellHeight;
}
#pragma  mark - Scrollview
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback ?: self.scrollCallback(scrollView);
}
#pragma mark - JXPagingViewListViewDelegate

- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (void)listWillAppear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

- (void)listDidAppear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

- (void)listWillDisappear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}

- (void)listDidDisappear {
    NSLog(@"%@:%@", self.title, NSStringFromSelector(_cmd));
}


@end
