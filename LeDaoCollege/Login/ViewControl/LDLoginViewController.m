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
#import <UMShare/UMShare.h>
#import "LDPrivateViewController.h"

@interface LDLoginViewController ()
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)QMUITextField * nameTextField;
@property (nonatomic,strong)QMUITextField * pwdTextField;
@property (nonatomic,strong)LoginEnableButton * loginButton;
@property (nonatomic,strong)JKCountDownButton * vfButton;
@property (nonatomic,strong)QMUILabel * bottomLabel;
@property (nonatomic,strong)UIButton * wxButton;
//@property (nonatomic,strong)UIButton * registerButton;
@property (nonatomic,strong)UIButton * WXLoginButton;
@property (nonatomic,strong)UIButton * registerAgreeBtn;
@property (nonatomic,strong)UIButton * AgreeBtn;
@end

@implementation LDLoginViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self masLayoutsuviews];
    [self countDownAction];
    [self configUI];
}
- (void)countDownAction{
    [_vfButton countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;
        
        [sender startCountDownWithSecond:60];
        [self sendCode];
        
        [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"%zds",second];
            return title;
        }];
        [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            return @"重新获取";
            
        }];
        
    }];
}
- (void)clickRegisterAction:(UIButton*)sender {
    LDLoginViewController *vc = [LDLoginViewController new];
    vc.currentPageType = LDCurrentPageIsRegister;
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)agreeButClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.loginButton.backgroundColor = MainThemeColor;
    }else{
        self.loginButton.backgroundColor = [UIColor grayColor];
    }
}
- (void)clickLoginAction:(UIButton *)sender{
    if (self.AgreeBtn.isSelected == NO) {
        [QMUITips showError:@"请先同意服务及隐私政策"];
        return;
    }
    if (self.currentPageType == LDCurrentPageIsLogin) {
        [self loginApp];
    } else if (self.currentPageType == LDCurrentPageIsRegister){
        [self regiserAPP];
    } else {
        [self bindApp];
    }
}
- (void)clickBackButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)clickPushAgreeAction{
    LDPrivateViewController *vc = [[LDPrivateViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];
}
#pragma  mark - Private
- (void)sendCode {
    NSString *phone = self.nameTextField.text;

    if (phone.length != 11) {
        [QMUITips showError:@"请输入正确的手机号"];
        return;
    }

    NSDictionary *dic = @{@"phone":phone,@"bizType":@"1"};
    NSString *url = [NSString stringWithFormat:@"msg/sendmsg/%@/%@",phone,@"1"];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:url requestParameters:dic requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            ShowMsgInfo;
        }else{
            [QMUITips showError:responseObject[@"returnMsg"]];
        }
    } faild:^(NSError *error) {
        
    }];

}
//登录
- (void)loginApp {
    
    NSString *phone = self.nameTextField.text;
    NSString *pwd = self.pwdTextField.text;
    if (phone.length != 11) {
        [QMUITips showError:@"请输入正确的手机号"];
        return;
    }
    if (pwd.length <= 0) {
        [QMUITips showError:@"请输入验证码"];
        return;
    }
    NSDictionary *dic = @{@"phone":phone,@"msgCode":pwd};
    NSString *url = [NSString stringWithFormat:@"msg/validmsg/%@/%@",phone,pwd];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:url requestParameters:dic requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:kLoginAPI requestParameters:@{@"phone":phone} requestHeader:nil success:^(id  _Nonnull responseObject) {
                if (kCODE == 200) {
                    LDUserModel *model = [LDUserModel yy_modelWithDictionary:responseObject[@"data"][@"user"]];
                    [LDUserManager shareInstance].currentUser = model;
                    [QMUITips showSucceed:@"登录成功"];
                    [self pushMain];
                }else {
                    [QMUITips showError:responseObject[@"returnMsg"]];
                }
            } faild:^(NSError * _Nonnull error) {
                DLog(@"%@",error);
            }];
        }
    } faild:^(NSError *error) {
        [QMUITips showError:error.localizedDescription];
    }];
}
- (void)bindApp {
    
    NSString *phone = self.nameTextField.text;
    NSString *pwd = self.pwdTextField.text;
    if (phone.length != 11) {
        [QMUITips showError:@"请输入正确的手机号"];
        return;
    }
    if (pwd.length <= 0) {
        [QMUITips showError:@"请输入验证码"];
        return;
    }
    NSDictionary *dic = @{@"phone":phone,@"msgCode":pwd};
    NSString *url = [NSString stringWithFormat:@"msg/validmsg/%@/%@",phone,pwd];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:url requestParameters:dic requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            [self.WXInfoDic setValue:phone forKey:@"phone"];
            [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:@"wxlogin/bindphone" requestParameters:self.WXInfoDic requestHeader:nil success:^(id  _Nonnull responseObject) {
                if (kCODE == 200) {
                    LDUserModel *model = [LDUserModel yy_modelWithDictionary:responseObject[@"data"][@"user"]];
                    [LDUserManager shareInstance].currentUser = model;
                    [QMUITips showSucceed:@"绑定成功"];
                    [self pushMain];
                }else {
                    [QMUITips showError:responseObject[@"returnMsg"]];
                }
            } faild:^(NSError * _Nonnull error) {
                DLog(@"%@",error);
                [QMUITips showError:error.localizedDescription];
            }];
        }else{
            [QMUITips showError:responseObject[@"returnMsg"]];
        }
    } faild:^(NSError *error) {
[QMUITips showError:error.localizedDescription];
    }];
}
- (void)regiserAPP {
    NSString *phone = self.nameTextField.text;
    NSString *pwd = self.pwdTextField.text;
    if (phone.length != 11) {
        [QMUITips showError:@"请输入正确的手机号"];
        return;
    }
    if (pwd.length <= 0) {
        [QMUITips showError:@"请输入验证码"];
        return;
    }
    NSDictionary *dic = @{@"phone":phone,@"msgCode":pwd};
    NSString *url = [NSString stringWithFormat:@"msg/validmsg/%@/%@",phone,pwd];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:url requestParameters:dic requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:kRegister requestParameters:@{@"phone":phone,@"userName":@"",@"pwd":@""} requestHeader:nil success:^(id  _Nonnull responseObject) {
                if (kCODE == 200) {
                    LDUserModel *model = [LDUserModel yy_modelWithDictionary:responseObject[@"data"][@"user"]];
                    [LDUserManager shareInstance].currentUser = model;
                    [QMUITips showSucceed:@"注册成功"];
                    [self pushMain];
                }
                DLog(@"%@",responseObject);
            } faild:^(NSError * _Nonnull error) {
                DLog(@"%@",error);
            }];
        }
    } faild:^(NSError *error) {
[QMUITips showError:error.localizedDescription];
    }];
}
- (void)pushMain{
    LDTabBarController *rootViewController = [[LDTabBarController alloc] init];
    AppDelegate  *delegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = rootViewController;
}

- (void)WXlogin{
    [[UMSocialManager defaultManager]getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            [QMUITips showError:error.localizedDescription];
        } else {
            UMSocialUserInfoResponse *resp = result;
            NSDictionary *dic = @{@"openId":resp.openid};
            NSString *api = [NSString stringWithFormat:@"wxlogin/login/%@",resp.openid];
            self.WXInfoDic = @{@"openid":resp.openid,@"access_token":resp.accessToken}.mutableCopy;
        
            [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:api requestParameters:dic requestHeader:nil success:^(id responseObject) {
                if (kCODE == 200) {
                    NSDictionary *da = responseObject[@"data"];
                    if ([da isEqual:[NSNull null]]) {
                           LDLoginViewController *vc = [LDLoginViewController new];
                       vc.currentPageType = LDCurrentPageIsBindPhone;
                        vc.WXInfoDic = self.WXInfoDic;
                       [self presentViewController:vc animated:YES completion:nil];
                    } else {
                        LDUserModel *model = [LDUserModel yy_modelWithDictionary:responseObject[@"data"][@"user"]];
                        [LDUserManager shareInstance].currentUser = model;
                        [self pushMain];
                    }
                }
            } faild:^(NSError *error) {
                [QMUITips showError:error.localizedDescription];
            }];
        }
    }];
}
#pragma  mark - LayoutUI
- (void)configUI{
    switch (self.currentPageType) {
        case LDCurrentPageIsRegister:
        {
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom]     ;
            [backButton setImage:[UIImage imageNamed:@"nav_black"] forState:UIControlStateNormal];
            [backButton addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:backButton];
            backButton.frame = CGRectMake(15, kSTATUSBAR_HEIGHT+20, 20, 20);
            
            self.titleLabel.text  = @"注册";
            [self.loginButton setTitle:@"完成注册并登录" forState:UIControlStateNormal];
        }
            break;
        case LDCurrentPageIsBindPhone:
        {
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [backButton setImage:[UIImage imageNamed:@"nav_black"] forState:UIControlStateNormal];
            [backButton addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:backButton];
            backButton.frame = CGRectMake(15, kSTATUSBAR_HEIGHT+20, 20, 20);
            
            self.titleLabel.text  = @"绑定手机号";
            [self.loginButton setTitle:@"完成注册并登录" forState:UIControlStateNormal];
        }
            break;
        default:
        {
            [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
            self.titleLabel.text = @"手机短信登录";
        }
            break;
    }
}
- (void)masLayoutsuviews{
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.pwdTextField];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.vfButton];
    [self.view addSubview:self.bottomLabel];
    [self.view addSubview:self.wxButton];
//    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.AgreeBtn];
    [self.view addSubview:self.registerAgreeBtn];
    
    
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
    
    [self.AgreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pwdTextField);
        make.top.mas_equalTo(self.pwdTextField.mas_bottom).mas_offset(15);
    }];
    [self.registerAgreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.AgreeBtn.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.AgreeBtn);
    }];
//    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.view).mas_offset(-10);
//        if (@available(iOS 11.0, *)) {
//            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(10);
//        } else {
//            make.top.mas_equalTo(self.view).mas_offset(10);
//        }
//    }];
    
    if (self.currentPageType == LDCurrentPageIsLogin) {
        [self.view addSubview:self.WXLoginButton];
        if ([[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatSession]) {
            _WXLoginButton.hidden = NO;
            self.bottomLabel.hidden = NO;
            [self creatLineView];
        }else{
            _WXLoginButton.hidden = YES;
            self.bottomLabel.hidden = YES;
        }
    }
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
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"微信登录" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize: PtHeight(12)],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
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
        [_vfButton setBackgroundColor: MainThemeColor];
        _vfButton.layer.masksToBounds = YES;
        _vfButton.layer.cornerRadius = PtHeight(10);
        _vfButton.titleLabel.font = [UIFont systemFontOfSize:PtHeight(12)];
    }
    return _vfButton;
}
- (LoginEnableButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[LoginEnableButton alloc]initAndNotifyTextFields:@[self.nameTextField,self.pwdTextField]];
        
        _loginButton.backgroundColor = MainThemeColor;
        [_loginButton addTarget:self action:@selector(clickLoginAction:) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = PtHeight(20);
    }
    return _loginButton;
}

- (QMUILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = [[QMUILabel alloc]init];
        _bottomLabel.text = @"快速登录";
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
//- (UIButton *)registerButton{
//    if (!_registerButton) {
//        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
//        [_registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_registerButton addTarget:self action:@selector(clickRegisterAction:) forControlEvents:UIControlEventTouchUpInside];
//        if (self.currentPageType == 0) {
//            _registerButton.hidden = NO;
//        }else {
//            _registerButton.hidden = !NO;
//        }
//    }
//    return _registerButton;
//}
- (UIButton *)WXLoginButton{
    if (!_WXLoginButton) {
        _WXLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_WXLoginButton setBackgroundImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
        _WXLoginButton.frame = CGRectMake(PtWidth(169.5),PtHeight(569.8),PtWidth(37.5),PtHeight(37.5));
        [_WXLoginButton sizeToFit];
        [_WXLoginButton addTarget:self action:@selector(WXlogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _WXLoginButton;
}
- (UIButton *)AgreeBtn
{
    if(!_AgreeBtn)
    {
        _AgreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_AgreeBtn setImage:[UIImage imageNamed:@"not_checked_registration"] forState:UIControlStateNormal];
        [_AgreeBtn setImage:[UIImage imageNamed:@"elect_registration"] forState:UIControlStateSelected];
        _AgreeBtn.selected = YES;
        [_AgreeBtn addTarget:self action:@selector(agreeButClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _AgreeBtn;
}
- (UIButton *)registerAgreeBtn
{
    if(!_registerAgreeBtn)
    {
        NSString *allString = [NSString stringWithFormat:@"登录代表您已同意服务及隐私条款"];
        NSString *agreeString = [NSString stringWithFormat:@"服务及隐私条款"];
        _registerAgreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerAgreeBtn setTitle:allString forState:UIControlStateNormal];
        [_registerAgreeBtn setTitleColor:UIColorFromHEXA(0x999999, 1.0) forState:UIControlStateNormal];
        _registerAgreeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [_registerAgreeBtn addTarget:self action:@selector(clickPushAgreeAction) forControlEvents:UIControlEventTouchUpInside];
        NSAttributedString *string = [HNTools getAttributedString:allString withStringAttributedDic:@{NSForegroundColorAttributeName : UIColorFromHEXA(0x999999, 1.0)} withSubString:agreeString withSubStringAttributeDic:@{NSForegroundColorAttributeName : [UIColor redColor],NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
        [_registerAgreeBtn setAttributedTitle:string forState:UIControlStateNormal];
    }
    return _registerAgreeBtn;
}

@end
