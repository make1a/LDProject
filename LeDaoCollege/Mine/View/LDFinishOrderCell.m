//
//  LDFinishOrderCell.m
//  
//
//  Created by Make on 2019/9/12.
//

#import "LDFinishOrderCell.h"

NSString *const kLDFinishOrderCellIdentifier = @"kLDFinishOrderCellIdentifier";


@implementation LDFinishOrderCell

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView
{
    LDFinishOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:kLDFinishOrderCellIdentifier];
    if (cell == nil)
    {
        cell = [[LDFinishOrderCell alloc]init];
    }
    return cell;
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLDFinishOrderCellIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        [self masLayoutSubview];
        self.imageView.image = [UIImage imageNamed:@"dog"];
        self.textLabel.text = @"makemake";
    }
    return self;
}

- (void)masLayoutSubview
{
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(5);
        make.top.mas_equalTo(self).mas_offset(5);
        make.width.mas_equalTo(PtWidth(112));
        make.height.mas_equalTo(PtHeight(64));
    }];
    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).mas_offset(PtWidth(17));
        make.top.mas_equalTo(self.imageView);
        make.right.mas_equalTo(self).mas_offset(PtWidth(-10));
    }];
    
    [self.contentView addSubview:self.tagLabel];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).mas_offset(PtWidth(17));
        make.top.mas_equalTo(self.textLabel.mas_bottom).mas_offset(PtHeight(8));
        make.height.mas_equalTo(PtHeight(18));
    }];
    
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.textLabel);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-PtHeight(8));
    }];
    
    [self.contentView addSubview:self.safePriceLabel];
    [self.safePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).offset(5);
        make.bottom.mas_equalTo(self.priceLabel);
    }];
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.safePriceLabel.mas_right).offset(5);
        make.bottom.mas_equalTo(self.priceLabel);
    }];
}

#pragma  mark - GET SET
- (QMUILabel *)tagLabel {
    if (!_tagLabel) {
        _tagLabel = [[QMUILabel alloc]qmui_initWithFont:[UIFont systemFontOfSize:PtHeight(11)] textColor:UIColorFromHEXA(0xFF009E65, 1)];
        _tagLabel.text = @"工具书";
        _tagLabel.layer.masksToBounds = YES;
        _tagLabel.layer.cornerRadius = PtHeight(18/2);
        _tagLabel.backgroundColor = [UIColor colorWithRed:214/255.0 green:242/255.0 blue:232/255.0 alpha:1.0];
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
- (QMUILabel *)safePriceLabel {
    if (!_safePriceLabel) {
        _safePriceLabel = [[QMUILabel alloc]qmui_initWithFont:[UIFont systemFontOfSize:PtHeight(13)] textColor:[UIColor redColor]];
        _safePriceLabel.text = @"18.88";
    }
    return _safePriceLabel;
}
- (QMUILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[QMUILabel alloc]init];
    }
    return _timeLabel;
}
@end
