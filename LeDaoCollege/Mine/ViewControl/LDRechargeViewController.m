//
//  LDRechargeViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/25.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDRechargeViewController.h"
#import "LDRechargeCell.h"
#import "LDChargeModel.h"
@interface LDRechargeViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UIImageView * bgImageView;
@property (nonatomic,strong)QMUILabel * balanceLabel;
@property (nonatomic,strong)QMUILabel * balanceNoticeLabel;
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)QMUIButton * payButton;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UIButton * backButton;
@property (nonatomic,strong)NSArray * dataSource;
@property (nonatomic,assign)NSInteger selectIndex;

@end

@implementation LDRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self masLayoutSubviews];
    self.view.backgroundColor = [UIColor whiteColor];
    self.selectIndex = -1;
    [self requestList];
}
- (void)clickBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)requestList{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"item/getitem/7" requestParameters:nil requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDChargeModel class] json:responseObject[@"data"][0][@"itemList"]];
            [self.collectionView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
}
#pragma  mark - UI
- (void)masLayoutSubviews {
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.balanceLabel];
    [self.view addSubview:self.balanceNoticeLabel];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.payButton];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.titleLabel];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(PtHeight(225));
    }];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.bgImageView).mas_offset(10);
    }];
    [self.balanceNoticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.balanceLabel);
        make.top.mas_equalTo(self.balanceLabel.mas_bottom).mas_offset(30);
        make.width.mas_equalTo(PtWidth(103));
        make.height.mas_equalTo(PtHeight(29));
    }];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.bgImageView.mas_bottom).mas_offset(PtHeight(52));
        make.height.mas_equalTo(PtHeight(87+67+67));
    }];
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.collectionView.mas_bottom).mas_offset(PtHeight(42));
        make.width.mas_equalTo(PtWidth(300));
        make.height.mas_equalTo(PtHeight(40));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(12);
        } else {
            make.top.mas_equalTo(self.view).mas_offset(12);
        }
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.left.mas_equalTo(self.view).mas_offset(12);
    }];
}
#pragma  mark - CollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LDRechargeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDRechargeCell" forIndexPath:indexPath];
    [cell refreshWith:self.dataSource[indexPath.item]];
    if (indexPath.item == self.selectIndex) {
        cell.bgImage.image = [UIImage imageNamed:@"recharge_button_selected"];
        cell.rmbLabel.textColor = [UIColor whiteColor];
        cell.iconlabel.textColor = [UIColor whiteColor];
    }else {
        cell.bgImage.image = [UIImage imageNamed:@"recharge_button_normal"];
        cell.rmbLabel.textColor = UIColorFromHEXA(0x419DFF, 1);
        cell.iconlabel.textColor = UIColorFromHEXA(0x419DFF, 1);
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(PtWidth(100), PtHeight(65));
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1; 
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return PtWidth(9);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, PtWidth(20), 1, PtWidth(20));
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex = indexPath.item;
    [collectionView reloadData];
}
#pragma  mark - GET SET
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.image = [UIImage imageNamed:@"recharge_bg"];
    }
    return _bgImageView;
}
- (QMUILabel *)balanceLabel {
    if (!_balanceLabel) {
        _balanceLabel = [[QMUILabel alloc]init];
        _balanceLabel.text = @"100";
        _balanceLabel.font = [UIFont boldSystemFontOfSize:PtHeight(46)];
        _balanceLabel.textColor = [UIColor whiteColor];
        _balanceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _balanceLabel;
}
- (QMUILabel *)balanceNoticeLabel {
    if (!_balanceNoticeLabel) {
        _balanceNoticeLabel = [[QMUILabel alloc]init];
        _balanceNoticeLabel.textAlignment = NSTextAlignmentCenter;
        _balanceNoticeLabel.backgroundColor = UIColorFromHEXA(0x7F8DFE, 1);
        _balanceNoticeLabel.textColor = [UIColor whiteColor];
        _balanceNoticeLabel.font = [UIFont systemFontOfSize:13];
        _balanceNoticeLabel.text = @"您的乐币余额";
        [_balanceNoticeLabel setCornerRadius:PtHeight(29/2.0)];
    }
    return _balanceNoticeLabel;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(PtWidth(100), PtHeight(67));
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 100, 100) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"LDRechargeCell" bundle:nil] forCellWithReuseIdentifier:@"LDRechargeCell"];
    }
    return _collectionView;
}
- (QMUIButton *)payButton {
    if (!_payButton) {
        _payButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
        [_payButton setTitle:@"立即支付" forState:UIControlStateNormal];
        [_payButton setBackgroundImage:[UIImage imageNamed:@"recharge_paymentbutton"] forState:UIControlStateNormal];
        [_payButton setTitleColor:UIColorFromHEXA(0x865701, 1) forState:UIControlStateNormal];
        [_payButton setCornerRadius:PtHeight(20)];
    }
    return _payButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"乐币充值";
    }
    return _titleLabel;
}
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"nav_back_01"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(clickBackAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
@end
