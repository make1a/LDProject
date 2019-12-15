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
@interface LDVoiceListViewController ()<SDCycleScrollViewDelegate,DFPlayerDelegate,DFPlayerDataSource>
@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@property (nonatomic,strong)NSMutableArray * musicArray;
@property (nonatomic,strong)NSArray * playArray;
@end

@implementation LDVoiceListViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.cycleScrollView;
    [self createPlayer];
    [self requestSource:@"" mark:@"" back:nil];
}
- (void)createPlayer{
    [DFPlayer shareInstance].dataSource  = self;
    [DFPlayer shareInstance].delegate    = self;
    [DFPlayer shareInstance].category    = DFPlayerAudioSessionCategoryPlayback;
    [DFPlayer shareInstance].isObserveWWAN = YES;
    [[DFPlayer shareInstance] df_initPlayerWithUserId:nil];
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
            [[DFPlayer shareInstance] df_reloadData];
        }else{
            [tip hideAnimated:YES];
            [QMUITips showError:@"网络错误,请稍微再试"];
        }
    }faild:^(NSError *error) {
        [tip hideAnimated:YES];
        [QMUITips showError:@"网络错误,请稍微再试"];
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
- (NSArray<DFPlayerModel *> *)df_playerModelArray{
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
    [cell refreshWithModel:model];
    _weakself;
    cell.didSelectCollectionActionBlock = ^{
        [weakself requestCollection:model index:indexPath.row];
    };
    cell.didSelectPlayMusicActionBlock = ^(BOOL Play) {
        model.isPlaying = Play;
        for ( LDVoiceModel *m in self.dataSource) {
            m.isPlaying = NO;
        }
        if (Play) { //正在播放
            [[DFPlayer shareInstance]df_audioPause];
        } else {
            DFPlayerModel *playModel = self.musicArray[indexPath.row];
            [[DFPlayer shareInstance] df_playerPlayWithAudioId:playModel.audioId];
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
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, PtHeight(160));
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
        _cycleScrollView.imageURLStringsGroup = self.netImages;
        _cycleScrollView.showPageControl = YES;
    }
    return _cycleScrollView;
}
@end
