//
//  LDNewsTableViewCell.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDNewsTableViewCell.h"

NSString *const kLDNewsTableViewCellIdentifier = @"kLDNewsTableViewCellIdentifier";

@implementation LDNewsTableViewCell

#pragma  mark - Init
+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView
{
    LDNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLDNewsTableViewCellIdentifier];
    if (cell == nil)
    {
        cell = [[LDNewsTableViewCell alloc]init];
    }
    return cell;
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLDNewsTableViewCellIdentifier];
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
- (void)refreshWithModel:(LDNewsModel *)model {
    if ([model.coverImg containsString:@"http"]) {
        [self.bigImageVIew sd_setImageWithURL:[NSURL URLWithString:model.coverImg] placeholderImage:[UIImage imageNamed:@"seizeaseat_0"]];
    }else{
        [self.bigImageVIew sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@img/%@",BaseAPI,model.coverImg]] placeholderImage:[UIImage imageNamed:@"seizeaseat_0"]];
    }
    self.timeLabel.text = model.createdDate;
    self.titleLabel.text = model.title;
    self.watchLabel.text = model.numOfVisiter;
}

#pragma  mark - masLayoutSuviews
- (void)masLayoutSubview
{
    [self.contentView addSubview:self.bigImageVIew];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.watchLabel];
    
    [self.bigImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(12);
        make.top.mas_equalTo(self).mas_offset(5);
        make.width.mas_equalTo(PtWidth(138));
        make.height.mas_equalTo(PtHeight(77));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bigImageVIew.mas_right).mas_offset(PtWidth(17));
        make.top.equalTo(self.bigImageVIew);
        make.right.mas_equalTo(self).mas_offset(PtWidth(-31));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(PtHeight(8));
        make.left.right.mas_equalTo(self.titleLabel);
    }];

    [self.watchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLabel);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(5);
    }];
}

- (void)addFreeLabel{
    [self.contentView addSubview:self.freeLabel];
    [self.freeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-PtWidth(10));
        make.centerY.mas_equalTo(self.contentView).mas_offset(PtHeight(10));
        make.width.mas_equalTo(PtWidth(28));
        make.height.mas_equalTo(PtHeight(15));
    }];
}
#pragma  mark - GET && SET
- (UIImageView *)bigImageVIew {
    if (!_bigImageVIew) {
        _bigImageVIew = [[UIImageView alloc]init];
        _bigImageVIew.layer.masksToBounds = YES;
        _bigImageVIew.layer.cornerRadius = 10.f;
        _bigImageVIew.image = [UIImage imageNamed:@"seizeaseat_0"];
    }
    return _bigImageVIew;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"makemakemakemakemakemakemakemake";
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:PtHeight(15)];
    }
    return _titleLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.text = @"2018.18.18 18：30";
        _timeLabel.font = [UIFont systemFontOfSize:PtHeight(8)];
    }
    return _timeLabel;
}
- (UILabel *)freeLabel{
    if (!_freeLabel) {
        _freeLabel = [[UILabel alloc]init];
        _freeLabel.layer.masksToBounds = YES;
        _freeLabel.layer.cornerRadius = 5;
        _freeLabel.layer.borderColor = UIColorFromHEXA(0xE76757, 1).CGColor;
        _freeLabel.layer.borderWidth = 1;
        _freeLabel.textColor = UIColorFromHEXA(0xF9615E, 1);
        _freeLabel.font = [UIFont systemFontOfSize:11];
        _freeLabel.text = @"免费";
        _freeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _freeLabel;
}
- (UILabel *)watchLabel{
    if (!_watchLabel) {
        _watchLabel = [[UILabel alloc]init];
        _watchLabel.text = @"20人已看";
        _watchLabel.font = [UIFont systemFontOfSize:PtHeight(8)];
        _watchLabel.textColor = UIColorFromHEXA(0x979797, 1);
    }
    return _watchLabel;
}
@end
