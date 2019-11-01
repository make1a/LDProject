//
//  LDSmallClassDetailIntroCell.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/23.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDSmallClassDetailIntroCell.h"

@implementation LDSmallClassDetailIntroCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.right.mas_equalTo(self.contentView).mas_offset(-18);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(15);
//        make.bottom.mas_equalTo(self.contentMode).mas_offset(-10);
    }];
    
    self.descLabel.text = @"简介正文内容-《经济学基础》是学院经济管理类专业的一门核心 课程和主要专业基础课，该课程是以西方经济学为原型结合高职 专业学生简介正文内容-《经济学基础》是学院经济管理类专业的一门核心 课程和主要专业基础课，该课程是以西方经济学为原型结合高职 专业学生简介正文内容-《经济学基础》是学院经济管理类专业的一门核心 课程和主要专业基础课，该课程是以西方经济学为原型结合高职 专业学生简介正文内容-《经济学基础》是学院经济管理类专业的一门核心 课程和主要专业基础课，该课程是以西方经济学为原型结合高职 专业学生简介正文内容-《经济学基础》是学院经济管理类专业的一门核心 课程和主要专业基础课，该课程是以西方经济学为原型结合高职 专业学生";
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
        make.top.mas_equalTo(self.descLabel.mas_bottom).mas_offset(25);
    }];
}

- (void)refreshWith:(LDClassModel *)model {
    self.descLabel.text = model.briefIntroduction;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
