//
//  LDScoreCell.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/17.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDScoreCell.h"

@implementation LDScoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)refreshView:(LDScoreModel *)model{
    self.titleLabel.text = model.action;
    self.smallTitleLabel.text = model.createdDate;
    self.redLabel.text = [NSString stringWithFormat:@"+%@",model.poins];
}
@end
