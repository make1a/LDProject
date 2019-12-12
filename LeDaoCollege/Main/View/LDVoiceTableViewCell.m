//
//  LDVoiceTableViewCell.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/18.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDVoiceTableViewCell.h"

NSString *const kLDVoiceTableViewCellIdentifier = @"kLDVoiceTableViewCellIdentifier";

@interface LDVoiceTableViewCell ()
@property (nonatomic,strong)UIButton * playButton;
@end
@implementation LDVoiceTableViewCell

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView
{
    LDVoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLDVoiceTableViewCellIdentifier];
    if (cell == nil)
    {
        cell = [[LDVoiceTableViewCell alloc]init];
    }
    return cell;
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLDVoiceTableViewCellIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        [self configUI];
    }
    return self;
}
- (void)refreshWithModel:(LDVoiceModel *)model {
    self.titleLabel.text = model.title;
    if ([model.coverImg containsString:@"http"]) {
        [self.bigImageVIew sd_setImageWithURL:[NSURL URLWithString:model.coverImg] placeholderImage:[UIImage imageNamed:@"seizeaseat_0"]];
    }else{
        [self.bigImageVIew sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@img/%@",BaseAPI,model.coverImg]] placeholderImage:[UIImage imageNamed:@"seizeaseat_0"]];
    }
    self.timeLabel.text = model.createdDate;
    self.collectionButton.selected = [model.collectionFlag isEqualToString:@"Y"]?YES:NO;
}
- (void)clickCollectionButtonAction{
    if (self.didSelectCollectionActionBlock) {
        self.didSelectCollectionActionBlock();
    }
}
#pragma  mark - UI
- (void)configUI
{
    [self.contentView addSubview:self.bigImageVIew];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.watchLabel];
    [self.contentView addSubview:self.collectionButton];
    [self.contentView addSubview:self.playButton];
    
    [self.bigImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(PtWidth(15));
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(PtHeight(72));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bigImageVIew.mas_right).mas_offset(PtWidth(17));
        make.top.equalTo(self.bigImageVIew);
        make.right.mas_equalTo(self).mas_offset(PtWidth(-31));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(PtHeight(6.5));
    }];
    [self.watchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLabel);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(PtHeight(7.5));
    }];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bigImageVIew);
        make.centerX.mas_equalTo(self.bigImageVIew);
    }];
    
    [self.collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(PtWidth(-17));
        make.centerY.mas_equalTo(self.contentView);
    }];
}

- (void)addFreeLabel{
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma  mark - Get Set
- (UIImageView *)bigImageVIew {
    if (!_bigImageVIew) {
        _bigImageVIew = [[UIImageView alloc]init];
        _bigImageVIew.image = [UIImage imageNamed:@"seizeaseat_0"];
        [_bigImageVIew setCornerRadius:PtHeight(36)];
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
        _timeLabel.text = @"make";
        _timeLabel.font = [UIFont systemFontOfSize:PtHeight(12)];
    }
    return _timeLabel;
}
- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"play_icon"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"pause_icon"] forState:UIControlStateSelected];
        [_playButton setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    }
    return _playButton;
}
- (UIButton *)collectionButton {
    if (!_collectionButton) {
        _collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectionButton setImage:[UIImage imageNamed:@"collect_default"] forState:UIControlStateNormal];
        [_collectionButton setImage:[UIImage imageNamed:@"collect_sele"] forState:UIControlStateSelected];
        [_collectionButton addTarget:self action:@selector(clickCollectionButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectionButton;
}
- (UILabel *)watchLabel{
    if (!_watchLabel) {
        _watchLabel = [[UILabel alloc]init];
        _watchLabel.text = @"20人已看";
        _watchLabel.font = [UIFont systemFontOfSize:PtHeight(12)];
        _watchLabel.textColor = UIColorFromHEXA(0x979797, 1);
    }
    return _watchLabel;
}
@end
