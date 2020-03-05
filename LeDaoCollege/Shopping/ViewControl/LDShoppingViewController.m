//
//  LDShoppingViewController.m
//  LeDaoCollege
//
//  Created by make on 2020/2/16.
//  Copyright © 2020 Make. All rights reserved.
//

#import "LDShoppingViewController.h"
#import "SDCycleScrollView.h"
#import "LDShoppingHeadView.h"
#import <JXPagerView.h>
#import <JXCategoryTitleView.h>
#import "JXPagerListRefreshView.h"

#import "LDShopClassViewController.h"
#import "LDShopProjectViewController.h"
#import "LDShopSkillViewController.h"
#import "LDShopBookViewController.h"
#import "LDShopPlatformViewController.h"
#import "LDShopResourceViewController.h"
#import "LDFinishOrderViewController.h"

#import "LDStoreSearchViewController.h"
#import "LDLoginViewController.h"

@interface LDShoppingViewController ()<JXPagerViewDelegate, JXPagerMainTableViewGestureDelegate,JXCategoryViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic,strong)NSMutableArray * netImages;
@property (nonatomic,strong)SDCycleScrollView * cycleScrollView;
@property (nonatomic,strong)LDShoppingHeadView * headView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXPagerView *pagerView;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic,strong)UIButton * searchButton;
@end

@implementation LDShoppingViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar addSubview:self.searchButton];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestBannerList];
    [self masLayoutSubviews];
    [self configTitleView];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"mall_nav_order"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickRightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchButton removeFromSuperview];
}
- (void)clickRightButtonAction:(UIButton *)sender{
    LDFinishOrderViewController *vc = [[LDFinishOrderViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)configTitleView{
    self.titles = @[@"课程",@"项目",@"技术",@"书刊",@"平台",@"资源"];
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JXheightForHeaderInSection)];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    
    self.categoryView.titleSelectedColor = [UIColor blackColor];
    self.categoryView.titleColor =[UIColor darkGrayColor];
    
    self.categoryView.titleFont = [UIFont boldSystemFontOfSize:18];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;
    
    _pagerView = [self preferredPagingView];
    self.pagerView.mainTableView.gestureDelegate = self;
    [self.view addSubview:self.pagerView];
    
    self.categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
}
- (void)clickSearchAction:(UIButton *)sender{
    if (![LDUserManager isLogin]) {
        LDLoginViewController *vc = [LDLoginViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    LDStoreSearchViewController *vc = [[LDStoreSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.pagerView.frame = self.view.bounds;
}
- (JXPagerView *)preferredPagingView {
    return [[JXPagerListRefreshView alloc] initWithDelegate:self];
}
#pragma  mark - REQUEST
- (void)requestBannerList {
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"banner/getbytype/2" requestParameters:@{@"type":@"2"} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            NSArray *array = responseObject[@"data"];
            self.netImages = @[].mutableCopy;
            for (NSDictionary *dic in array) {
                NSString *url = dic[@"imgUrl"];
                if ([url containsString:@"http"]) {
                    [self.netImages addObject:url];
                }else{
                    url = [NSString stringWithFormat:@"%@img/%@",BaseAPI,url];
                    [self.netImages addObject:url];
                }
            }
            self.cycleScrollView.imageURLStringsGroup = self.netImages;
        }
    } faild:^(NSError *error) {
        
    }];
}
#pragma mark - JXPagerViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.cycleScrollView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return JXTableHeaderViewHeight;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return JXheightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    //和categoryView的item数量一致
    return self.categoryView.titles.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            LDShopClassViewController *vc = [LDShopClassViewController new];
            vc.title = self.titles[index];
            return vc;
        }
            break;
        case 1:
        {
            LDShopProjectViewController *vc = [LDShopProjectViewController new];
            vc.title = self.titles[index];
            return vc;
        }
            break;
        case 2:
        {
            LDShopSkillViewController *vc = [LDShopSkillViewController new];
            vc.title = self.titles[index];
            return vc;
        }
            break;
            
        case 3:
        {
            LDShopBookViewController *vc = [LDShopBookViewController new];
            vc.title = self.titles[index];
            return vc;
        }
            break;
            
        case 4:
        {
            LDShopPlatformViewController *vc = [LDShopPlatformViewController new];
            vc.title = self.titles[index];
            return vc;
        }
            break;
            
        default:
        {
            LDShopResourceViewController *vc = [LDShopResourceViewController new];
            vc.title = self.titles[index];
            return vc;
        }
            break;
    }
    
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark - JXPagerMainTableViewGestureDelegate

- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //禁止categoryView左右滑动的时候，上下和左右都可以滚动
    //    if (otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer) {
    //        return NO;
    //    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

#pragma  mark - SDCyclesScrollview
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}

- (void)masLayoutSubviews{
    
    //    [self.scrollView addSubview:self.headView];
    [self configCycleView];
}
- (void)configCycleView {
    
}
#pragma  mark - GET SET
//- (LDShoppingHeadView *)headView {
//    if (!_headView) {
//        _headView = [[NSBundle mainBundle]loadNibNamed:@"LDShoppingHeadView" owner:self options:nil].firstObject;
//        [_headView.searchButton addTarget:self action:@selector(clickSearchAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _headView;
//}
- (UIButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.frame = CGRectMake(12, 0, 306, 32);
        _searchButton.backgroundColor = UIColorFromHEXA(0xE8E8E8, 1);
        _searchButton.layer.masksToBounds = YES;
        _searchButton.layer.cornerRadius = 32/2;
        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchButton setImage:[UIImage imageNamed:@"nav_search"] forState:UIControlStateNormal];
        [_searchButton setTitleColor:UIColorFromRGBA(165, 165, 165, 1) forState:UIControlStateNormal];
        _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_searchButton setImageEdgeInsets:UIEdgeInsetsMake(0, 19, 0, 0)];
        [_searchButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 29, 0, 0)];
        [_searchButton addTarget:self action:@selector(clickSearchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}
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
@end
