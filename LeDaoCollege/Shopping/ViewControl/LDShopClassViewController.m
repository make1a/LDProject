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
#import "LDShoppingDetailViewController.h"
@interface LDShopClassViewController ()<UIScrollViewDelegate>
{
   __block NSInteger _pageSize;
}
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
            self->_pageSize = 20;
            [self requestSource:@"" back:nil];
        }];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
           self->_pageSize += 20;
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
                          @"pageSize":@(_pageSize),
                          @"type": @(type), //1书籍 2课程
    };
    NSString *url = [NSString stringWithFormat:@"goods/getallgoods"];
    QMUITips *tip = [QMUITips showLoadingInView:self.view];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:url requestParameters:dic requestHeader:nil success:^(id responseObject) {
        [tip hideAnimated:YES];
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDStoreModel class] json:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
            NSInteger total = [responseObject[@"data"][@"total"] integerValue];
            if (total <= self->_pageSize) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_header endRefreshing];
            }
        }else{
            [QMUITips showError:@"网络错误,请稍微再试"];
        }
        
        [self.tableView.mj_footer endRefreshing];
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


 LDStoreModel *model = self.dataSource[indexPath.row];
    if ([model.courseType isEqualToString:@"2"]) { // 微课
        
        LDVideoDetailViewController *vc = [[LDVideoDetailViewController alloc]init];
        vc.videoID = model.s_id;
        vc.isSmallClass = NO;
        [self.navigationController pushViewController:vc animated:YES];

    }else{ //视频
        LDSmallClassDetailViewController *vc = [LDSmallClassDetailViewController new];
        vc.videoID = model.s_id;
        [self.navigationController pushViewController:vc animated:YES];
    }

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
