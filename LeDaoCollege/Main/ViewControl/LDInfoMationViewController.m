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
#import "LDVoiceDetailViewcontroller.h"
#import "LDBannerModel.h"
#import "LDShoppingDetailViewController.h"
#import "LDVideoDetailViewController.h"
#import "LDSmallClassDetailViewController.h"

@interface LDInfoMationViewController ()<SDCycleScrollViewDelegate,QMUITableViewDataSource,QMUITableViewDelegate,DFPlayerDataSource>
{
    NSInteger currentPage;
}
@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@property (nonatomic,strong)NSArray<DFPlayerModel *> *musicArray;
@property (nonatomic,strong)NSArray * voiceArray;
@property (nonatomic,assign)BOOL isPlaying;
@property (nonatomic,strong)NSArray * bannerArray;
@property (nonatomic,strong)NSMutableArray * imageArray;
@end

@implementation LDInfoMationViewController
#pragma mark - life cycle
- (instancetype)initWithStyle:(UITableViewStyle)style{
    style = UITableViewStyleGrouped;
    self = [super initWithStyle:style];
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
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
        [self requestMusic];
        [self requestBannerList];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestDatasource];
            [self requestMusic];
        }];
        [self createPlayer];
        
    }
}


- (void)createPlayer{
    [DFPlayer sharedPlayer].dataSource  = self;
    [DFPlayer sharedPlayer].playMode = DFPlayerModeOnlyOnce;
    [DFPlayer sharedPlayer].isObserveWWAN = YES;
    [[DFPlayer sharedPlayer] df_initPlayerWithUserId:nil];
    
}
#pragma  mark - 音频播放
- (NSArray<DFPlayerModel *> *)df_audioDataForPlayer:(DFPlayer *)player{
    return self.musicArray;
}
#pragma mark - NetWork
- (void)requestMusic{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"audio/getaudios" requestParameters:nil requestHeader:nil success:^(id responseObject) {
        self.voiceArray = [NSArray yy_modelArrayWithClass:[LDVoiceModel class] json:responseObject[@"data"][@"list"]];
        LDVoiceModel *model = self.voiceArray.firstObject;
        DFPlayerModel *playModel = [[DFPlayerModel alloc] init];
        playModel.audioId = [model.v_id intValue]-1;
        playModel.audioUrl = [NSURL URLWithString:model.audioUrl];
        
        self.musicArray = @[playModel];
        [self.tableView reloadData];
        [[DFPlayer sharedPlayer] df_reloadData];
    } faild:^(NSError *error) {
        
    }];
}
- (void)requestDatasource {
    QMUITips *tip = [QMUITips showLoadingInView:self.view];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"information/getlists" requestParameters:@{@"pageSize":@(1000),@"type":@(1)} requestHeader:nil success:^(id responseObject) {
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
- (void)requestBannerList {
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"banner/getbytype/1" requestParameters:@{@"type":@"1"} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            NSArray *array = responseObject[@"data"];
            if (![responseObject[@"data"] isKindOfClass:[NSArray class]]) {
                return ;
            }
           self.bannerArray = [NSArray yy_modelArrayWithClass:[LDBannerModel class] json:responseObject[@"data"]];
            self.imageArray = @[].mutableCopy;
            for (NSDictionary *dic in array) {
                NSString *url = dic[@"imgUrl"];
                if ([url containsString:@"http"]) {
                    [self.imageArray addObject:url];
                }else{
                    url = [NSString stringWithFormat:@"%@img/%@",BaseAPI,url];
                    [self.imageArray addObject:url];
                }
            }
            self.netImages = self.imageArray;
        }
    } faild:^(NSError *error) {
        
    }];
}
#pragma  mark - TableView
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return self.isSearchModel?1:2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSearchModel) {
        return self.dataSource.count;
    }else{
        if (section == 0) {
            return 1;
        }
        return self.dataSource.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && self.isSearchModel == NO) {
        LDVoiceTableViewCell *cell = [LDVoiceTableViewCell dequeueReusableWithTableView:tableView];
        if (self.voiceArray) {
            [cell refreshWithModel:self.voiceArray.firstObject];
            cell.playButton.selected = self.isPlaying;
            cell.didSelectPlayMusicActionBlock = ^(BOOL Play) {
                LDVoiceModel *m = self.voiceArray.firstObject;
                m.isPlaying = NO;
                if (Play) { //正在播放
                    [[DFPlayer sharedPlayer]df_pause];
                    self.isPlaying = NO;
                } else {
                    [[DFPlayer sharedPlayer] df_playWithAudioId:0];
                    self.isPlaying = YES;
                }
            };
        }
        
        return cell;
    }else{
        LDNewsTableViewCell *cell = [LDNewsTableViewCell dequeueReusableWithTableView:tableView];
        [cell refreshWithModel:self.dataSource[indexPath.row]];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0 && self.isSearchModel == NO) {
        LDVoiceModel *model = self.voiceArray[indexPath.row];
        LDVoiceDetailViewcontroller * vc = [LDVoiceDetailViewcontroller new];
        vc.title = model.title;
        vc.urlStrng = [NSString stringWithFormat:@"%@?id=%@&token=%@",model.contentUrl,model.v_id,[LDUserManager userID]];
        vc.s_id = model.v_id;
        vc.isCollection = [model.collectionFlag isEqualToString:@"Y"]?YES:NO;
        vc.collectionType = @"2";
        vc.didRefreshCollectionStateBlock = ^(BOOL isCollection) {
            model.collectionFlag = isCollection?@"Y":@"N";
            [tableView reloadData];
        };
        vc.didRefreshPlayStateBlock = ^(BOOL isPlaying) {
            model.isPlaying = isPlaying;
            [tableView reloadData];
        };
        vc.isPlaying = model.isPlaying;
        if (model.isPlaying == NO) {
            for ( LDVoiceModel *m in self.voiceArray) {
                m.isPlaying = NO;
            }
            model.isPlaying = YES;
            [tableView reloadData];
        }
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }else {
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
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && self.isSearchModel == NO) {
        return 90;
    }
    
    return kTableViewCellHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]init];
    if (section == 0 && self.isSearchModel == NO) {
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
    LDBannerModel *model = self.bannerArray[index];
    if ([model.bannerType isEqualToString:@"1"]) {
        LDWebViewViewController * vc = [LDWebViewViewController new];
        vc.urlStrng = [NSString stringWithFormat:@"%@?id=%@&token=%@",model.bannerUrl,model.bannerId,[LDUserManager userID]];
        vc.s_id = model.bannerId;
        vc.collectionType = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.bannerType isEqualToString:@"2"]){
        LDShoppingDetailViewController *vc = [LDShoppingDetailViewController new];
        vc.shopID = model.bannerId;
        vc.collectionType = @"5";
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.bannerType isEqualToString:@"3"]){
        
        LDVideoDetailViewController *vc = [[LDVideoDetailViewController alloc]init];
        vc.videoID = model.bannerId;
        vc.isSmallClass = NO;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([model.bannerType isEqualToString:@"4"]){
        LDWebViewViewController * vc = [LDWebViewViewController new];
        vc.urlStrng = [NSString stringWithFormat:@"%@?id=%@&token=%@",model.bannerUrl,model.bannerId,[LDUserManager userID]];
        vc.s_id = model.bannerId;
        vc.collectionType = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LDSmallClassDetailViewController *vc = [LDSmallClassDetailViewController new];
        vc.videoID = model.bannerId;
        [self.navigationController pushViewController:vc animated:YES];
    }

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
