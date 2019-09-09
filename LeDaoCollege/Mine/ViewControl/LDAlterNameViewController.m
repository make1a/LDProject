//
//  LDAlterNameViewController.m
//  LeDaoCollege
//
//  Created by make on 2019/9/9.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDAlterNameViewController.h"
@interface LDAlterNameViewController ()
@property (nonatomic,strong)QMUITextField * textfield;
@end

@implementation LDAlterNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self masLayoutsubview];
}
- (void)masLayoutsubview{
    [self.view addSubview:self.textfield];
    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.view);
        }
        make.height.mas_equalTo(48);
    }];
}
#pragma  mark - GET SET
- (QMUITextField *)textfield {
    if (!_textfield) {
        _textfield = [[QMUITextField alloc]init];
        _textfield.placeholder = @"输入昵称";
        _textfield.qmui_borderPosition = QMUIViewBorderPositionBottom;
        _textfield.backgroundColor = [UIColor whiteColor];
        
    }
    return _textfield;
}
@end
