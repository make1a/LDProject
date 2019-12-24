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
        self.imageView.image = [UIImage imageNamed:@"seizeaseat_0"];
        self.textLabel.text = @"makemake";
    }
    return self;
}
- (void)refreshWith:(LDOrderModel *)model{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@img/%@",BaseAPI,model.coverImg]] placeholderImage:[UIImage imageNamed:@"seizeaseat_0"]];
    self.textLabel.text = model.title;
    if ([model.goodsType isEqualToString:@"1"]) {
        self.tagLabel.text = @"音频";
    }else if ([model.goodsType isEqualToString:@"2"]) {
        self.tagLabel.text = @"视频";
    }else if ([model.goodsType isEqualToString:@"3"]) {
        self.tagLabel.text = @"工具书";
    }else{
        self.tagLabel.text = @"微课";
    }
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@",model.originalPrice];
    self.safePriceLabel.text = [NSString stringWithFormat:@"%@",model.discount];
    self.timeLabel.text = model.createDate;
}
- (void)masLayoutSubview
{
    [self.imageView setCornerRadius:10];
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(17);
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
        make.width.mas_equalTo(PtWidth(50));
    }];
    
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.safePriceLabel];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.safePriceLabel.mas_left).offset(-10);
        make.bottom.mas_equalTo(self.safePriceLabel);
    }];
    
    [self.safePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-PtWidth(12));
        make.top.mas_equalTo(self.tagLabel.mas_bottom).mas_offset(8);
    }];

    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
        make.left.mas_equalTo(self.textLabel);
        make.width.mas_equalTo(PtWidth(115));
        make.height.mas_equalTo(PtHeight(19));
    }];
}

#pragma  mark - GET SET
- (QMUILabel *)tagLabel {
    if (!_tagLabel) {
        _tagLabel = [[QMUILabel alloc]qmui_initWithFont:[UIFont systemFontOfSize:10] textColor:UIColorFromHEXA(0xFF009E65, 1)];
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
        _priceLabel.textColor = [UIColor darkGrayColor];
        _priceLabel.font = [UIFont systemFontOfSize:PtHeight(13)];
    }
    return _priceLabel;
}
- (QMUILabel *)safePriceLabel {
    if (!_safePriceLabel) {
        _safePriceLabel = [[QMUILabel alloc]qmui_initWithFont:[UIFont systemFontOfSize:PtHeight(15)] textColor:[UIColor redColor]];
        _safePriceLabel.text = @"18.88";
    }
    return _safePriceLabel;
}
- (QMUILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[QMUILabel alloc]init];
        [_timeLabel setCornerRadius:19/2.0];
        _timeLabel.backgroundColor = UIColorFromHEXA(0xF9F9F9, 1);
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textColor = UIColorFromHEXA(0xA0A0A0, 1);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.text = @"2019-09-24 15:41";
    }
    return _timeLabel;
}
@end
