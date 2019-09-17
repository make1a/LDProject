//
//  LDLoginViewController.m
//  LeDaoCollege
//
//  Created by make on 2019/9/8.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDLoginViewController.h"
#import "LoginEnableButton.h"
#import "JKCountDownButton.h"
#import "LDTabBarController.h"

@interface LDLoginViewController ()
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)QMUITextField * nameTextField;
@property (nonatomic,strong)QMUITextField * pwdTextField;
@property (nonatomic,strong)LoginEnableButton * loginButton;
@property (nonatomic,strong)JKCountDownButton * vfButton;
@property (nonatomic,strong)QMUILabel * bottomLabel;
@property (nonatomic,strong)UIButton * wxButton;
@property (nonatomic,strong)UIButton * registerButton;
@property (nonatomic,strong)UIButton * WXLoginButton;
@end

@implementation LDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self masLayoutsuviews];
    [self countDownAction];
}
- (void)countDownAction{
    [_vfButton countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;
        
        [sender startCountDownWithSecond:10];
        
        [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
            return title;
        }];
        [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            return @"点击重新获取";
            
        }];
        
    }];
}
- (void)clickRegisterAction:(UIButton*)sender {
    
}
- (void)clickLoginAction:(UIButton *)sender{
    [self loginApp];
}
#pragma  mark - Private
//登陆
- (void)loginApp {
    LDTabBarController *rootViewController = [[LDTabBarController alloc] init];
    AppDelegate  *delegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = rootViewController;
}
#pragma  mark - Layout
- (void)masLayoutsuviews{
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.vfButton];
    [self.view addSubview:self.bottomLabel];
    [self.view addSubview:self.wxButton];
    [self.view addSubview:self.registerButton];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(PtHeight(76));
    }];
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(75);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(PtWidth(300));
        make.height.mas_equalTo(PtHeight(48));
    }];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameTextField.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(self.nameTextField);
        make.height.mas_equalTo(self.nameTextField);
    }];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.nameTextField);
        make.height.mas_equalTo(PtHeight(40));
        make.top.mas_equalTo(self.pwdTextField.mas_bottom).mas_offset(98);
        make.centerX.mas_equalTo(self.view);
    }];
    [self.vfButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.pwdTextField);
        make.height.mas_equalTo(PtHeight(29));
        make.width.mas_equalTo(PtWidth(80));
        make.bottom.mas_equalTo(self.pwdTextField.mas_bottom).mas_offset(PtHeight(-12));
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-10);
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(10);
        } else {
            make.top.mas_equalTo(self.view).mas_offset(10);
        }
    }];
    [self creatLineView];
    
    [self.view addSubview:self.WXLoginButton];
}
- (void)creatLineView {
    UIView *leftLine = [[UIView alloc] init];
    leftLine.frame = CGRectMake(PtWidth(85.5),PtHeight(518.3),PtWidth(50),0.5);
    leftLine.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    
    UIView *rightLine = [[UIView alloc] init];
    rightLine.frame = CGRectMake(PtWidth(251),PtHeight(518.3),PtWidth(50),0.5);
    rightLine.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(PtWidth(164.5),PtHeight(513),PtWidth(60),PtHeight(11.5));
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"快速注册" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize: PtHeight(12)],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
    label.attributedText = string;
    [label sizeToFit];
    
    [self.view addSubview:leftLine];
    [self.view addSubview:rightLine];
    [self.view addSubview:label];
    
}
#pragma  mark - GET SET
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"手机短信登陆";
        _titleLabel.font = [UIFont systemFontOfSize:25];
    }
    return _titleLabel;
}
- (QMUITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[QMUITextField alloc]init];
        _nameTextField.placeholder = @"输入手机号";
        _nameTextField.qmui_borderPosition = QMUIViewBorderPositionBottom;
        _nameTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _nameTextField;
}
- (QMUITextField *)pwdTextField {
    if (!_pwdTextField) {
        _pwdTextField = [[QMUITextField alloc]init];
        _pwdTextField.placeholder = @"请输入验证码";
        _pwdTextField.qmui_borderPosition = QMUIViewBorderPositionBottom;
        _pwdTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _pwdTextField;
}
- (JKCountDownButton *)vfButton{
    if (!_vfButton) {
        _vfButton = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
        [_vfButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_vfButton setBackgroundColor:UIColorFromHEXA(0xFF07C062, 1)];
        _vfButton.layer.masksToBounds = YES;
        _vfButton.layer.cornerRadius = PtHeight(10);
        _vfButton.titleLabel.font = [UIFont systemFontOfSize:PtHeight(12)];
    }
    return _vfButton;
}
- (LoginEnableButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[LoginEnableButton alloc]initAndNotifyTextFields:@[self.nameTextField,self.pwdTextField]];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.backgroundColor = [UIColor blueColor];
        [_loginButton addTarget:self action:@selector(clickLoginAction:) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = PtHeight(20);
        [_loginButton addGradViewWithSize:CGSizeMake(300,PtHeight(40))];
    }
    return _loginButton;
}

- (QMUILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = [[QMUILabel alloc]init];
        _bottomLabel.text = @"微信登陆";
        _bottomLabel.qmui_borderPosition = QMUIViewBorderPositionLeft & QMUIViewBorderPositionRight;
    }
    return _bottomLabel;
}
- (UIButton *)wxButton{
    if (!_wxButton) {
        _wxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _wxButton;
}
- (UIButton *)registerButton{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(clickRegisterAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}
- (UIButton *)WXLoginButton{
    if (!_WXLoginButton) {
        _WXLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_WXLoginButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _WXLoginButton.frame = CGRectMake(PtWidth(169.5),PtHeight(569.8),PtWidth(37.5),PtHeight(37.5));
    }
    return _WXLoginButton;
}
@end
