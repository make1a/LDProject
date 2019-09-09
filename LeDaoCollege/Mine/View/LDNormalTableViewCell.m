//
//  LDNormalTableViewCell.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDNormalTableViewCell.h"

NSString *const kLDNormalTableViewCell = @"LDNormalTableViewCell";

@implementation LDNormalTableViewCell

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView
{
    LDNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLDNormalTableViewCell];
    if (cell == nil)
    {
        cell = [[LDNormalTableViewCell alloc]init];
    }
    return cell;
}


- (instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kLDNormalTableViewCell];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}
@end
