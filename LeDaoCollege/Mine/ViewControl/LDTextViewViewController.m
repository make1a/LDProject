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
- (void)clickSumbit{
    [self requestAddLog];
}
- (void)masLayoutSubviews{
    [self.view addSubview:self.textView];
    [self.view addSubview:self.sumbitButton];
    
    [self.sumbitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.textView.mas_bottom).mas_offset(72);
        make.width.mas_equalTo(301);
        make.height.mas_equalTo(41);
    }];
}
- (void)requestAddLog{
    if (self.textView.text.length == 0) {
        [QMUITips showError:@"请输入日志内容"];
        return;
    }
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:@"customerlog/addlog" requestParameters:@{@"customerId":self.c_id,@"content":self.textView.text} requestHeader:nil success:^(id responseObject) {
        ShowMsgInfo;
        if (kCODE == 200) {
            self.textView.text = @"";
        }
    } faild:^(NSError *error) {
        
    }];
}

#pragma  mark - TextView
- (QMUITextView *)textView{
    if (!_textView) {
        _textView = [[QMUITextView alloc]initWithFrame:CGRectMake(10, 10, PtWidth(344), 178)];
//        _textView.placeholder = @"写点什么";
        _textView.backgroundColor = UIColorFromHEXA(0xf4f4f4, 1);
        _textView.layer.cornerRadius = 10.f;
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
        [_sumbitButton setBackgroundColor:MainThemeColor];
        [_sumbitButton addTarget:self action:@selector(clickSumbit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sumbitButton;
}
@end
