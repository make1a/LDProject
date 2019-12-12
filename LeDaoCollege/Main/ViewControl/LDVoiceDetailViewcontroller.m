//
//  LDVoiceDetailViewcontroller.m
//  LeDaoCollege
//
//  Created by Make on 2019/12/11.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDVoiceDetailViewcontroller.h"
#import "DFPlayer.h"
#import <UMShare/UMShare.h>
#import "LDVoiceModel.h"
#define HDFGreenColor  [UIColor colorWithRed:66.0/255.0 green:196.0/255.0 blue:133.0/255.0 alpha:1]

@interface LDVoiceDetailViewcontroller()<DFPlayerDelegate>
@property (nonatomic,strong)UIImageView * bigImageView;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)NSArray * musicArray;
@property (nonatomic,strong)UIWebView * webview;
@end
@implementation LDVoiceDetailViewcontroller
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNavbutton];
    [self createMusicPlayer];
    [self maslayoutSubviews];
    [self reqeustDatsSource];
}
- (void)createNavbutton{
    QMUINavigationButton *button = [QMUINavigationButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"collect_default"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"collect_sele"] forState:UIControlStateSelected];
    
    UIBarButtonItem *collectionButton = [UIBarButtonItem qmui_itemWithButton:button target:self action:@selector(clickCollectionAction:)];
    UIBarButtonItem *shareButton = [UIBarButtonItem qmui_itemWithImage:[UIImage imageNamed:@"share_default"] target:self action:@selector(clickShareAction)];
    self.navigationItem.rightBarButtonItems = @[shareButton,collectionButton];
    
    if (self.isCollection) {
        button.selected = YES;
    }
}
- (void)createMusicPlayer{
    [DFPlayer shareInstance].delegate    = self;

    DFPlayerControlManager *manager = [DFPlayerControlManager shareInstance];
    
    //进度条
    [manager df_sliderWithFrame:CGRectMake(PtWidth(56.5), PtHeight(115.5), PtWidth(262), PtHeight(40)) minimumTrackTintColor:HDFGreenColor maximumTrackTintColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0] trackHeight:4 thumbSize:(CGSizeMake(25, 25)) superView:self.view];
    //当前时间
    UILabel *curLabel = [manager df_currentTimeLabelWithFrame:CGRectMake(PtWidth(20), PtHeight(129.5), PtWidth(33.5), PtHeight(9.5)) superView:self.view];
    curLabel.textColor = [UIColor blackColor];
    curLabel.font = [UIFont systemFontOfSize:PtHeight(9.5)];
    //总时间
    UILabel *totLabel = [manager df_totalTimeLabelWithFrame:CGRectMake(PtWidth(321.5), PtHeight(129.5), PtWidth(33.5), PtHeight(9.5)) superView:self.view];
    totLabel.textColor = [UIColor blackColor];
    totLabel.font = [UIFont systemFontOfSize:PtHeight(9.5)];
    
    _weakself;
    //播放模式按钮
    [manager df_playPauseBtnWithFrame:CGRectMake(PtWidth(67.5), PtHeight(33.5), PtWidth(47), PtWidth(47)) superView:self.view block:^{
        if ([DFPlayer shareInstance].state == DFPlayerStatePlaying) {
            weakself.didRefreshPlayStateBlock(YES);
        }else if ([DFPlayer shareInstance].state == DFPlayerStatePause){
            weakself.didRefreshPlayStateBlock(NO);
        }
    }];
    
    if (self.isPlaying) {
        [[DFPlayer shareInstance]df_audioPlay];
    }else{
        [[DFPlayer shareInstance]df_playerPlayWithAudioId:[self.s_id intValue]];
    }
}

#pragma  mark - ACtion
- (void)clickShareAction{
    QMUIMoreOperationController *moreOperationController = [[QMUIMoreOperationController alloc] init];
    moreOperationController.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *array = @[].mutableCopy;
    
    QMUIMoreOperationItemView *wx = [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"wechat") title:@"分享给微信好友" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
        [self share:UMSocialPlatformType_WechatSession];
        [moreOperationController hideToBottom];
    }];
    QMUIMoreOperationItemView *wxp = [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"pyq") title:@"分享到朋友圈" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
        [self share:UMSocialPlatformType_WechatTimeLine];
        [moreOperationController hideToBottom];
    }];
    QMUIMoreOperationItemView *sina = [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"weibo") title:@"分享到微博" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
        [self share:UMSocialPlatformType_Sina];
        [moreOperationController hideToBottom];
    }];
    if ([[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatSession]) {
        [array addObject:wx];
        [array addObject:wxp];
    }
    if ([[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_Sina]) {
        [array addObject:sina];
    }
    moreOperationController.items = @[array];
    [moreOperationController showFromBottom];
}
- (void)share:(UMSocialPlatformType)shareType{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UIImage *image = [UIImage imageNamed:@"ledao_logo_2"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"乐道分享" descr:nil thumImage:image];
    //设置网页地址
    shareObject.webpageUrl = self.urlStrng;
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:shareType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            NSLog(@"%@",data);
        }
    }];
}
- (void)clickCollectionAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    [self requestCollection:self.s_id collection:sender.selected];
}
#pragma  mark - 音频
//播放进度代理
- (void)df_player:(DFPlayer *)player progress:(CGFloat)progress currentTime:(CGFloat)currentTime totalTime:(CGFloat)totalTime{
    NSLog(@"%@",[NSString stringWithFormat:@"当前进度%lf--当前时间%.0f--总时长%.0f",progress,currentTime,totalTime]);
}
- (void)df_player:(DFPlayer *)player bufferProgress:(CGFloat)bufferProgress totalTime:(CGFloat)totalTime{
    NSLog(@"%@",[NSString stringWithFormat:@"正在缓冲%lf",bufferProgress]);
}
#pragma  mark - Request
- (void)requestCollection:(NSString *)collectionID collection:(BOOL)isCollection{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:@"collection/addanddelete" requestParameters:@{@"collectionId":collectionID,@"collectionType":self.collectionType} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            [QMUITips showSucceed:responseObject[@"returnMsg"]];
            if (isCollection && self.didRefreshCollectionStateBlock) {
                self.didRefreshCollectionStateBlock(isCollection);
            }
        }
    } faild:^(NSError *error) {
        
    }];
}
- (void)reqeustDatsSource{
    NSDictionary *dic = @{@"id":self.s_id};
    NSString *url = [NSString stringWithFormat:@"audio/getaudio/%@",self.s_id];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:url requestParameters:dic requestHeader:nil
                                        success:^(id responseObject) {
        if (kCODE == 200) {
            LDVoiceModel *model = [LDVoiceModel yy_modelWithJSON:responseObject[@"data"]];
            self.titleLabel.text = model.title;
            self.timeLabel.text = model.createdDate;
                if ([model.coverImg containsString:@"http"]) {
                [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:model.coverImg] placeholderImage:[UIImage imageNamed:@"seizeaseat_0"]];
            }else{
                [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@img/%@",BaseAPI,model.coverImg]] placeholderImage:[UIImage imageNamed:@"seizeaseat_0"]];
            }
            
//            [[DFPlayer shareInstance] df_playerPlayWithAudioId:[model.v_id intValue]];
            
            [self.webview loadHTMLString:model.audioContent baseURL:nil];
        }
    } faild:^(NSError *error) {
        
    }];
}

- (void)maslayoutSubviews{
    [self.view addSubview:self.bigImageView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.webview];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(PtHeight(172));
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    [self.bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(PtWidth(18));
        make.top.mas_equalTo(self.view).mas_offset(PtHeight(16));
        make.width.mas_equalTo(PtWidth(144));
        make.height.mas_equalTo(PtHeight(80));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bigImageView);
        make.left.mas_equalTo(self.bigImageView.mas_right).mas_offset(PtWidth(14));
        make.right.mas_equalTo(self.view).mas_offset(-PtWidth(20));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(PtHeight(10));
    }];
    [self.view sendSubviewToBack:self.bigImageView];
}
#pragma  mark - GET SET
- (UIImageView *)bigImageView{
    if (!_bigImageView) {
        _bigImageView = [[UIImageView alloc]init];
        _bigImageView.image = [UIImage imageNamed:@"seizeaseat_0"];

    }
    return _bigImageView;
}
- (UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:PtHeight(15)]];
        [_titleLabel setTextColor:[UIColor blackColor]];
        _titleLabel.text = @"中央银行出台数字货币,市场反响";
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}
- (UILabel *)timeLabel
{
    if(!_timeLabel)
    {
        _timeLabel = [[UILabel alloc] init];
        [_timeLabel setFont:[UIFont systemFontOfSize:PtHeight(12)]];
        [_timeLabel setTextColor:[UIColor darkGrayColor]];
        _timeLabel.text = @"2019-12-12 10:44";
    }
    return _timeLabel;
}
- (UIWebView *)webview{
    if (!_webview) {
        _webview = [[UIWebView alloc]init];
        _webview.backgroundColor = [UIColor whiteColor];
    }
    return _webview;
}
@end
