//
//  LDVideoTableViewCell.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/18.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDVideoTableViewCell.h"

NSString *const kLDVideoTableViewCellIdentifier = @"kLDVideoTableViewCellIdentifier";


@implementation LDVideoTableViewCell

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView
{
    LDVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLDVideoTableViewCellIdentifier];
    if (cell == nil)
    {
        cell = [[LDVideoTableViewCell alloc]init];
    }
    return cell;
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLDVideoTableViewCellIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        [self masLayoutSubview];
    }
    return self;
}

- (void)masLayoutSubview
{
    [super masLayoutSubview];
    [self.contentView addSubview:self.blackImageView];
    [self.blackImageView addSubview:self.playImageView];
    [self.blackImageView addSubview:self.durationLabel];
    
    [self.blackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bigImageVIew).mas_offset(-1);
        make.bottom.mas_equalTo(self.bigImageVIew).mas_offset(-2);
        make.width.mas_equalTo(PtWidth(PtWidth(71)));
        make.height.mas_equalTo(PtHeight(16));
    }];
    
    [self.playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.blackImageView).mas_offset(PtWidth(8));
        make.centerY.mas_equalTo(self.blackImageView);
        make.width.mas_equalTo(PtWidth(PtWidth(6)));
        make.height.mas_equalTo(PtHeight(7));
    }];
    [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.playImageView.mas_right).mas_offset(PtWidth(5));
        make.centerY.mas_equalTo(self.blackImageView);
        make.width.mas_equalTo(PtWidth(PtWidth(44)));
        make.height.mas_equalTo(PtHeight(8));
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView bringSubviewToFront:self.blackImageView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIImageView *)blackImageView {
    if (!_blackImageView) {
        _blackImageView = [[UIImageView alloc]init];
        _blackImageView.backgroundColor = UIColorFromHEXA(0x192256, 1);
        [_blackImageView setCornerRadius:PtHeight(8)];
    }
    return _blackImageView;
}
- (UIImageView *)playImageView {
    if (!_playImageView) {
        _playImageView = [[UIImageView alloc]init];
        _playImageView.image = [UIImage imageNamed:@"play_icon_01"];
    }
    return _playImageView;
}
- (UILabel *)durationLabel {
    if (!_durationLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:PtHeight(8)];
        label.textColor = [UIColor whiteColor];
        label.text = @"03:40:12";
        _durationLabel = label;
        
    }
    return _durationLabel;
}
@end
