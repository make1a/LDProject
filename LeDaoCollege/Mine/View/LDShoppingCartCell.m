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
        [self configUI];
    }
    return self;
}

- (void)cellRefreshWithModel:(LDShoppingCartModel *)model{
    if (model.isSelected) {
        self.selectImageView.backgroundColor = [UIColor redColor];
    } else {
        self.selectImageView.backgroundColor = [UIColor grayColor];
    }
}
- (void)masLayoutSubview
{
    [self.contentView addSubview:self.selectImageView];
    [self.contentView addSubview:self.tagLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.cheapPriceLabel];
    
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(PtWidth(13));
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(PtWidth(20));
    }];
    
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(48);
        make.top.mas_equalTo(self).mas_offset(PtHeight(12));
        make.width.mas_equalTo(PtWidth(112));
        make.height.mas_equalTo(PtHeight(64));
    }];
    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).mas_offset(PtWidth(17));
        make.top.mas_equalTo(self.imageView);
        make.right.mas_equalTo(self).mas_offset(-PtWidth(20));
    }];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.textLabel);
        make.top.mas_equalTo(self.textLabel.mas_bottom).mas_offset(PtHeight(8));
        make.width.mas_equalTo(PtWidth(50));
        make.height.mas_equalTo(PtHeight(18));
    }];
    [self.cheapPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.textLabel);
        make.top.mas_equalTo(self.tagLabel.mas_bottom).mas_offset(PtHeight(9));
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cheapPriceLabel.mas_right).mas_offset(PtWidth(6));
        make.centerY.mas_equalTo(self.cheapPriceLabel);
    }];
}

- (void)configUI {
    self.imageView.image = [UIImage imageNamed:@"dog"];
    self.textLabel.text = @"UI设计零基础入门教学";
    self.textLabel.numberOfLines = 1;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma  mark - GET & SET
- (UIImageView *)selectImageView{
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc]init];
        _selectImageView.backgroundColor = [UIColor grayColor];
    }
    return _selectImageView;
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
- (QMUILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[QMUILabel alloc]init];
        //中划线
        NSString *textStr = @"18.88";
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
        // 赋值
        _priceLabel.attributedText = attribtStr;
    }
    return _priceLabel;
}
- (QMUILabel *)cheapPriceLabel {
    if (!_cheapPriceLabel) {
        _cheapPriceLabel = [[QMUILabel alloc]qmui_initWithFont:[UIFont systemFontOfSize:PtHeight(13)] textColor:[UIColor redColor]];
        _cheapPriceLabel.text = @"18.88";
    }
    return _cheapPriceLabel;
}
@end
