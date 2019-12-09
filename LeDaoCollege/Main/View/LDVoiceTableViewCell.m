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
@property (nonatomic,strong)UIImageView * playImageView;
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
    [self.contentView addSubview:self.playImageView];
    [self.contentView addSubview:self.collectionButton];
    
    [self.playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bigImageVIew);
        make.bottom.mas_equalTo(self.bigImageVIew).mas_offset(-PtHeight(2));
        make.width.height.mas_equalTo(PtWidth(16));
    }];
    [self.collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(PtWidth(-17));
        make.centerY.mas_equalTo(self.titleLabel);
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

- (UIImageView *)playImageView {
    if (!_playImageView) {
        _playImageView = [[UIImageView alloc]init];
        _playImageView.image = [UIImage imageNamed:@"play_icon_black_01"];
    }
    return _playImageView;
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
@end
