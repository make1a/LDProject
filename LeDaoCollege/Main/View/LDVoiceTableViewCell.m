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

- (void)configUI
{
    [self.contentView addSubview:self.playImageView];
    [self.playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bigImageVIew);
        make.bottom.mas_equalTo(self.bigImageVIew).mas_offset(-PtHeight(2));
        make.width.height.mas_equalTo(20);
    }];
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
        _playImageView.image = [UIImage imageNamed:@"play_icon_01"];
    }
    return _playImageView;
}

@end
