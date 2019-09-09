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
#import "LDVoiceViewController.h"
#import "LDVideoViewController.h"
#import "LDLiveViewController.h"
#import "LDSearchViewController.h"

@interface LDMainViewController ()<VTMagicViewDelegate,VTMagicViewDataSource>

@property (nonatomic, strong)VTMagicController *magicController;
@property (nonatomic,strong)UIButton * searchButton;
@end

@implementation LDMainViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configMagicController];
    self.view.backgroundColor = [UIColor whiteColor];
    [self masLayoutSubviews];
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
        make.left.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.view);

        }
        make.height.mas_equalTo(48);
    }];
}
#pragma  mark - Touch Action
- (void)clickSearchAction:(UIButton *)sender {
    LDSearchViewController *vc = [LDSearchViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - VTMagicViewDelegate
- (NSArray<__kindof NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView{
    return @[@"资讯",@"音频",@"视频",@"直播"];
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex;
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
        [menuItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [menuItem setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return menuItem;
}

#pragma  mark - GET & SET

- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor grayColor];
        _magicController.magicView.navigationHeight = 44;
        _magicController.magicView.againstStatusBar = YES;
        _magicController.magicView.sliderHidden = NO;
        _magicController.magicView.sliderWidth = 35;
        _magicController.magicView.sliderColor = [UIColor yellowColor];
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.itemSpacing = 20;
        _magicController.magicView.againstStatusBar = NO;
        _magicController.magicView.frame = CGRectMake(0,100, SCREEN_WIDTH, SCREEN_HEIGHT-144);
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        _magicController.magicView.needPreloading = NO;
    }
    return _magicController;
}
- (UIButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.backgroundColor = [UIColor grayColor];
        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(clickSearchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}
@end
