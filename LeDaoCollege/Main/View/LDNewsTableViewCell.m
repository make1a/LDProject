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
        self.contentView.backgroundColor = [UIColor clearColor];
        [self masLayoutSubview];
    }
    return self;
}


#pragma  mark - masLayoutSuviews
- (void)masLayoutSubview
{
    [self addSubview:self.bigImageVIew];
    [self addSubview:self.titleLabel];
    [self addSubview:self.timeLabel];
    
    [self.bigImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(5);
        make.top.mas_equalTo(self).mas_offset(5);
        make.width.height.mas_equalTo(80);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bigImageVIew.mas_right).mas_offset(10);
        make.top.equalTo(self.bigImageVIew);
        make.right.mas_equalTo(self).mas_offset(-5);
        make.bottom.mas_equalTo(self.timeLabel.mas_top).mas_offset(10);

    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bigImageVIew);
        make.left.mas_equalTo(self.titleLabel);
    }];
}


#pragma  mark - GET && SET
- (UIImageView *)bigImageVIew {
    if (!_bigImageVIew) {
        _bigImageVIew = [[UIImageView alloc]init];
        _bigImageVIew.layer.masksToBounds = YES;
        _bigImageVIew.layer.cornerRadius = 5.f;
        _bigImageVIew.image = [UIImage imageNamed:@"shatan_bg"];
    }
    return _bigImageVIew;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"makemakemakemakemakemakemakemake";
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.text = @"2018.18.18 18：30";
        _timeLabel.font = [UIFont systemFontOfSize:10];
    }
    return _timeLabel;
}
@end
