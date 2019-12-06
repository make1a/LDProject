//
//  LDCustomNavBar.m
//  LeDaoCollege
//
//  Created by make on 2019/9/12.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDCustomNavBar.h"

@implementation LDCustomNavBar
- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSTATUSBAR_NAVIGATION_HEIGHT)];
    if (self) {
        [self masLayousuviews];
    }
    return self;
}

- (void)masLayousuviews{
    [self addSubview:self.textLabel];
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.centerY.mas_equalTo(self.textLabel);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self).mas_offset(20);
        make.centerX.mas_equalTo(self);
    }];
}
- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = UIColorFromHEXA(0x666666, 1);
        _textLabel.text = @"书籍名称";
        _textLabel.font = [UIFont systemFontOfSize:16];
    }
    return _textLabel;
}
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"btn_back_red"] forState:UIControlStateNormal];
        [_backButton setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    }
    return _backButton;
}
@end
