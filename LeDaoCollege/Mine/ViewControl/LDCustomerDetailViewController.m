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
#import "LDCustomModel.h"
@interface LDCustomerDetailViewController ()<VTMagicViewDelegate,VTMagicViewDataSource>
@property (nonatomic,strong)LDBusinessCardView * cardView;
@property (nonatomic, strong)VTMagicController *magicController;
@property (nonatomic,strong)LDCustomModel * currentModel;
@property (nonatomic,strong)NSArray * dataSource;
@end

@implementation LDCustomerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客户管理";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self masLayoutSubviews];
    [self requestDatsSource];
}

- (void)masLayoutSubviews{
    [self.view addSubview:self.cardView];
    self.magicController.magicView.frame = CGRectMake(0,CGRectGetMaxY(self.cardView.frame)+10, SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(self.cardView.frame));
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    [self.magicController.magicView reloadData];
}
-(void)requestDatsSource{
    NSString *url = [NSString stringWithFormat:@"customer/getcustomerinfo/%@",self.c_id];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:url requestParameters:@{@"id":self.c_id} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            LDCustomModel *model = [LDCustomModel yy_modelWithJSON:responseObject[@"data"][@"customerVO"]];
            [self.cardView updateWith:model];
            
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDCustomLogModel class] json:responseObject[@"data"][@"customerLogVOS"]];
            [self.magicController.magicView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
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
            vc.c_id = self.c_id;
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
            vc.c_id = self.c_id;
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
        [menuItem setTitleColor:UIColorFromHEXA(0x666666, 1) forState:UIControlStateNormal];
        [menuItem setTitleColor:MainThemeColor forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return menuItem;
}

#pragma  mark - GET & SET
- (LDBusinessCardView *)cardView {
    if (!_cardView) {
        _cardView = [[LDBusinessCardView alloc]initWithFrame:CGRectMake(0, kSTATUSBAR_NAVIGATION_HEIGHT+15, SCREEN_WIDTH, 151)];
    }
    return _cardView;
}
- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor whiteColor];
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


@end
