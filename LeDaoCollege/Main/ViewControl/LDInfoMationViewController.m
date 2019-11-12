//
//  LDInfoMationViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDInfoMationViewController.h"
#import "SDCycleScrollView.h"
#import "LDNewsTableViewCell.h"
#import "LDNewsModel.h"
#import "LDWebViewViewController.h"
@interface LDInfoMationViewController ()<SDCycleScrollViewDelegate,QMUITableViewDataSource,QMUITableViewDelegate>
{
    NSInteger currentPage;
}
@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;

@end

@implementation LDInfoMationViewController
#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.netImages = @[];
    currentPage = 0;
    [self masLayoutSubviews];
    if (!self.isSearchModel) {
        [self requestDatasource];
//        [self requestBannerList];
    }
}
#pragma mark - NetWork

- (void)requestDatasource {
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"information/getlists" requestParameters:@{@"pageSize":@(1000)} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDNewsModel class] json:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
}
- (void)requestSource:(NSString *)title back:(backSourceCountBlock)blcok {
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"information/getlists" requestParameters:@{@"title":title,@"pageSize":@(1000)} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDNewsModel class] json:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
                        if (blcok) {
                blcok(self.dataSource.count);
            }
        }
    } faild:^(NSError *error) {
        
    }];
}
//- (void)requestBannerList{
//    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"banner/getbytype/1" requestParameters:@{@"type":@"1"} requestHeader:nil success:^(id responseObject) {
//        if (kCODE == 200) {
//
//        }
//    } faild:^(NSError *error) {
//
//    }];
//}
#pragma  mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDNewsTableViewCell *cell = [LDNewsTableViewCell dequeueReusableWithTableView:tableView];
    [cell refreshWithModel:self.dataSource[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LDNewsModel *model = self.dataSource[indexPath.row];
    LDWebViewViewController * vc = [LDWebViewViewController new];
    vc.urlStrng = [NSString stringWithFormat:@"%@?id=%@",model.contentUrl,model.newsId];
    vc.s_id = model.newsId;
    vc.isCollection = [model.collectionFlag isEqualToString:@"Y"]?YES:NO;
    vc.collectionType = @"1";
    vc.didRefreshCollectionStateBlock = ^(BOOL isCollection) {
        model.collectionFlag = isCollection?@"Y":@"N";
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return PtHeight(80);
}

#pragma  mark - SDCyclesScrollview
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}

#pragma mark - private method
#pragma  mark - LayoutSubviews
- (void)masLayoutSubviews {
    [self.view addSubview:self.tableView];

    if (!self.isSearchModel) {
        [self.view addSubview:self.cycleScrollView];
        [self.cycleScrollView reloadInputViews];
        [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(PtWidth(20));
            make.right.mas_equalTo(self.view).mas_offset(PtWidth(-20));
            make.top.mas_equalTo(self.view);
            make.height.mas_equalTo(PtHeight(120));
        }];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(PtWidth(20));
            make.right.mas_equalTo(self.view).mas_offset(PtWidth(-20));
            make.top.mas_equalTo(self.cycleScrollView.mas_bottom);
            if (@available(iOS 11.0, *)) {
                make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.mas_equalTo(self.view);
            }
        }];
        
    }else {
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}
#pragma mark - get and set
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        UIImage * placeholderImage = [UIImage imageNamed:@"seizeaseat_1"];
        CGRect frame = CGRectMake(PtWidth(20), 0, PtWidth(335), PtHeight(120));
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
        _cycleScrollView.imageURLStringsGroup = self.netImages;
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.layer.masksToBounds = YES;
        _cycleScrollView.layer.cornerRadius = 10;
    }
    return _cycleScrollView;
}
- (void)setNetImages:(NSArray *)netImages{
    _netImages = netImages;
    self.cycleScrollView.imageURLStringsGroup = netImages;
}

- (QMUITableView *)tableView {
    if (!_tableView) {
        _tableView = [[QMUITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
