//
//  LDCustomerDetailViewController.m
//  LeDaoCollege
//
//  Created by make on 2019/9/7.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDCustomerDetailViewController.h"
#import "LDBusinessCardView.h"
#import <VTMagic/VTMagic.h>
#import "LDCustormHistoryViewController.h"
#import "LDTextViewViewController.h"

@interface LDCustomerDetailViewController ()<VTMagicViewDelegate,VTMagicViewDataSource>
@property (nonatomic,strong)LDBusinessCardView * cardView;
@property (nonatomic, strong)VTMagicController *magicController;
@end

@implementation LDCustomerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客户日志管理";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self masLayoutSubviews];
}

- (void)masLayoutSubviews{
    [self.view addSubview:self.cardView];
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    [self.magicController.magicView reloadData];
}
#pragma mark - VTMagicViewDelegate
- (NSArray<__kindof NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView{
    return @[@"写日志",@"查看历史"];
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
            static NSString *identifier = @"LDVoiceViewController.identifier";
            LDTextViewViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDTextViewViewController alloc] init];
            }
            return vc;
            
        }
            break;
        default:
        {
            static NSString *identifier = @"LDCustormHistoryViewController.identifier";
            LDCustormHistoryViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDCustormHistoryViewController alloc] init];
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
- (LDBusinessCardView *)cardView {
    if (!_cardView) {
        _cardView = [[LDBusinessCardView alloc]initWithFrame:CGRectMake(12, kSTATUSBAR_NAVIGATION_HEIGHT+10, SCREEN_WIDTH-2*12, 300)];
    }
    return _cardView;
}
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
        _magicController.magicView.frame = CGRectMake(0,CGRectGetMaxY(self.cardView.frame)+20, SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(self.cardView.frame));
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        _magicController.magicView.needPreloading = NO;
    }
    return _magicController;
}
@end
