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
#import "LDFinishOrderViewController.h"
#import "LDShoppingCartViewController.h"

#import "LDAllshoppingViewController.h"
#import "LDToolBooksViewController.h"
#import "LDSmallClassViewController.h"


@interface LDStoreViewController ()<SDCycleScrollViewDelegate,VTMagicViewDelegate,VTMagicViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)NSMutableArray * netImages;


@end

@implementation LDStoreViewController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (@available(iOS 11, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self masLayoutSubviews];
    [self requestBannerList];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configMagicController];
}
#pragma  mark - ConfigUI
- (void)configMagicController{
    CGFloat maxY = CGRectGetMaxY(self.headView.frame)+10;
    self.magicController.magicView.frame = CGRectMake(0,maxY, SCREEN_WIDTH, SCREEN_HEIGHT-TabBarHeight);
    [self addChildViewController:self.magicController];
    [self.scrollView addSubview:self.magicController.view];
    [self.magicController.magicView reloadData];
}
- (void)masLayoutSubviews{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.headView];
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
- (IBAction)pushToOrderVCAction:(id)sender {
    LDFinishOrderViewController *vc = [[LDFinishOrderViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)pushToShoppingCartVCAction:(id)sender {
    LDShoppingCartViewController *vc = [[LDShoppingCartViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
            self.headView.cycleScrollView.imageURLStringsGroup = self.netImages;
        }
    } faild:^(NSError *error) {
        
    }];
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
- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor clearColor];
        _magicController.magicView.navigationHeight = PtHeight(35);
        _magicController.magicView.sliderHidden = NO;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PtWidth(20), 5)];
        view.backgroundColor = MainThemeColor;
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

- (LDShoppingHeadView *)headView {
    if (!_headView) {
        _headView = [[NSBundle mainBundle]loadNibNamed:@"LDShoppingHeadView" owner:self options:nil].firstObject;
        [_headView.searchButton addTarget:self action:@selector(clickSearchAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _headView;
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _scrollView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
