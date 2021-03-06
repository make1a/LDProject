//
//  LDCommitBuyViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/23.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDCommitBuyViewController.h"
#import "HNAlertView.h"
#import "LDRechargeViewController.h"
@interface LDCommitBuyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *bigPayLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleLabel;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UIButton *payButton;


@end

@implementation LDCommitBuyViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configInfo];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)configInfo {
    NSString *salePrice = [NSString stringWithFormat:@"¥%@",self.currentModel.discount];
    self.bigPayLabel.text = salePrice;
    self.usernameLabel.text = [LDUserManager userName];
    NSLog(@"%@",[LDUserManager shareInstance].currentUser);
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@img/%@",BaseAPI,self.currentModel.coverImg]] placeholderImage:[UIImage imageNamed:@"seizeaseat_0"]];
    self.typeLabel.text = @"工具书";
    self.shopNameLabel.text = self.currentModel.title;
    self.saleLabel.text = salePrice;
    self.originLabel.text = [NSString stringWithFormat:@"¥%@",self.currentModel.originalPrice];
    self.discountLabel.text = salePrice;
    [self.payButton setCornerRadius:self.payButton.qmui_height/2.0];
    if ([self.title isEqualToString:@"订单详情"]) {
        self.footView.hidden = YES;
    }
    
}
- (void)showAlertView{
    HNAlertView *alertView = [[HNAlertView alloc]initWithTitle:@"余额不足" Content:@"您的余额不足是否前往充值" whitTitleArray:@[@"是",@"否"] withType:@"center"];
    [alertView showAlertView:^(NSInteger index) {
        if (index == 0) {
            LDRechargeViewController *vc = [LDRechargeViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}
#pragma  mark - Touch Down
- (IBAction)payAction:(id)sender {
    [self requestBuy];
}

- (void)requestBuy{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:@"order/placeorder" requestParameters:@{@"goodsType":self.goodsType,@"goodsId":self.goodsId,@"goodsPrice":self.currentModel.discount} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            [QMUITips showSucceed:@"购买成功,请稍后到书架上查看..."];
        } else if (kCODE == 608){ //余额不足 跳转
            [self showAlertView];
        }else {
            ShowMsgInfo;
        }
    } faild:^(NSError *error) {
        
    }];
}
@end
