//
//  LDBusinessCardView.m
//  LeDaoCollege
//
//  Created by make on 2019/9/7.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDBusinessCardView.h"
@interface LDBusinessCardView ()
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * sexLabel;
@property (nonatomic,strong) UILabel * birthDayLabel;
@property (nonatomic,strong) UILabel * descLabel;
@end
@implementation LDBusinessCardView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        [self masLayoutSubviews];
    }
    return self;
}
- (void)masLayoutSubviews{
    CGFloat pandingLeft = 10;
    self.nameLabel.frame = CGRectMake(pandingLeft, 10, self.qmui_width, QMUIViewSelfSizingHeight);
    self.sexLabel.frame = CGRectMake(pandingLeft, CGRectGetMaxY(self.nameLabel.frame)+5, self.qmui_width, QMUIViewSelfSizingHeight);
    self.birthDayLabel.frame = CGRectMake(pandingLeft, CGRectGetMaxY(self.sexLabel.frame)+5, self.qmui_width, QMUIViewSelfSizingHeight);
    self.descLabel.frame = CGRectMake(pandingLeft, CGRectGetMaxY(self.birthDayLabel.frame)+5, self.qmui_width, QMUIViewSelfSizingHeight);
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.sexLabel];
    [self addSubview:self.birthDayLabel];
    [self addSubview:self.descLabel];
}
#pragma  mark - GET & SET
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:25];
        _nameLabel.text = @"make";
        _nameLabel.qmui_borderPosition = QMUIViewBorderPositionBottom;
    }
    return _nameLabel;
}

- (UILabel *)sexLabel {
    if (!_sexLabel) {
        _sexLabel = [[UILabel alloc]init];
        _sexLabel.font = [UIFont systemFontOfSize:16];
        _sexLabel.text = @"性别：男";
    }
    return _sexLabel;
}
- (UILabel *)birthDayLabel {
    if (!_birthDayLabel) {
        _birthDayLabel = [[UILabel alloc]init];
        _birthDayLabel.font = [UIFont systemFontOfSize:16];
        _birthDayLabel.text = @"出生日期: 1998-08-12";
    }
    return _birthDayLabel;
}
- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = [UIFont systemFontOfSize:16];
        _descLabel.text = @"其他资料";
    }
    return _descLabel;
}

@end
