//
//  LDNameCell.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/9.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDNameCell.h"

NSString *const kLDNameCellIdentifier = @"kLDNameCellIdentifier";


@implementation LDNameCell

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView
{
    LDNameCell *cell = [tableView dequeueReusableCellWithIdentifier:kLDNameCellIdentifier];
    if (cell == nil)
    {
        cell = [[LDNameCell alloc]init];
    }
    return cell;
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kLDNameCellIdentifier];
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
