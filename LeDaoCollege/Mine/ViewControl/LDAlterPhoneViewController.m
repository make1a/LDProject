//
//  LDAlterPhoneViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/11/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDAlterPhoneViewController.h"

@interface LDAlterPhoneViewController ()
@property (nonatomic,strong)QMUITextField * textfield;
@property (nonatomic,strong)QMUITextField * nPhoneTextfield;
@property (nonatomic,strong)QMUITextField * tfTextfield;
@property (nonatomic,strong)UIBarButtonItem * doneButton;
@end

@implementation LDAlterPhoneViewController

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
    
    self.navigationItem.rightBarButtonItem = self.doneButton;
}
- (void)clickDoneAction:(UIBarButtonItem *)sender {
    [self requestAlterName];
}

- (void)requestAlterName {
    NSString *name = self.textfield.text;
    if (name.length == 0) {
        [QMUITips showError:@"您的输入为空"];
        return;
    }
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:@"updateuser" requestParameters:@{@"phone":name} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            [LDUserManager shareInstance].currentUser.phone = name;
            [QMUITips showInfo:responseObject[@"returnMsg"]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } faild:^(NSError *error) {
        
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
- (UIBarButtonItem *)doneButton {
    if (!_doneButton) {
        _doneButton = [UIBarButtonItem qmui_itemWithTitle:@"完成" target:self action:@selector(clickDoneAction:)];
    }
    return _doneButton;
}

@end
