//
//  LDTextViewViewController.m
//  LeDaoCollege
//
//  Created by make on 2019/9/7.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDTextViewViewController.h"

@interface LDTextViewViewController ()
@property (nonatomic,strong)QMUITextView * textView;
@property (nonatomic,strong)QMUIFillButton * sumbitButton;
@end

@implementation LDTextViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self masLayoutSubviews];
}

- (void)masLayoutSubviews{
    [self.view addSubview:self.textView];
    [self.view addSubview:self.sumbitButton];
    
    [self.sumbitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.textView.mas_bottom).mas_offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(48);
    }];
}

#pragma  mark - TextView
- (QMUITextView *)textView{
    if (!_textView) {
        _textView = [[QMUITextView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 300)];
        _textView.placeholder = @"写点什么";
        _textView.layer.borderColor = [UIColor blackColor].CGColor;
        _textView.layer.borderWidth = 1.f;
        _textView.layer.cornerRadius = 5.f;
        _textView.layer.masksToBounds = YES;
    }
    return _textView;
}
- (QMUIFillButton *)sumbitButton {
    if (!_sumbitButton) {
        _sumbitButton = [[QMUIFillButton alloc]initWithFillType:QMUIFillButtonColorBlue];
        _sumbitButton.layer.cornerRadius = 5;
        [_sumbitButton setTitle:@"提交" forState:UIControlStateNormal];
        _sumbitButton.layer.masksToBounds = YES;
    }
    return _sumbitButton;
}
@end
