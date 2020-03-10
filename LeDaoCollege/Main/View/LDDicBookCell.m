//
//  LDDicBookCell.m
//  LeDaoCollege
//
//  Created by make on 2020/2/15.
//  Copyright © 2020 Make. All rights reserved.
//

#import "LDDicBookCell.h"
NSString *const kLDDicBookCellIdentifier = @"kLDDicBookCellIdentifier";
@implementation LDDicBookCell

#pragma  mark - Init
+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView
{
    LDDicBookCell *cell = [tableView dequeueReusableCellWithIdentifier:kLDDicBookCellIdentifier];
    if (cell == nil)
    {
        cell = [[LDDicBookCell alloc]init];
    }
    return cell;
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLDDicBookCellIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self masLayoutSubview];
        [self addFreeLabel];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self masLayoutSubview];
        [self addFreeLabel];
    }
    return self;
}
- (void)refreshWithModel:(LDStoreModel *)model {
    if ([model.coverImg containsString:@"http"]) {
        [self.bigImageVIew sd_setImageWithURL:[NSURL URLWithString:model.coverImg] placeholderImage:[UIImage imageNamed:@"seizeaseat_0"]];
    }else{
        [self.bigImageVIew sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@img/%@",BaseAPI,model.coverImg]] placeholderImage:[UIImage imageNamed:@"seizeaseat_0"]];
    }
    self.authorLabel.text = model.author;
    self.titleLabel.text = model.title;
    self.watchLabel.text = [NSString stringWithFormat:@"%@人已看",model.numOfVisiter];
    self.priceLabel.text = [NSString stringWithFormat:@"%@金币",model.discount];
    self.originLabel.text = [NSString stringWithFormat:@"%@金币",model.originalPrice];
}

#pragma  mark - masLayoutSuviews
- (void)masLayoutSubview
{
    [self.contentView addSubview:self.bigImageVIew];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.authorLabel];
    [self.contentView addSubview:self.watchLabel];
    
    [self.bigImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(12);
        make.top.mas_equalTo(self).mas_offset(5);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(100);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bigImageVIew.mas_right).mas_offset(PtWidth(17));
        make.top.equalTo(self.bigImageVIew).mas_offset(5);
        make.right.mas_equalTo(self).mas_offset(PtWidth(-14));
    }];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(PtHeight(8));
        make.left.right.mas_equalTo(self.titleLabel);
    }];

    [self.watchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.authorLabel);
        make.top.mas_equalTo(self.authorLabel.mas_bottom).mas_offset(5);
    }];
    
    [self.contentView addSubview:self.originLabel];
    [self.contentView addSubview:self.priceLabel];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.titleLabel);
        make.centerY.mas_equalTo(self.watchLabel);
    }];
    [self.originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.priceLabel);
        make.right.mas_equalTo(self.priceLabel.mas_left).mas_offset(-10);
    }];
    UIView *lineView = [UIView new];
    lineView.backgroundColor = UIColorFromHEXA(0xA1A1A1, 1);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.originLabel);
        make.left.mas_equalTo(self.originLabel).mas_offset(-5);
        make.right.mas_equalTo(self.originLabel).mas_offset(5);
        make.height.mas_equalTo(PtHeight(0.5));
    }];
}

- (void)addFreeLabel{

}
#pragma  mark - GET && SET
- (UIImageView *)bigImageVIew {
    if (!_bigImageVIew) {
        _bigImageVIew = [[UIImageView alloc]init];
        _bigImageVIew.layer.masksToBounds = YES;
        _bigImageVIew.layer.cornerRadius = 5.f;
        _bigImageVIew.image = [UIImage imageNamed:@"seizeaseat_0"];
    }
    return _bigImageVIew;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = UIColorFromHEXA(0x101010, 1);
        _titleLabel.text = @"makemakemakemakemakemakemakemake";
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}
- (UILabel *)authorLabel {
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc]init];
        _authorLabel.textColor = [UIColor grayColor];
        _authorLabel.text = @"Make";
        _authorLabel.font = [UIFont systemFontOfSize:13];
    }
    return _authorLabel;
}

- (UILabel *)watchLabel{
    if (!_watchLabel) {
        _watchLabel = [[UILabel alloc]init];
        _watchLabel.text = @"20人已看";
        _watchLabel.font = [UIFont systemFontOfSize:13];
        _watchLabel.textColor = UIColorFromHEXA(0xA1A1A1, 1);
    }
    return _watchLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = UIColorMakeWithHex(@"#EEC64A");
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.text = @"0金币";
    }
    return _priceLabel;
}
- (UILabel *)originLabel{
    if (!_originLabel) {
        _originLabel = [[UILabel alloc]init];
        _originLabel.font = [UIFont systemFontOfSize:13];
        _originLabel.text = @"100金币";
        _originLabel.textColor = UIColorMakeWithHex(@"##A1A1A1");
    }
    return _originLabel;
}
@end
