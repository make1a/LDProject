//
//  LDTagView.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/10.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDTagView.h"

@implementation LDTagView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorWhite;
        [self masLayoutSubview];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIEdgeInsets padding = UIEdgeInsetsConcat(UIEdgeInsetsMake(26, 26, 26, 26), self.qmui_safeAreaInsets);
    self.advertisingView.frame = CGRectMake(padding.left, padding.top, CGRectGetWidth(self.bounds) - UIEdgeInsetsGetHorizontalValue(padding), QMUIViewSelfSizingHeight);
}
#pragma  mark - Public
- (void)clickButtonAction:(UIButton *)sender{
    if (self.didSelectButtonBlock) {
        self.didSelectButtonBlock(sender.tag-100);
    }
}
#pragma mark - get and set
- (void)setTitles:(NSArray *)titles {
    _titles = titles;

    for (NSInteger i = 0; i < titles.count; i++) {
        QMUIFillButton *button = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
        [button setTitleTextColor:UIColorFromHEXA(0x999999, 1)];
        [button setBackgroundColor:UIColorFromHEXA(0xFFF9F9F9, 1)];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = UIFontMake(14);
        button.contentEdgeInsets = UIEdgeInsetsMake(6, 20, 6, 20);
        button.tag = 100+i;
        [button addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.advertisingView addSubview:button];
    }
}
- (void)masLayoutSubview
{
    
    self.advertisingView = [[QMUIFloatLayoutView alloc] init];
    self.advertisingView.padding = UIEdgeInsetsZero;
    self.advertisingView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
    self.advertisingView.minimumItemSize = CGSizeMake(69, 29);
    [self addSubview:self.advertisingView];
}


@end
