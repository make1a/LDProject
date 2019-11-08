//
//  LDAlterPhoneViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/11/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDAlterPhoneViewController.h"
#import "JKCountDownButton.h"
@interface LDAlterPhoneViewController ()
@property (nonatomic,strong)QMUITextField * textfield;
@property (nonatomic,strong)QMUITextField * nPhoneTextfield;
@property (nonatomic,strong)QMUITextField * tfTextfield;
@property (nonatomic,strong)UIBarButtonItem * doneButton;
@property (nonatomic,strong)JKCountDownButton * vfButton;
@end

@implementation LDAlterPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self masLayoutsubview];
    [self countDownAction];
}

- (void)countDownAction{
    [_vfButton countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        NSString *phone = self.nPhoneTextfield.text;
        NSString *oldPhone = self.textfield.text;
        NSString *tfText = self.tfTextfield.text;
        
        if (phone.length != 11) {
            [QMUITips showError:@"请输入正确的手机号"];
            return;
        }
        if (![oldPhone isEqualToString:[LDUserManager shareInstance].currentUser.phone]) {
            [QMUITips showError:@"旧手机号输入不正确"];
            return;
        }
        if (tfText.length == 0) {
            [QMUITips showError:@"请输入验证码"];
            return;
        }
        NSDictionary *dic = @{@"phone":phone,@"bizType":@"1"};
        NSString *url = [NSString stringWithFormat:@"msg/sendmsg/%@/%@",phone,@"1"];
        [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:url requestParameters:dic requestHeader:nil success:^(id responseObject) {
            if (kCODE == 200) {
                sender.enabled = NO;
                [sender startCountDownWithSecond:60];
                
                [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                    NSString *title = [NSString stringWithFormat:@"%zds",second];
                    return title;
                }];
                [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                    countDownButton.enabled = YES;
                    return @"重新获取";
                }];
            }
            ShowMsgInfo;
        } faild:^(NSError *error) {
            
        }];
    }];
}
#pragma  mark - UI
- (void)masLayoutsubview{
    [self.view addSubview:self.textfield];
    [self.view addSubview:self.nPhoneTextfield];
    [self.view addSubview:self.tfTextfield];
    [self.view addSubview:self.vfButton];
    
    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(self.view);
        }
        make.height.mas_equalTo(48);
    }];
    [self.nPhoneTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textfield.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(PtHeight(48));
    }];
    [self.tfTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nPhoneTextfield.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(PtHeight(48));
    }];
    [self.vfButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.tfTextfield).offset(PtWidth(-20));
        make.height.mas_equalTo(PtHeight(30));
        make.width.mas_equalTo(PtWidth(80));
        make.centerY.mas_equalTo(self.tfTextfield);
    }];
    
    self.navigationItem.rightBarButtonItem = self.doneButton;
}
- (void)clickDoneAction:(UIBarButtonItem *)sender {
    [self requestAlterPhoe];
}
#pragma  mark - Request

- (void)requestAlterPhoe {
    NSString *phone = self.nPhoneTextfield.text;
    NSString *pwd = self.tfTextfield.text;
    
    NSDictionary *dic = @{@"phone":phone,@"msgCode":pwd};
    NSString *url = [NSString stringWithFormat:@"msg/validmsg/%@/%@",phone,pwd];
    NSString *alterUrl = [NSString stringWithFormat:@"updatePhone/%@",phone];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:url requestParameters:dic requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:alterUrl requestParameters:@{@"phone":phone} requestHeader:nil success:^(id  _Nonnull responseObject) {
                if (kCODE == 200) {
                    ShowMsgInfo;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }else {
                    ShowMsgInfo;
                }
            } faild:^(NSError * _Nonnull error) {

            }];
        }
    } faild:^(NSError *error) {

    }];
}
#pragma  mark - GET SET
- (QMUITextField *)textfield {
    if (!_textfield) {
        _textfield = [[QMUITextField alloc]init];
        _textfield.placeholder = @"输入旧手机号";
        _textfield.qmui_borderPosition = QMUIViewBorderPositionBottom;
        _textfield.backgroundColor = [UIColor whiteColor];
    }
    return _textfield;
}
- (QMUITextField *)nPhoneTextfield {
    if (!_nPhoneTextfield) {
        _nPhoneTextfield = [[QMUITextField alloc]init];
        _nPhoneTextfield.placeholder = @"输入新手机号";
        _nPhoneTextfield.qmui_borderPosition = QMUIViewBorderPositionBottom;
        _nPhoneTextfield.backgroundColor = [UIColor whiteColor];
    }
    return _nPhoneTextfield;
}
- (QMUITextField *)tfTextfield {
    if (!_tfTextfield) {
        _tfTextfield = [[QMUITextField alloc]init];
        _tfTextfield.placeholder = @"输入验证码";
        _tfTextfield.qmui_borderPosition = QMUIViewBorderPositionBottom;
        _tfTextfield.backgroundColor = [UIColor whiteColor];
    }
    return _tfTextfield;
}
- (JKCountDownButton *)vfButton{
    if (!_vfButton) {
        _vfButton = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
        [_vfButton setTitle:@"验证码" forState:UIControlStateNormal];
        [_vfButton setBackgroundColor: MainThemeColor];
        _vfButton.layer.masksToBounds = YES;
        _vfButton.layer.cornerRadius = PtHeight(10);
        _vfButton.titleLabel.font = [UIFont systemFontOfSize:PtHeight(12)];
    }
    return _vfButton;
}
- (UIBarButtonItem *)doneButton {
    if (!_doneButton) {
        _doneButton = [UIBarButtonItem qmui_itemWithTitle:@"完成" target:self action:@selector(clickDoneAction:)];
    }
    return _doneButton;
}

@end
