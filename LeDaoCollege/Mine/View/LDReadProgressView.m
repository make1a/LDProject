//
//  LDReadProgressView.m
//  LeDaoCollege
//
//  Created by make on 2019/9/12.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDReadProgressView.h"

@implementation LDReadProgressView
- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, SCREEN_HEIGHT-80-73, SCREEN_HEIGHT, 80+73)];
    if (self) {
        self.backgroundColor = UIColorFromHEXA(0x666666, 1);
        [self masLayoutsubviews];
    }
    return self;
}
- (void)masLayoutsubviews{
    [self addSubview:self.slider];
    [self addSubview:self.upButton];
    [self addSubview:self.nextButton];
    [self addSubview:self.smallButton];
    [self addSubview:self.normalButton];
    [self addSubview:self.bigButton];
    
    self.upButton.frame = CGRectMake(PtWidth(55), CGRectGetMaxY(self.slider.frame)+40, 25, 25);
    self.bigButton.frame = CGRectMake(PtWidth(35)+CGRectGetMaxX(self.upButton.frame), CGRectGetMinY(self.upButton.frame), 25, 25);
    self.normalButton.frame = CGRectMake(CGRectGetMaxX(self.bigButton.frame)+PtWidth(35.5), CGRectGetMinY(self.upButton.frame), 25, 25);
    self.smallButton.frame = CGRectMake(CGRectGetMaxX(self.normalButton.frame)+PtWidth(35.5), CGRectGetMinY(self.upButton.frame), 25, 25);
    self.nextButton.frame = CGRectMake(CGRectGetMaxX(self.smallButton.frame)+PtWidth(35.5), CGRectGetMinY(self.upButton.frame), 25, 25);
}
- (void)showSliderPogress
{
    self.slider.value = self.curPage;
}
- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
}
#pragma  mark - GET SET
- (QMUISlider *)slider{
    if (!_slider) {
        _slider = [[QMUISlider alloc]initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH-20, 30)];
    }
    return _slider;
}
- (UIButton *)upButton{
    if (!_upButton) {
        _upButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_upButton setImage:[UIImage imageNamed:@"up_icon"] forState:UIControlStateNormal];
        [_upButton setAdjustsImageWhenHighlighted:NO];
    }
    return _upButton;
}
- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setImage:[UIImage imageNamed:@"next_icon"] forState:UIControlStateNormal];
        [_nextButton setAdjustsImageWhenHighlighted:NO];
    }
    return _nextButton;
}
- (UIButton *)normalButton{
    if (!_normalButton) {
        _normalButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_normalButton setImage:[UIImage imageNamed:@"normal_icon"] forState:UIControlStateNormal];
        [_normalButton setAdjustsImageWhenHighlighted:NO];
    }
    return _normalButton;
}
- (UIButton *)bigButton{
    if (!_bigButton) {
        _bigButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bigButton setImage:[UIImage imageNamed:@"big_icon"] forState:UIControlStateNormal];
        [_bigButton setAdjustsImageWhenHighlighted:NO];
    }
    return _bigButton;
}
- (UIButton *)smallButton{
    if (!_smallButton) {
        _smallButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_smallButton setImage:[UIImage imageNamed:@"small_icon"] forState:UIControlStateNormal];
        [_smallButton setAdjustsImageWhenHighlighted:NO];
    }
    return _smallButton;
}

@end
