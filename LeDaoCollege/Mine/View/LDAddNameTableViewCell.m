//
//  LDAddNameTableViewCell.m
//  LeDaoCollege
//
//  Created by Make on 2020/3/19.
//  Copyright © 2020 Make. All rights reserved.
//

#import "LDAddNameTableViewCell.h"


NSString *const kLDAddNameCellIdentifier = @"kLDNameCellIdentifier";


@implementation LDAddNameTableViewCell

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView
{
    LDAddNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLDAddNameCellIdentifier];
    if (cell == nil)
    {
        cell = [[LDAddNameTableViewCell alloc]init];
    }
    return cell;
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kLDAddNameCellIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.contentView.backgroundColor = [UIColor clearColor];
        [self masLayoutSubview];
    }
    return self;
}

- (void)masLayoutSubview
{
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(20);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-10);
        make.left.mas_equalTo(self.nameLabel.mas_right).mas_offset(50);
        make.top.height.mas_equalTo(self.contentView);
    }];
    
}

#pragma  mark - GET SET
- (UIImageView *)starImageView {
    if (!_starImageView) {
        _starImageView = [[UIImageView alloc]init];
        _starImageView.image = [UIImage imageNamed:@""];
    }
    return _starImageView;
}
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.placeholder = @"请输入姓名";
        _textField.textAlignment = NSTextAlignmentRight;
    }
    return _textField;
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        
        NSString *allString = [NSString stringWithFormat:@"* 姓名"];
        NSString *agreeString = [NSString stringWithFormat:@"*"];
        
        NSAttributedString *string = [HNTools getAttributedString:allString withStringAttributedDic:@{NSForegroundColorAttributeName : [UIColor blackColor]} withSubString:agreeString withSubStringAttributeDic:@{NSForegroundColorAttributeName : [UIColor redColor]}];
        [_nameLabel setAttributedText:string];
    }
    return _nameLabel;
}

- (void)setNameText:(NSString *)title{
    NSString *allString = title;
    NSString *agreeString = [NSString stringWithFormat:@"*"];
    
    NSAttributedString *string = [HNTools getAttributedString:allString withStringAttributedDic:@{NSForegroundColorAttributeName : [UIColor blackColor]} withSubString:agreeString withSubStringAttributeDic:@{NSForegroundColorAttributeName : [UIColor redColor]}];
    [_nameLabel setAttributedText:string];
}
@end
