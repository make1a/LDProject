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
    vc.urlStrng = [NSString stringWithFormat:@"%@?id=%@&token=%@",model.contentUrl,model.newsId,[LDUserManager userID]];
    vc.s_id = model.newsId;
    vc.isCollection = [model.collectionFlag isEqualToString:@"Y"]?YES:NO;
    vc.collectionType = @"1";
    vc.title = model.title;
    vc.didRefreshCollectionStateBlock = ^(BOOL isCollection) {
        model.collectionFlag = isCollection?@"Y":@"N";
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return PtHeight(87);
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
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(PtWidth(0));
            make.right.mas_equalTo(self.view).mas_offset(PtWidth(0));
            make.top.mas_equalTo(self.view).mas_offset(10);
            if (@available(iOS 11.0, *)) {
                make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.mas_equalTo(self.view);
            }
        }];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PtHeight(160))];
        [view addSubview:self.cycleScrollView];
        self.tableView.tableHeaderView = view;
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
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, PtHeight(160));
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
        //        _tableView.
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
