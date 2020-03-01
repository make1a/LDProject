//
//  LDMainViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDMainViewController.h"
#import <VTMagic/VTMagic.h>
#import "LDInfoMationViewController.h"
#import "LDVoiceListViewController.h"
#import "LDVideoViewController.h"
#import "LDLiveViewController.h"
#import "LDSearchViewController.h"
#import "LDBookDicViewController.h"
#import "LDLoginViewController.h"
@interface LDMainViewController ()<VTMagicViewDelegate,VTMagicViewDataSource>

@property (nonatomic, strong)VTMagicController *magicController;
@property (nonatomic,strong)UIButton * searchButton;
@property (nonatomic,strong)UIView * bgView;
@property (nonatomic,strong)NSMutableArray * imageArray;
@property (nonatomic,strong)UIImageView * logoImageView;
@end

@implementation LDMainViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    [self masLayoutSubviews];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self requestBannerList];
    });
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
    [self.view addSubview:self.logoImageView];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(48.5);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        if (@available(iOS 11.0, *)) {
            if (iPhoneX) {
                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(15);
            }else{
                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(20);
            }
        } else {
            make.top.mas_equalTo(self.view);
        }
        make.height.mas_equalTo(32);
    }];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.searchButton);
        make.height.width.mas_equalTo(30);
        make.left.mas_equalTo(self.view).mas_offset(10);
    }];
}
- (void)requestBannerList {
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"banner/getbytype/1" requestParameters:@{@"type":@"1"} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            NSArray *array = responseObject[@"data"];
            if (![responseObject[@"data"] isKindOfClass:[NSArray class]]) {
                return ;
            }
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
            [self.magicController.magicView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
}
#pragma  mark - Touch Action
- (void)clickSearchAction:(UIButton *)sender {
    if (![LDUserManager isLogin]) {
        LDLoginViewController *vc = [LDLoginViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    LDSearchViewController *vc = [LDSearchViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - VTMagicViewDelegate
- (NSArray<__kindof NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView{
    return @[@"资讯",@"微课",@"直播",@"宝典"];
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
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                vc.netImages = self.imageArray;
            });
            return vc;
        }
            break;
//        case 1:
//        {
//            static NSString *identifier = @"LDVoiceViewController.identifier";
//            LDVoiceListViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
//            if (!vc)
//            {
//                vc = [[LDVoiceListViewController alloc] init];
//            }
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                vc.netImages = self.imageArray;
//            });
//            return vc;
//        }
//            break;
        case 1:
        {
            static NSString *identifier = @"LDVideoViewController.identifier";
            LDVideoViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDVideoViewController alloc] init];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                vc.netImages = self.imageArray;
            });
            return vc;
        }
            break;
        case 3:
        {
            static NSString *identifier = @"LDBookDicViewController.identifier";
            LDBookDicViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDBookDicViewController alloc] init];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                vc.netImages = self.imageArray;
            });
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
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                vc.netImages = self.imageArray;
            });
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
        [menuItem setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont boldSystemFontOfSize:18];
//        menuItem.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return menuItem;
}

#pragma  mark - GET & SET
- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor clearColor];
        _magicController.magicView.navigationHeight = PtHeight(40);
        _magicController.magicView.sliderHidden = YES;
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PtWidth(20), 5)];
//        view.backgroundColor = [UIColor whiteColor];
//        [view setCornerRadius:5.0/2];
//        [_magicController.magicView setSliderView:view];
//        _magicController.magicView.sliderWidth = PtWidth(20);
//        _magicController.magicView.sliderHeight = 5;
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.itemSpacing = 20;
        CGFloat h = 0;
        if (iPhoneX) {
            h = 100;
        }else{
            h = 80;
        }
        _magicController.magicView.frame = CGRectMake(0,h, SCREEN_WIDTH, SCREEN_HEIGHT-h-TabBarHeight);
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
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = MainThemeColor;
        CGFloat h = 0;
        if (iPhoneX) {
            h = PtHeight(149);
        }else{
            h = PtHeight(120);
        }
        _bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, h);
    }
    return _bgView;
}
- (UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
        UIImage *image = [UIImage imageNamed:@"logo3"];
        _logoImageView.image = image;
    }
    return _logoImageView;
}
@end
