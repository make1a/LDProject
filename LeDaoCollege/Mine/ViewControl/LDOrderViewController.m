//
//  LDOrderViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/11.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDOrderViewController.h"
#import <VTMagic.h>
#import "LDUnfinishOrderViewController.h"
#import "LDFinishOrderViewController.h"

@interface LDOrderViewController ()<VTMagicViewDataSource,VTMagicViewDelegate>
@property (nonatomic, strong)VTMagicController *magicController;
@end

@implementation LDOrderViewController
#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configMagicController];
    self.title = @"我的订单";
}
#pragma  mark - ConfigUI
- (void)configMagicController{
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    [self.magicController.magicView reloadData];
}
#pragma mark - event response


#pragma mark - private method

#pragma mark - VTMagicViewDelegate
- (NSArray<__kindof NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView{
    return @[@"未支付",@"已支付"];
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
            static NSString *identifier = @"LDUnfinishOrderViewController.identifier";
            LDUnfinishOrderViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDUnfinishOrderViewController alloc] init];
            }
            return vc;
        }
            break;
        default:
        {
            static NSString *identifier = @"LDFinishOrderViewController.identifier";
            LDFinishOrderViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDFinishOrderViewController alloc] init];
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
        [menuItem setTitleColor:UIColorFromHEXA(0x333333, 1) forState:UIControlStateNormal];
        [menuItem setTitleColor:UIColorFromHEXA(0x00AD6F, 1) forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return menuItem;
}

#pragma  mark - GET & SET

- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.navigationHeight = PtHeight(34);
        _magicController.magicView.sliderHidden = NO;
        _magicController.magicView.sliderWidth = PtWidth(20);
        _magicController.magicView.sliderColor = UIColorFromHEXA(0xFF00AD6F, 1);
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.itemSpacing = 20;
        _magicController.magicView.frame = CGRectMake(0,kSTATUSBAR_NAVIGATION_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-kSTATUSBAR_NAVIGATION_HEIGHT);
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        _magicController.magicView.needPreloading = NO;
        _magicController.magicView.separatorHidden = YES;
    }
    return _magicController;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
