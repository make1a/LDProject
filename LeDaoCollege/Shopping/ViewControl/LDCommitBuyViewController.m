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
#import "LDVideoModel.h"
#import "LDVideoDetailViewController.h"
#import "LDBookRackViewController.h"
#import "LDBookDetailViewController.h"ø
#import "LDClassModel.h"
#import "LDSmallClassDetailViewController.h"
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
    
    if ([self.currentModel.isPayFlag isEqualToString:@"Y"]) {
        self.footView.hidden = YES;
    }
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
    
    if ([self.currentModel isKindOfClass:[LDVideoModel class]]) {
        self.typeLabel.text = @" 视频 ";
    }else {
        self.typeLabel.text = @"工具书";
    }
    
    NSString *salePrice = [NSString stringWithFormat:@"¥%@",self.currentModel.discount];
    self.bigPayLabel.text = salePrice;
    self.usernameLabel.text = [LDUserManager userName];
    NSLog(@"%@",[LDUserManager shareInstance].currentUser);
    
    if ([self.currentModel.coverImg containsString:@"http"]) {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.currentModel.coverImg] placeholderImage:[UIImage imageNamed:@"seizeaseat_0"]];
    }else{
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@img/%@",BaseAPI,self.currentModel.coverImg]] placeholderImage:[UIImage imageNamed:@"seizeaseat_0"]];
    }
    
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
            self.currentModel.isPayFlag = @"Y";
            [QMUITips showSucceed:@"购买成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if ([self.currentModel isKindOfClass:[LDVideoModel class]] ) {
                    for (UIViewController *vc in self.navigationController.viewControllers) {
                        if ([vc isKindOfClass:[LDVideoDetailViewController class]]) {
                            LDVideoDetailViewController *detailVC = (LDVideoDetailViewController *)vc;
                            [detailVC reload];
                        }
                    }
                    [self.navigationController popViewControllerAnimated:NO];
                } else if ([self.goodsType isEqualToString:@"3"]) {
                    
                    LDBookDetailViewController *vc = [[LDBookDetailViewController alloc]initWithNibName:@"LDBookDetailViewController" bundle:[NSBundle mainBundle]];
                    vc.bookID = self.goodsId;
                    [self.navigationController pushViewController:vc animated:YES];

                } else if ([self.currentModel isKindOfClass:[LDClassModel class]]){
                    for (UIViewController *vc in self.navigationController.viewControllers) {
                        if ([vc isKindOfClass:[LDSmallClassDetailViewController class]]) {
                            LDSmallClassDetailViewController *detailVC = (LDSmallClassDetailViewController *)vc;
                            [detailVC reload];
                        }
                    }
                    [self.navigationController popViewControllerAnimated:NO];
                }
            });

        } else if (kCODE == 608){ //余额不足 跳转
            [self showAlertView];
        }else {
            [QMUITips showError:responseObject[@"returnMsg"]];
        }
    } faild:^(NSError *error) {
        
    }];
}
@end
