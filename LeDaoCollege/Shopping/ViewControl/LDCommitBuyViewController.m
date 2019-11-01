//
//  LDCommitBuyViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/23.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDCommitBuyViewController.h"

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
    self.title = @"确认购买";
    [self configInfo];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)configInfo {
    NSString *salePrice = [NSString stringWithFormat:@"¥%@",self.currentModel.discount];
    self.bigPayLabel.text = salePrice;
    self.usernameLabel.text = self.currentModel.userName;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.currentModel.coverImg] placeholderImage:[UIImage imageNamed:@"seizeaseat_0"]];
    self.typeLabel.text = @"工具书";
    self.shopNameLabel.text = self.currentModel.title;
    self.saleLabel.text = salePrice;
    self.originLabel.text = [NSString stringWithFormat:@"¥%@",self.currentModel.originalPrice];
    self.discountLabel.text = salePrice;
    [self.payButton setCornerRadius:self.payButton.qmui_height/2.0];
}
#pragma  mark - Touch Down
- (IBAction)payAction:(id)sender {
    
}
@end
