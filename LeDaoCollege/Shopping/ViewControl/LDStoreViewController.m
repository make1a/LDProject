//
//  LDStoreViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDStoreViewController.h"
#import <VTMagic/VTMagic.h>
#import "SDCycleScrollView.h"
#import "LDStoreSearchViewController.h"

#import "LDInfoMationViewController.h"
#import "LDVoiceViewController.h"
#import "LDVideoViewController.h"
#import "LDLiveViewController.h"


@interface LDStoreViewController ()<SDCycleScrollViewDelegate,VTMagicViewDelegate,VTMagicViewDataSource>
@property (nonatomic, strong)VTMagicController *magicController;
@property (nonatomic,strong)UIButton * searchButton;
@property (nonatomic,strong)NSArray * netImages;
@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@end

@implementation LDStoreViewController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self masLayoutSubviews];
    [self configMagicController];
}
#pragma  mark - ConfigUI
- (void)configMagicController{
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    [self.magicController.magicView reloadData];
}
- (void)masLayoutSubviews{
    [self.view addSubview:self.searchButton];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(PtWidth(21));
        make.right.mas_equalTo(self.view).mas_offset(PtWidth(-21));
        
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(10);
        } else {
            make.top.mas_equalTo(self.view);

        }
        make.height.mas_equalTo(PtHeight(32));
    }];
    
}
#pragma mark - event response
- (void)clickSearchAction:(UIButton *)sender {
    LDStoreSearchViewController *vc = [LDStoreSearchViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - VTMagicViewDelegate
- (NSArray<__kindof NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView{
    return @[@"资讯",@"音频",@"视频",@"直播"];
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
            static NSString *identifier = @"LDInfoMationViewController.identifier";
            LDInfoMationViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDInfoMationViewController alloc] init];
            }
            return vc;
        }
            break;
        case 1:
        {
            static NSString *identifier = @"LDVoiceViewController.identifier";
            LDVoiceViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDVoiceViewController alloc] init];
            }
            return vc;
        }
            break;
        case 2:
        {
            static NSString *identifier = @"LDVideoViewController.identifier";
            LDVideoViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDVideoViewController alloc] init];
            }
            return vc;
        }
            break;
        default:
        {
            static NSString *identifier = @"LDLiveViewController.identifier";
            LDLiveViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDLiveViewController alloc] init];
            }
            return vc;
        }
            break;
    }
}

- (nonnull UIButton *)magicView:(nonnull VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:UIColorFromRGBA(145, 226, 192, 1) forState:UIControlStateNormal];
        [menuItem setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return menuItem;
}
#pragma  mark - SDCyclesScrollview
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}
#pragma mark - private method

#pragma mark - get and set
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        UIImage * placeholderImage = [UIImage imageNamed:@"blank_common"];
        CGRect frame = CGRectMake(PtWidth(20), 0, PtWidth(335), PtHeight(120));
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
        _cycleScrollView.imageURLStringsGroup = self.netImages;
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.layer.masksToBounds = YES;
        _cycleScrollView.layer.cornerRadius = 5;
    }
    return _cycleScrollView;
}

-(NSArray *)netImages{
    
    if (!_netImages) {
        _netImages = @[
                       @"http://d.hiphotos.baidu.com/zhidao/pic/item/72f082025aafa40f507b2e99aa64034f78f01930.jpg",
                       @"http://b.hiphotos.baidu.com/zhidao/pic/item/4b90f603738da9770889666fb151f8198718e3d4.jpg",
                       @"http://g.hiphotos.baidu.com/zhidao/pic/item/f2deb48f8c5494ee4e84ef5d2cf5e0fe98257ed4.jpg",
                       @"http://d.hiphotos.baidu.com/zhidao/pic/item/9922720e0cf3d7ca104edf32f31fbe096b63a93e.jpg"
                       ];
    }
    return _netImages;
}
- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor clearColor];
        _magicController.magicView.navigationHeight = PtHeight(35);
        _magicController.magicView.sliderHidden = NO;

        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PtWidth(20), 5)];
        view.backgroundColor = [UIColor whiteColor];
        [view setCornerRadius:5.0/2];
        [_magicController.magicView setSliderView:view];
        _magicController.magicView.sliderWidth = PtWidth(20);
        _magicController.magicView.sliderHeight = 5;
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.itemSpacing = 20;
        _magicController.magicView.frame = CGRectMake(0,PtHeight(91), SCREEN_WIDTH, SCREEN_HEIGHT-PtHeight(91)-TabBarHeight);
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        _magicController.magicView.needPreloading = NO;
        _magicController.magicView.separatorHidden = YES;
    }
    return _magicController;
}
- (UIButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.backgroundColor = UIColorFromHEXA(0xFBFBFB, 1);
        _searchButton.layer.masksToBounds = YES;
        _searchButton.layer.cornerRadius = PtHeight(32/2);
        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchButton setTitleColor:UIColorFromRGBA(165, 165, 165, 1) forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(clickSearchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
