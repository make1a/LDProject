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
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self masLayoutSubview];
    }
    return self;
}

#pragma  mark - masLayoutSuviews
- (void)masLayoutSubview
{
    [self.contentView addSubview:self.bigImageVIew];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    
    [self.bigImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self).mas_offset(5);
        make.width.mas_equalTo(PtWidth(113));
        make.height.mas_equalTo(PtHeight(64));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bigImageVIew.mas_right).mas_offset(PtWidth(17));
        make.top.equalTo(self.bigImageVIew);
        make.right.mas_equalTo(self).mas_offset(PtWidth(-31));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(PtHeight(11));
        make.left.right.mas_equalTo(self.titleLabel);
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
        _titleLabel.numberOfLines = 1;
        _titleLabel.font = [UIFont systemFontOfSize:PtHeight(16)];
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
@end
