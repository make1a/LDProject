//
//  LDShoppingCartPaymentView.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/16.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDShoppingCartPaymentView.h"

@implementation LDShoppingCartPaymentView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self masLayoutSubview];
    }
    return self;
}
#pragma mark - get and set
- (void)masLayoutSubview
{
    [self addSubview:self.selectedAllButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.payButton];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.selectedAllButton);
        make.left.mas_equalTo(self).mas_offset(PtWidth(156));
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(PtWidth(3));
        make.bottom.mas_equalTo(self.titleLabel);
    }];
}

- (UIButton *)selectedAllButton {
    if (!_selectedAllButton) {
        _selectedAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectedAllButton.backgroundColor = [UIColor grayColor];
        _selectedAllButton.frame = CGRectMake(PtWidth(13), PtHeight(16), PtWidth(20), PtWidth(20));
    }
    return _selectedAllButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:PtHeight(15)];
        _titleLabel.text = @"合计:";
    }
    return _titleLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.text = @"188";
        _priceLabel.font = [UIFont boldSystemFontOfSize:PtHeight(20)];
        _priceLabel.textColor = UIColorFromHEXA(0xFFFF0B0B, 1);
    }
    return _priceLabel;
}
- (UIButton *)payButton{
    if (!_payButton) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payButton.frame = CGRectMake(SCREEN_WIDTH-PtWidth(12)-PtWidth(82), PtHeight(6), PtWidth(82), 40);
        [_payButton setTitle:@"结算" forState:UIControlStateNormal];
        [_payButton setTitle:@"删除" forState:UIControlStateSelected];
        
        [_payButton setBackgroundImage:[UIImage imageNamed:@"shoppingcart_button_pay"] forState:UIControlStateNormal];
        [_payButton setBackgroundImage:[UIImage imageNamed:@"shoppingcart_button_delet"] forState:UIControlStateSelected];
    }
    return _payButton;
}
@end
