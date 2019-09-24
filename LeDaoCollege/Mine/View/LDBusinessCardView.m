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
@property (nonatomic,strong) UILabel * sexLabel2;
@property (nonatomic,strong) UILabel * birthDayLabel2;
@property (nonatomic,strong) UILabel * descLabel2;
@property (nonatomic,strong) UIView * blueView;
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
    CGFloat pandingLeft = 17;
    self.nameLabel.frame = CGRectMake(28, 14, self.qmui_width, QMUIViewSelfSizingHeight);
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(pandingLeft, 50, SCREEN_WIDTH-2*pandingLeft, 1)];
    [self addSubview:lineView];
    
    self.sexLabel2.frame = CGRectMake(pandingLeft, CGRectGetMaxY(lineView.frame)+14, self.qmui_width, QMUIViewSelfSizingHeight);
    self.birthDayLabel2.frame = CGRectMake(pandingLeft, CGRectGetMaxY(self.sexLabel2.frame)+10, self.qmui_width, QMUIViewSelfSizingHeight);
    self.descLabel2.frame = CGRectMake(pandingLeft, CGRectGetMaxY(self.birthDayLabel2.frame)+10, self.qmui_width, QMUIViewSelfSizingHeight);
    
    [self addSubview:self.blueView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.sexLabel2];
    [self addSubview:self.birthDayLabel2];
    [self addSubview:self.descLabel2];
    
    [self addSubview:self.sexLabel];
    [self addSubview:self.birthDayLabel];
    [self addSubview:self.descLabel];
    
    [self.sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.sexLabel2);
        make.right.mas_equalTo(self).mas_offset(-pandingLeft);
    }];
    [self.birthDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.birthDayLabel2);
        make.right.mas_equalTo(self).mas_offset(-pandingLeft);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.descLabel2);
        make.right.mas_equalTo(self).mas_offset(-pandingLeft);
    }];
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

- (UILabel *)sexLabel2 {
    if (!_sexLabel2) {
        _sexLabel2 = [[UILabel alloc]init];
        _sexLabel2.font = [UIFont systemFontOfSize:16];
        _sexLabel2.textColor = UIColorFromHEXA(0x999999, 1);
        _sexLabel2.text = @"性别";
    }
    return _sexLabel2;
}
- (UILabel *)birthDayLabel2 {
    if (!_birthDayLabel2) {
        _birthDayLabel2 = [[UILabel alloc]init];
        _birthDayLabel2.font = [UIFont systemFontOfSize:16];
        _birthDayLabel2.textColor = UIColorFromHEXA(0x999999, 1);
        _birthDayLabel2.text = @"出生日期";
    }
    return _birthDayLabel2;
}
- (UILabel *)descLabel2 {
    if (!_descLabel2) {
        _descLabel2 = [[UILabel alloc]init];
        _descLabel2.font = [UIFont systemFontOfSize:16];
        _descLabel2.textColor = UIColorFromHEXA(0x999999, 1);
        _descLabel2.text = @"其他资料";
    }
    return _descLabel2;
}
- (UILabel *)sexLabel {
    if (!_sexLabel) {
        _sexLabel = [[UILabel alloc]init];
        _sexLabel.font = [UIFont systemFontOfSize:16];
        _sexLabel.textColor = UIColorFromHEXA(0x999999, 1);
        _sexLabel.text = @"男";
    }
    return _sexLabel;
}
- (UILabel *)birthDayLabel {
    if (!_birthDayLabel) {
        _birthDayLabel = [[UILabel alloc]init];
        _birthDayLabel.font = [UIFont systemFontOfSize:16];
        _birthDayLabel.textColor = UIColorFromHEXA(0x999999, 1);
        _birthDayLabel.text = @"2019-09-24";
    }
    return _birthDayLabel;
}
- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = [UIFont systemFontOfSize:16];
        _descLabel.textColor = UIColorFromHEXA(0x999999, 1);
        _descLabel.text = @"其他资料";
    }
    return _descLabel;
}
- (UIView *)blueView{
    if (!_blueView) {
        _blueView = [[UIView alloc]initWithFrame:CGRectMake(17, 16, 6, 21)];
        _blueView.backgroundColor = MainThemeColor;
    }
    return _blueView;
}
@end
