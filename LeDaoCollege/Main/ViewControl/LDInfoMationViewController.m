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
#import "DFPlayer.h"
#import "LDVoiceTableViewCell.h"

@interface LDInfoMationViewController ()<SDCycleScrollViewDelegate,QMUITableViewDataSource,QMUITableViewDelegate,DFPlayerDataSource>
{
    NSInteger currentPage;
}
@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@property (nonatomic,strong)NSArray<DFPlayerModel *> *musicArray;
@end

@implementation LDInfoMationViewController
#pragma mark - life cycle
- (instancetype)initWithStyle:(UITableViewStyle)style{
    style = UITableViewStyleGrouped;
    self = [super initWithStyle:style];
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.netImages = @[];
    currentPage = 0;
    [self masLayoutSubviews];
    if (!self.isSearchModel) {
        [self requestDatasource];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestDatasource];
        }];
    }
    
}
- (void)createPlayer{
//    [DFPlayer sharedPlayer].category    = DFPlayerModeOnlyOnce;
    [DFPlayer sharedPlayer].playMode = DFPlayerModeOnlyOnce;
    [DFPlayer sharedPlayer].isObserveWWAN = YES;
    [[DFPlayer sharedPlayer] df_initPlayerWithUserId:nil];

}
#pragma  mark - 音频播放
- (NSArray<DFPlayerModel *> *)df_audioDataForPlayer:(DFPlayer *)player{
    return self.musicArray;
}
#pragma mark - NetWork
- (void)requestDatasource {
    QMUITips *tip = [QMUITips showLoadingInView:self.view];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"information/getlists" requestParameters:@{@"pageSize":@(1000)} requestHeader:nil success:^(id responseObject) {
        [tip hideAnimated:YES];
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDNewsModel class] json:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
            
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
    QMUITips *tip = [QMUITips showLoadingInView:self.view];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"information/getlists" requestParameters:@{@"title":title,@"pageSize":@(1000)} requestHeader:nil success:^(id responseObject) {
        [tip hideAnimated:YES];
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDNewsModel class] json:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
            if (blcok) {
                blcok(self.dataSource.count);
            }
        }else{
            [tip hideAnimated:YES];
            [QMUITips showError:@"网络错误,请稍微再试"];
        }
    } faild:^(NSError *error) {
        [tip hideAnimated:YES];
        [QMUITips showError:@"网络错误,请稍微再试"];
    }];
}

#pragma  mark - TableView
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LDVoiceTableViewCell *cell = [LDVoiceTableViewCell dequeueReusableWithTableView:tableView];
        return cell;
    }
    LDNewsTableViewCell *cell = [LDNewsTableViewCell dequeueReusableWithTableView:tableView];
    [cell refreshWithModel:self.dataSource[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        
        return;
    }
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
    if (indexPath.section == 0) {
        return 90;
    }
    return 120;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]init];
    if (section == 0) {
    label.text = @"每日播报";
    }else{
        label.text = @"聚合资讯";
    }
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).mas_offset(18.5);
        make.bottom.mas_equalTo(view).mas_offset(-8);
    }];
    label.font = [UIFont boldSystemFontOfSize:18];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
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
            make.top.mas_equalTo(self.view);
            if (@available(iOS 11.0, *)) {
                make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.mas_equalTo(self.view);
            }
        }];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
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
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, 180);
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
        _cycleScrollView.imageURLStringsGroup = self.netImages;
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.currentPageDotColor = MainThemeColor;
        _cycleScrollView.pageDotColor = [UIColor whiteColor];
    }
    return _cycleScrollView;
}
- (void)setNetImages:(NSArray *)netImages{
    _netImages = netImages;
    self.cycleScrollView.imageURLStringsGroup = netImages;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
