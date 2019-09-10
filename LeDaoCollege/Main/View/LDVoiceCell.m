//
//  LDVoiceCell.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/10.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDVoiceCell.h"

NSString *const kLDVoiceCellIdentifier = @"kLDVoiceCellIdentifier";


@implementation LDVoiceCell

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView
{
    LDVoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:kLDVoiceCellIdentifier];
    if (cell == nil)
    {
        cell = [[LDVoiceCell alloc]init];
    }
    return cell;
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLDVoiceCellIdentifier];
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
    [self addSubview:self.playImageView];
    
    [self.bigImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self).mas_offset(5);
        make.width.mas_equalTo(PtWidth(150));
        make.height.mas_equalTo(PtHeight(85));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bigImageVIew.mas_right).mas_offset(PtWidth(15));
        make.top.equalTo(self.bigImageVIew);
        make.right.mas_equalTo(self).mas_offset(PtWidth(-31));
        make.height.mas_equalTo(PtHeight(42));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bigImageVIew);
        make.left.right.mas_equalTo(self.titleLabel);
    }];
    [self.playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bigImageVIew.mas_right).mas_offset(-10);
        make.bottom.mas_equalTo(self.bigImageVIew.mas_bottom).mas_offset(-10);

    }];
}


#pragma  mark - GET && SET
- (UIImageView *)bigImageVIew {
    if (!_bigImageVIew) {
        _bigImageVIew = [[UIImageView alloc]init];
        _bigImageVIew.layer.masksToBounds = YES;
        _bigImageVIew.layer.cornerRadius = 5.f;
        _bigImageVIew.image = [UIImage imageNamed:@"blank_common"];
    }
    return _bigImageVIew;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"makemakemakemakemakemakemakemake";
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:PtHeight(16)];
    }
    return _titleLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.text = @"2018.18.18 18：30";
        _timeLabel.font = [UIFont systemFontOfSize:PtHeight(12)];
    }
    return _timeLabel;
}
- (UIImageView *)playImageView {
    if (!_playImageView) {
        _playImageView = [[UIImageView alloc]init];
        _playImageView.image = [UIImage imageNamed:@"play"];
    }
    return _playImageView;
}
@end
