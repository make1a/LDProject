//
//  LDCustomHistoryCell.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/24.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDCustomHistoryCell.h"

@implementation LDCustomHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.decsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLabel);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(17);
        make.right.bottom.mas_equalTo(self.contentView).mas_offset(-16);
    }];
    self.decsLabel.text = @"今天跟进客户的需求，向客户推荐了我司产品甜心屋 巧克力脆皮花生甜筒。今天跟进客户的需求，向客户推荐了我司产品甜心屋 巧克力脆皮花生甜筒。今天跟进客户的需求，向客户推荐了我司产品甜心屋 巧克力脆皮花生甜筒。";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
