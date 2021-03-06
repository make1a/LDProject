//
//  LDSearchHistoryView.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/6.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDSearchHistoryView.h"

@interface LDSearchHistoryView()

@property(nonatomic, strong) QMUILabel *advertisingLabel;
@property(nonatomic, strong) QMUILabel *historyLabel;
@property(nonatomic, strong) QMUIFloatLayoutView *advertisingView;
@property(nonatomic, strong) QMUIFloatLayoutView *historyView;
@end

@implementation LDSearchHistoryView

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
    CGFloat titleLabelMarginTop = 20;
    self.advertisingLabel.frame = CGRectMake(padding.left, padding.top, CGRectGetWidth(self.bounds) - UIEdgeInsetsGetHorizontalValue(padding), CGRectGetHeight(self.advertisingLabel.frame));
    CGFloat minY = CGRectGetMaxY(self.advertisingLabel.frame) + titleLabelMarginTop;
    self.advertisingView.frame = CGRectMake(padding.left, minY, CGRectGetWidth(self.bounds) - UIEdgeInsetsGetHorizontalValue(padding), QMUIViewSelfSizingHeight);
    
    CGFloat historyMinY = CGRectGetMaxY(self.advertisingView.frame) + titleLabelMarginTop;
    self.historyLabel.frame = CGRectMake(padding.left, historyMinY, CGRectGetWidth(self.bounds) - UIEdgeInsetsGetHorizontalValue(padding), QMUIViewSelfSizingHeight);
    
    CGFloat historyViewMinY = CGRectGetMaxY(self.historyLabel.frame) + titleLabelMarginTop;
    self.historyView.frame = CGRectMake(padding.left, historyViewMinY, CGRectGetWidth(self.bounds) - UIEdgeInsetsGetHorizontalValue(padding), QMUIViewSelfSizingHeight);

}
- (void)clickHistoryAction:(UIButton *)sender{
    if (self.didSelectHistoryActionBlock) {
        self.didSelectHistoryActionBlock(sender.currentTitle);
    }
}
- (void)clickAdvanceAction:(UIButton *)sender{
    if (self.didSelectAdvanceActionBlock) {
        self.didSelectAdvanceActionBlock(sender.currentTitle);
    }
}
#pragma mark - get and set
- (void)masLayoutSubview
{
    self.advertisingLabel = [[QMUILabel alloc]init];
    self.advertisingLabel.text = @"热门搜索";
    self.advertisingLabel.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    [self.advertisingLabel sizeToFit];
    self.advertisingLabel.qmui_borderPosition = QMUIViewBorderPositionBottom;
    [self addSubview:self.advertisingLabel];
    
    self.historyLabel = [[QMUILabel alloc]init];
    self.historyLabel.text = @"历史记录";
    self.historyLabel.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
    [self.historyLabel sizeToFit];
    self.historyLabel.qmui_borderPosition = QMUIViewBorderPositionBottom;
    [self addSubview:self.historyLabel];
    
    self.advertisingView = [[QMUIFloatLayoutView alloc] init];
    self.advertisingView.padding = UIEdgeInsetsZero;
    self.advertisingView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
    self.advertisingView.minimumItemSize = CGSizeMake(69, 29);
    [self addSubview:self.advertisingView];
    
    self.historyView = [[QMUIFloatLayoutView alloc] init];
    self.historyView.padding = UIEdgeInsetsZero;
    self.historyView.itemMargins = UIEdgeInsetsMake(0, 0, 10, 10);
    self.historyView.minimumItemSize = CGSizeMake(69, 29);
    [self addSubview:self.historyView];

}


- (void)setHistroyArray:(NSArray *)histroyArray{
    _histroyArray = histroyArray;
    for (UIView *view in self.historyView.subviews) {
        [view removeFromSuperview];
    }
    for (NSInteger i = 0; i < histroyArray.count; i++) {
        QMUIGhostButton *button = [[QMUIGhostButton alloc] initWithGhostType:QMUIGhostButtonColorGray];
        [button setTitle:histroyArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = UIFontMake(14);
        button.contentEdgeInsets = UIEdgeInsetsMake(6, 20, 6, 20);
        [self.historyView addSubview:button];
        [button addTarget:self action:@selector(clickHistoryAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.historyView setNeedsLayout];
    [self setNeedsLayout];

}

- (void)setAdvanceArray:(NSArray *)advanceArray {
    _advanceArray = advanceArray;
    for (UIView *view in self.advertisingView.subviews) {
        [view removeFromSuperview];
    }
    for (NSInteger i = 0; i < advanceArray.count; i++) {
        QMUIGhostButton *button = [[QMUIGhostButton alloc] initWithGhostType:QMUIGhostButtonColorGray];
        [button setTitle:advanceArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = UIFontMake(14);
        button.contentEdgeInsets = UIEdgeInsetsMake(6, 20, 6, 20);
        [self.advertisingView addSubview:button];
        [button addTarget:self action:@selector(clickAdvanceAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.advertisingView setNeedsLayout];
    [self setNeedsLayout];
}

@end
