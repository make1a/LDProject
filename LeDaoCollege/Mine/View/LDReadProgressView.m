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
    self = [super initWithFrame:CGRectMake(0, SCREEN_HEIGHT-80, SCREEN_HEIGHT, 80)];
    if (self) {
        self.backgroundColor = UIColorFromHEXA(0x666666, 1);
        [self masLayoutsubviews];
    }
    return self;
}
- (void)masLayoutsubviews{
    [self addSubview:self.slider];
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
@end
