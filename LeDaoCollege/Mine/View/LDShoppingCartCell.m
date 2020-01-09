//
//  LDShoppingCartCell.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/16.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDShoppingCartCell.h"

NSString *const kLDShoppingCartCellIdentifier = @"kLDShoppingCartCellIdentifier";


@implementation LDShoppingCartCell

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView
{
    LDShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:kLDShoppingCartCellIdentifier];
    if (cell == nil)
    {
        cell = [[LDShoppingCartCell alloc]init];
    }
    return cell;
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLDShoppingCartCellIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        [self masLayoutSubview];
    }
    return self;
}

- (void)cellRefreshWithModel:(LDShoppingCartModel *)model{
    if (model.isSelected) {
        self.selectButton.selected = YES;
    } else {
        self.selectButton.selected = !YES;
    }
}
- (void)masLayoutSubview
{
    [self.contentView addSubview:self.selectButton];
    [self.contentView addSubview:self.tagLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.cheapPriceLabel];
    [self.contentView addSubview:self.bigImageView];
    [self.contentView addSubview:self.titleLabel];
    
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(PtWidth(13));
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(PtWidth(20));
    }];
    
    [self.bigImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(48);
        make.top.mas_equalTo(self).mas_offset(PtHeight(12));
        make.width.mas_equalTo(PtWidth(112));
        make.height.mas_equalTo(PtHeight(64));
    }];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bigImageView.mas_right).mas_offset(PtWidth(17));
        make.top.mas_equalTo(self.bigImageView);
        make.right.mas_equalTo(self).mas_offset(-PtWidth(20));
    }];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(PtHeight(8));
        make.width.mas_equalTo(PtWidth(50));
        make.height.mas_equalTo(PtHeight(18));
    }];
    [self.cheapPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.tagLabel.mas_bottom).mas_offset(PtHeight(9));
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cheapPriceLabel.mas_right).mas_offset(PtWidth(6));
        make.centerY.mas_equalTo(self.cheapPriceLabel);
    }];
}

#pragma  mark - GET & SET
- (UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"shoppingcart_check_normal"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"shoppingcart_check_sele"] forState:UIControlStateSelected];
    }
    return _selectButton;
}

- (QMUILabel *)tagLabel {
    if (!_tagLabel) {
        _tagLabel = [[QMUILabel alloc]qmui_initWithFont:[UIFont systemFontOfSize:PtHeight(11)] textColor:UIColorFromHEXA(0xFF009E65, 1)];
        _tagLabel.text = @"工具书";
        _tagLabel.layer.masksToBounds = YES;
        _tagLabel.layer.cornerRadius = PtHeight(18/2);
        _tagLabel.backgroundColor = [UIColor colorWithRed:214/255.0 green:242/255.0 blue:232/255.0 alpha:1.0];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tagLabel;
}

- (QMUILabel *)cheapPriceLabel {
    if (!_cheapPriceLabel) {
        _cheapPriceLabel = [[QMUILabel alloc]qmui_initWithFont:[UIFont systemFontOfSize:PtHeight(15)] textColor:[UIColor redColor]];
        _cheapPriceLabel.text = @"18.88";
    }
    return _cheapPriceLabel;
}
- (QMUILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[QMUILabel alloc]init];
        //中划线
        NSString *textStr = @"18.88";
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
        
        // 赋值
        _priceLabel.attributedText = attribtStr;
        _priceLabel.textColor = UIColorFromHEXA(0x999999, 1);
        _priceLabel.font = [UIFont systemFontOfSize:13];
    }
    return _priceLabel;
}

- (UIImageView *)bigImageView{
    if (!_bigImageView) {
        _bigImageView = [[UIImageView alloc]init];
        _bigImageView.image = [UIImage imageNamed:@"seizeaseat_0"];
        [_bigImageView setCornerRadius:5];
    }
    return _bigImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"UI设计零基础入门教学";
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}
@end
