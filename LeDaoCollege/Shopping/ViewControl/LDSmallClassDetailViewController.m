//
//  LDSmallClassDetailViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/23.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDSmallClassDetailViewController.h"
#import "LDShoppingDetailFootView.h"
#import "LDShoppingDetailNameViewCell.h"
#import "LDSmallClassDetailHeadView.h"
#import "LDSmallClassDetailIntroCell.h"
#import "LDSmallClassLessonCell.h"
#import "LDSmallClassSectionDetailViewController.h"
#import "LDClassModel.h"
#import "LDCommitBuyViewController.h"
#import "LDNoUseView.h"

#import <SJVideoPlayer/SJVideoPlayer.h>
#import <VTMagic/VTMagic.h>
#import "LDCatalogViewController.h"
#import "LDVideoDetailContenViewController.h"
#import "LDVideoModel.h"
#import "LDShoppingDetailFootView.h"
#import "LDCommitBuyViewController.h"
#import <UMShare/UMShare.h>
#import "DFPlayer.h"
#import "LDClassCatalogViewController.h"

@interface LDSmallClassDetailViewController ()<VTMagicViewDataSource,VTMagicViewDelegate>
{
    UIView *_bgView;
}
@property (nonatomic, strong) SJVideoPlayer *player;
@property (nonatomic, strong)VTMagicController *magicController;
@property (nonatomic,strong)LDClassModel * currenModel;
@property (nonatomic,strong)LDShoppingDetailFootView * footView;
@property (nonatomic,strong)UILabel * freeLabel;
@end

@implementation LDSmallClassDetailViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[DFPlayer sharedPlayer]df_deallocPlayer];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"playerPause" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configPlayer];
    [self createMagic];
    [self createFootView];
    [self requestDtasource];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.player stop];
    self.player = nil;
}
- (void)reload{
    [self configPlayer];
    [self requestDtasource];
}
- (void)configPlayer{
    UIView *bgView = [[UIView alloc]init];
    bgView.contentMode = UIViewContentModeScaleToFill;
    
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuide);
        } else {
            make.top.mas_equalTo(self.view).offset(20);
        }
        make.height.mas_equalTo(SCREEN_WIDTH*9.0/16.0);
    }];
    _bgView = bgView;
    [bgView addSubview:self.player.view];
    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
//    SJEdgeControlButtonItem *item = [[SJEdgeControlButtonItem alloc] initWithImage:[UIImage imageNamed:@"share_default"] target:self action:@selector(shareAction) tag:100];
//    [_player.defaultEdgeControlLayer.topAdapter addItem:item];
//    [_player.defaultEdgeControlLayer.topAdapter reload];
    
    __weak typeof(self) _self = self;
    _player.controlLayerAppearObserver.appearStateDidChangeExeBlock = ^(id<SJControlLayerAppearManager>  _Nonnull mgr) {
        __strong typeof(_self) self = _self;
        if ( !self ) return ;
        self.player.popPromptController.bottomMargin = mgr.isAppeared ? self.player.defaultEdgeControlLayer.bottomContainerView.bounds.size.height : 16;
    };
    
    self.player.playbackObserver.didPlayToEndTimeExeBlock = ^(__kindof SJBaseVideoPlayer * _Nonnull player) {
        [[DFPlayer sharedPlayer]df_deallocPlayer];
    };
    
    [self->_bgView addSubview:self.freeLabel];
    [self.freeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self->_bgView);
        make.centerY.mas_equalTo(self->_bgView);
    }];
}
- (void)createMagic{
    CGFloat maxY = kSTATUSBAR_HEIGHT+ SCREEN_WIDTH*9.0/16.0;
    self.magicController.magicView.frame = CGRectMake(0,maxY, SCREEN_WIDTH, SCREEN_HEIGHT-maxY-PtHeight(40));
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    [self.magicController.magicView reloadData];
}
- (void)createFootView{
    [self.view addSubview:self.footView];
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view);
        }
        make.height.mas_equalTo(PtHeight(40));
    }];
}
- (void)requestDtasource{
    if (!self.videoID) {
        return;
    }
    NSString *api = [NSString stringWithFormat:@"course/getcourseinfo/%@",self.videoID];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:api requestParameters:@{@"id":self.videoID} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            LDClassModel *model = [LDClassModel yy_modelWithJSON:responseObject[@"data"]];
            self.currenModel = model;
            [self.magicController.magicView reloadData];
            if ([model.coverImg containsString:@"http"]) {
                [self.player.presentView.placeholderImageView sd_setImageWithURL:[NSURL URLWithString:model.coverImg] placeholderImage:[UIImage imageNamed:@"seizeaseat_0"]];
            }else{
                [self.player.presentView.placeholderImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@img/%@",BaseAPI,model.coverImg]] placeholderImage:[UIImage imageNamed:@"seizeaseat_0"]];
            }
            LDClassChapterModel *chapterModel = self.currenModel.chapterArray.firstObject;
            LDClassChapterSectionModel *detailMdel = chapterModel.sectionArray.firstObject;
            if (detailMdel) {
                if (![self.currenModel.isPayFlag isEqualToString:@"Y"] ) {
                    self.freeLabel.hidden = NO;
                    if ([detailMdel.isFreeFlag isEqualToString:@"Y"]) {
                        SJVideoPlayerURLAsset *asset1 = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:detailMdel.sectionContent]];
                        self.player.URLAsset = asset1;
                        self.freeLabel.hidden = YES;
                        self.footView.buyButton.hidden = YES;
                    }
                }else {
                    SJVideoPlayerURLAsset *asset1 = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:detailMdel.sectionContent]];
                    self.player.URLAsset = asset1;
                    self.freeLabel.hidden = YES;
                    self.footView.buyButton.hidden = YES;
                }
            }
            self.footView.collectionButton.selected = [model.collectionFlag isEqualToString:@"Y"]?YES:NO;
        }
    } faild:^(NSError *error) {
        
    }];
}

- (void)collectionAction{
    if (self.videoID.length == 0) {
        return;
    }
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:@"collection/addanddelete" requestParameters:@{@"collectionId":self.videoID,@"collectionType":@"2"} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            [QMUITips showSucceed:responseObject[@"returnMsg"]];
            if ([self.currenModel.collectionFlag isEqualToString:@"N"]) {
                self.currenModel.collectionFlag = @"Y";
            } else {
                self.currenModel.collectionFlag = @"N";
            }
        }
    } faild:^(NSError *error) {
        
    }];
}
#pragma  mark - ACtion
//- (void)shareAction{
//    QMUIMoreOperationController *moreOperationController = [[QMUIMoreOperationController alloc] init];
//    moreOperationController.view.backgroundColor = [UIColor whiteColor];
//    NSMutableArray *array = @[].mutableCopy;
//
//    QMUIMoreOperationItemView *wx = [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"wechat") title:@"分享给微信好友" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
//        [self share:UMSocialPlatformType_WechatSession];
//        [moreOperationController hideToBottom];
//    }];
//    QMUIMoreOperationItemView *wxp = [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"pyq") title:@"分享到朋友圈" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
//        [self share:UMSocialPlatformType_WechatTimeLine];
//        [moreOperationController hideToBottom];
//    }];
//    QMUIMoreOperationItemView *sina = [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"weibo") title:@"分享到微博" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
//        [self share:UMSocialPlatformType_Sina];
//        [moreOperationController hideToBottom];
//    }];
//    if ([[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatSession]) {
//        [array addObject:wx];
//        [array addObject:wxp];
//    }
//    if ([[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_Sina]) {
//        [array addObject:sina];
//    }
//    moreOperationController.items = @[array];
//    [moreOperationController showFromBottom];
//
//}
- (void)clickBuyAction:(id)sender {
    LDCommitBuyViewController *vc = [[LDCommitBuyViewController alloc]initWithNibName:@"LDCommitBuyViewController" bundle:[NSBundle mainBundle]];
    vc.currentModel = self.currenModel;
    vc.title = @"确认购买";
    vc.goodsId = self.currenModel.c_id;
    vc.goodsType = @"4";
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)clickCollectionAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    [self collectionAction];
}


//- (void)share:(UMSocialPlatformType)shareType{
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    UIImage *image = [UIImage imageNamed:@"ledao_logo_2"];
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"乐道分享" descr:nil thumImage:image];
//    //设置网页地址
//        shareObject.webpageUrl = [NSString stringWithFormat:@"%@?id=%@",self.currenModel.contentUrl,self.currenModel.c_id];
//    messageObject.shareObject = shareObject;
//
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:shareType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
//        if (error) {
//            NSLog(@"%@",error);
//        }else{
//            NSLog(@"%@",data);
//        }
//    }];
//}
#pragma  mark - 屏幕移动
- (BOOL)prefersStatusBarHidden {
    return [self.player vc_prefersStatusBarHidden];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.player vc_preferredStatusBarStyle];
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

#pragma mark - VTMagicViewDelegate
- (NSArray<__kindof NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView{
    return @[@"简介",@"目录"];
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex
{
    
}

// 设置菜单栏上面的每个按钮对应的VC
- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    switch (pageIndex) {
        case 0:
        {
            static NSString *identifier = @"LDVideoDetailContenViewController.identifier";
            LDVideoDetailContenViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDVideoDetailContenViewController alloc] init];
            }
            vc.currentModel = self.currenModel;
            [vc.tableView reloadData];
            return vc;
        }
            break;
        default:
        {
            static NSString *identifier = @"LDClassCatalogViewController.identifier";
            LDClassCatalogViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDClassCatalogViewController alloc] init];
                _weakself;
                vc.didSelectBlock = ^(NSIndexPath *indexPath) {
                    LDClassChapterModel *chapterModel = self.currenModel.chapterArray[indexPath.section];
                    LDClassChapterSectionModel *detailMdel = chapterModel.sectionArray[indexPath.row];
                    if ([detailMdel.isFreeFlag isEqualToString:@"Y"] || [self.currenModel.isPayFlag isEqualToString:@"Y"] ) {
                        SJVideoPlayerURLAsset *asset1 = [[SJVideoPlayerURLAsset alloc] initWithURL:[NSURL URLWithString:detailMdel.sectionContent]];
                        weakself.player.URLAsset = asset1;
                        self.freeLabel.hidden = YES;
                    }else{
                        self.freeLabel.hidden = NO;
                    }
                };
                vc.currenModel = self.currenModel;
                [vc.tableView reloadData];
            }
            return vc;
            break;
        }
    }
}

- (nonnull UIButton *)magicView:(nonnull VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [menuItem setTitleColor:UIColorFromHEXA(0x69B681, 1.0) forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return menuItem;
}
#pragma  mark - GET SET
- (SJVideoPlayer *)player {
    if (!_player) {
        _player = [SJVideoPlayer player];
        _player.rotationManager.disabledAutorotation = YES;
        _player.defaultEdgeControlLayer.showResidentBackButton = YES;
        _player.autoplayWhenSetNewAsset = NO;
    }
    return _player;
}
- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor clearColor];
        _magicController.magicView.navigationHeight = PtHeight(50);
        _magicController.magicView.sliderHidden = NO;
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PtWidth(20), 5)];
        view.backgroundColor = UIColorFromHEXA(0x69B681, 1.0);
        [view setCornerRadius:5.0/2];
        [_magicController.magicView setSliderView:view];
        _magicController.magicView.sliderWidth = PtWidth(20);
        _magicController.magicView.sliderHeight = 5;
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.itemSpacing = 20;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        _magicController.magicView.needPreloading = NO;
        _magicController.magicView.separatorHidden = YES;
    }
    return _magicController;
}
- (LDShoppingDetailFootView *)footView {
    if (!_footView) {
        _footView = [[NSBundle mainBundle]loadNibNamed:@"LDShoppingDetailFootView" owner:self options:nil].firstObject;
        [_footView.collectionButton addTarget:self action:@selector(clickCollectionAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footView.buyButton addTarget:self action:@selector(clickBuyAction:) forControlEvents:UIControlEventTouchUpInside];
        _footView.qmui_borderPosition = QMUIViewBorderPositionTop;
    }
    return _footView;
}
- (UILabel *)freeLabel{
    if (!_freeLabel) {
        _freeLabel = [[UILabel alloc]init];
        _freeLabel.textColor = [UIColor whiteColor];
        _freeLabel.font = [UIFont systemFontOfSize:16];
        _freeLabel.text = @"请购买后观看";
        _freeLabel.backgroundColor = [UIColor blackColor];
    }
    return _freeLabel;
}
@end
