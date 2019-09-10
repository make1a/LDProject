//
//  LDHeadImageCell.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/9.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDHeadImageCell.h"

NSString *const kLDHeadImageCellIdentifier = @"kLDHeadImageCellIdentifier";


@implementation LDHeadImageCell

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView
{
    LDHeadImageCell *cell = [tableView dequeueReusableCellWithIdentifier:kLDHeadImageCellIdentifier];
    if (cell == nil)
    {
        cell = [[LDHeadImageCell alloc]init];
    }
    return cell;
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLDHeadImageCellIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.contentView.backgroundColor = [UIColor clearColor];
        [self masLayoutSubview];
    }
    return self;
}

- (void)masLayoutSubview
{
    self.textLabel.text = @"头像";
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-50);
        make.centerY.mas_equalTo(self);
        make.height.width.mas_equalTo(48);
    }];
    self.imageView.image = [UIImage imageNamed:@"blank_common"];
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 24;
    [self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(12);
        make.centerY.mas_equalTo(self);
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

@end
