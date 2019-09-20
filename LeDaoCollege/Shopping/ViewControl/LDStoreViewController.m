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


#import "LDAllshoppingViewController.h"
#import "LDToolBooksViewController.h"
#import "LDSmallClassViewController.h"

#import "LDShoppingHeadView.h"
@interface LDStoreViewController ()<SDCycleScrollViewDelegate,VTMagicViewDelegate,VTMagicViewDataSource>
@property (nonatomic, strong)VTMagicController *magicController;
@property (nonatomic,strong)UIButton * searchButton;
@property (nonatomic,strong)NSArray * netImages;
@property (nonatomic,strong)LDShoppingHeadView * headView;
@end

@implementation LDStoreViewController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self masLayoutSubviews];
    [self configMagicController];
}
#pragma  mark - ConfigUI
- (void)configMagicController{
    CGFloat maxY = CGRectGetMaxY(self.headView.frame)+10;
    self.magicController.magicView.frame = CGRectMake(0,maxY, SCREEN_WIDTH, SCREEN_HEIGHT-maxY-TabBarHeight);
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    [self.magicController.magicView reloadData];
}

- (void)masLayoutSubviews{
//    [self.view addSubview:self.searchButton];
//    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view).mas_offset(PtWidth(21));
//        make.right.mas_equalTo(self.view).mas_offset(PtWidth(-21));
//
//        if (@available(iOS 11.0, *)) {
//            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(10);
//        } else {
//            make.top.mas_equalTo(self.view);
//
//        }
//        make.height.mas_equalTo(PtHeight(32));
//    }];

    [self.view addSubview:self.headView];
    [self configCycleView];
}
- (void)configCycleView {
    UIImage * placeholderImage = [UIImage imageNamed:@"seizeaseat_0"];
    self.headView.cycleScrollView.placeholderImage = placeholderImage;
    self.headView.cycleScrollView.imageURLStringsGroup = self.netImages;
    self.headView.cycleScrollView.showPageControl = YES;
}
#pragma mark - event response
- (void)clickSearchAction:(UIButton *)sender {
    LDStoreSearchViewController *vc = [LDStoreSearchViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - VTMagicViewDelegate
- (NSArray<__kindof NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView{
    return @[@"全部商品",@"工具书",@"微课"];
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
            static NSString *identifier = @"LDAllshoppingViewController.identifier";
            LDAllshoppingViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDAllshoppingViewController alloc] init];
            }
            return vc;
        }
            break;
        case 1:
        {
            static NSString *identifier = @"LDToolBooksViewController.identifier";
            LDToolBooksViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDToolBooksViewController alloc] init];
            }
            return vc;
        }
            break;
        case 2:
        {
            static NSString *identifier = @"LDSmallClassViewController.identifier";
            LDSmallClassViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDSmallClassViewController alloc] init];
            }
            return vc;
        }
            break;
        default:
        {
            return nil;
        }
            break;
    }
}

- (nonnull UIButton *)magicView:(nonnull VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:UIColorFromHEXA(0x666666, 1) forState:UIControlStateNormal];
        [menuItem setTitleColor:MainThemeColor forState:UIControlStateSelected];
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
- (LDShoppingHeadView *)headView {
    if (!_headView) {
        _headView = [[NSBundle mainBundle]loadNibNamed:@"LDShoppingHeadView" owner:self options:nil].firstObject;
    }
    return _headView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
