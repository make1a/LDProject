//
//  LDVoiceListViewController.m
//  LeDaoCollege
//
//  Created by make on 2019/12/8.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDVoiceListViewController.h"
#import "LDVoiceTableViewCell.h"
#import "LDVoiceModel.h"
#import "LDWebViewViewController.h"
#import "LDVoiceDetailViewcontroller.h"
#import <SDCycleScrollView.h>
#import "DFPlayer.h"
@interface LDVoiceListViewController ()<SDCycleScrollViewDelegate,DFPlayerDataSource>
@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@property (nonatomic,strong)NSMutableArray * musicArray;
@property (nonatomic,strong)NSArray * playArray;

@property (nonatomic,assign)NSInteger currenIndex;

@end

@implementation LDVoiceListViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [DFPlayer sharedPlayer].dataSource  = self;
    [[DFPlayer sharedPlayer]df_reloadData];
    if (!_isSearchModel) {
        [self requestSource:@"" mark:@"" back:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.cycleScrollView;
    [self createPlayer];
    self.currenIndex = -1;

    if (!_isSearchModel) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self requestSource:@"" mark:@"" back:nil];
        }];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pauseRefresh) name:@"playerPause" object:nil];
}
- (void)createPlayer{
//    [DFPlayer sharedPlayer].category    = DFPlayerModeOnlyOnce;
    [DFPlayer sharedPlayer].playMode = DFPlayerModeOnlyOnce;
    [DFPlayer sharedPlayer].isObserveWWAN = YES;
    [[DFPlayer sharedPlayer] df_initPlayerWithUserId:nil];

}
- (void)pauseRefresh{
    for ( LDVoiceModel *m in self.dataSource) {
        m.isPlaying = NO;
    }
    self.currenIndex = -1;
    [self.tableView reloadData];
}
#pragma  mark - Request
- (void)requestSource:(NSString *)title mark:(NSString *)mark back:(backSourceCountBlock)blcok{
    QMUITips *tip = [QMUITips showLoadingInView:self.view];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"audio/getaudios" requestParameters:@{@"title":title,@"pageSize":@1000} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDVoiceModel class] json:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
            if (blcok) {
                blcok(self.dataSource.count);
            }
            self.musicArray = @[].mutableCopy;
            for (LDVoiceModel *model in self.dataSource) {
                DFPlayerModel *playModel = [[DFPlayerModel alloc] init];
                playModel.audioId = [model.v_id intValue];
                playModel.audioUrl = [self translateIllegalCharacterWtihUrlStr:model.audioUrl];
                [self.musicArray addObject:playModel];
            }
            [[DFPlayer sharedPlayer] df_reloadData];
            [tip hideAnimated:YES];
        }else{
            [tip hideAnimated:YES];
            [QMUITips showError:@"网络错误,请稍微再试"];
        }
        [self.tableView.mj_header endRefreshing];
    }faild:^(NSError *error) {
        [tip hideAnimated:YES];
        [QMUITips showError:@"网络错误,请稍微再试"];
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)requestCollection:(LDVoiceModel*)model index:(NSInteger)index{
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
- (NSURL *)translateIllegalCharacterWtihUrlStr:(NSString *)yourUrl{
    //如果链接中存在中文或某些特殊字符，需要通过以下代码转译
    //    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)yourUrl, (CFStringRef)@"!NULL,'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
    return [NSURL URLWithString:yourUrl];
}
#pragma  mark - 音频播放
- (NSArray<DFPlayerModel *> *)df_audioDataForPlayer:(DFPlayer *)player{
    return self.musicArray;
}
#pragma  mark - SDCyclesScrollview
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}
#pragma  mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDVoiceTableViewCell *cell = [LDVoiceTableViewCell dequeueReusableWithTableView:tableView];
    LDVoiceModel *model = self.dataSource[indexPath.row];
    if (self.currenIndex == indexPath.row) {
        model.isPlaying = YES;
    }else{
        model.isPlaying = NO;
    }
    [cell refreshWithModel:model];
    _weakself;
    cell.didSelectCollectionActionBlock = ^{
        [weakself requestCollection:model index:indexPath.row];
    };
    cell.didSelectPlayMusicActionBlock = ^(BOOL Play) {
        weakself.currenIndex = indexPath.row;
        model.isPlaying = Play;
        for ( LDVoiceModel *m in self.dataSource) {
            m.isPlaying = NO;
        }
        if (Play) { //正在播放
            [[DFPlayer sharedPlayer]df_pause];
        } else {
            DFPlayerModel *playModel = self.musicArray[indexPath.row];
            [[DFPlayer sharedPlayer] df_playWithAudioId:playModel.audioId];
            model.isPlaying = YES;
        }
        [tableView reloadData];
    };
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return PtHeight(87);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LDVoiceModel *model = self.dataSource[indexPath.row];
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
        for ( LDVoiceModel *m in self.dataSource) {
            m.isPlaying = NO;
        }
        model.isPlaying = YES;
        [tableView reloadData];
    }
    self.currenIndex = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma  mark - GET SET
- (void)setNetImages:(NSArray *)netImages{
    _netImages = netImages;
    self.cycleScrollView.imageURLStringsGroup = netImages;
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        UIImage * placeholderImage = [UIImage imageNamed:@"seizeaseat_1"];
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*9/16);
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
        _cycleScrollView.imageURLStringsGroup = self.netImages;
        _cycleScrollView.showPageControl = YES;
    }
    return _cycleScrollView;
}
@end
