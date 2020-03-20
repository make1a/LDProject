//
//  LDAddCustomViewController.m
//  LeDaoCollege
//
//  Created by Make on 2020/3/19.
//  Copyright © 2020 Make. All rights reserved.
//

#import "LDAddCustomViewController.h"
#import "LDAddNameTableViewCell.h"
#import "ClickPickerCell.h"
#import "DatePickerCell.h"
@interface LDAddCustomViewController ()

@property (nonatomic,strong)QMUIFillButton * confirmButton;
@end

@implementation LDAddCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加客户";
    self.confirmButton = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.view addSubview:self.confirmButton];
    self.confirmButton.fillColor = MainThemeColor;
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH-50);
        make.height.mas_equalTo(48);
        make.bottom.mas_equalTo(self.view).mas_offset(-200);
    }];
    [self.confirmButton addTarget:self action:@selector(confirmData) forControlEvents:UIControlEventTouchUpInside];
}
- (void)confirmData{
    
    /*
     //姓名
     private String name;
     //性别
     private String sex;
     //职位
     private String position;
     //出生日期
     private String birthDate;
     //电话号码
     private String phone;
     //公司名称
     private String companyName;
     */
    NSString *name = [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]valueForKeyPath:@"_textField.text"];
    NSString *phone = [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]valueForKeyPath:@"_textField.text"];
    NSString *companyName = [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]]valueForKeyPath:@"_textField.text"];
    NSString *duty = [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]]valueForKeyPath:@"_textField.text"];
    NSString *sex = [[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]] valueForKeyPath:@"_detailTextLabel.text"] isEqualToString:@"男"]?@"1":@"0";
    NSString *birthDay = [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]] valueForKeyPath:@"_detailTextLabel.text"];
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    if (name.length == 0) {
        [QMUITips showError:@"请输入姓名"];
        return;
    }
    if (phone.length != 11) {
        [QMUITips showError:@"请输入手机号"];
        return;
    }
    if (companyName.length == 0) {
        [QMUITips showError:@"请输入公司名称"];
        return;
    }
    if (duty.length == 0) {
        [QMUITips showError:@"请输入职位"];
        return;
    }
    if (sex.length == 0) {
        [QMUITips showError:@"请选择性别"];
        return;
    }
    if (birthDay.length != 0) {
        [dic setValue:birthDay forKey:@"birthDate"];
    }
    [dic setValue:name forKey:@"name"];
    [dic setValue:sex forKey:@"sex"];
    [dic setValue:duty forKey:@"position"];
    [dic setValue:phone forKey:@"phone"];
    [dic setValue:companyName forKey:@"companyName"];
    
    
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:@"customer/addcustomer" requestParameters:dic requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            [QMUITips showSucceed:@"提交成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [QMUITips showError:@"网络错误,请稍后重试"];
        }
    } faild:^(NSError *error) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            LDAddNameTableViewCell *cell = [LDAddNameTableViewCell dequeueReusableWithTableView:tableView];
            return cell;
        }
            break;
        case 1:
        {
            LDAddNameTableViewCell *cell = [LDAddNameTableViewCell dequeueReusableWithTableView:tableView];
            [cell setNameText:@"* 手机号码"];
            cell.textField.placeholder = @"请输入手机号码";
            cell.textField.keyboardType = UIKeyboardTypePhonePad;
            return cell;
        }
        case 2:
        {
            ClickPickerCell *cell = [ClickPickerCell dequeueReusableWithTableView:tableView dataSource:@[@"男",@"女"]];
            __weak typeof (cell)weakCell = cell;
            cell.selectClickPickerBlock = ^(NSInteger index, NSString *str) {
                [weakCell setDetailTitle:str];
            };
            return cell;
        }
        case 3:
        {
            DatePickerCell *cell = [DatePickerCell dequeueReusableWithTableView:tableView];
                __weak typeof (cell)weakCell = cell;
                cell.selectDatePickerBlock = ^(NSDate *date) {
                    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                    [formatter setDateFormat:@"yyyy-MM-dd"];
                    weakCell.detailTextLabel.text = [formatter stringFromDate:date];
                };
            return cell;
        }
        case 4:
        {
            LDAddNameTableViewCell *cell = [LDAddNameTableViewCell dequeueReusableWithTableView:tableView];
            cell.textField.placeholder = @"请输入公司名称";
            [cell setNameText:@"* 公司名称"];
            return cell;
        }
        default:
        {
            LDAddNameTableViewCell *cell = [LDAddNameTableViewCell dequeueReusableWithTableView:tableView];
            [cell setNameText:@"* 公司职务"];
            cell.textField.placeholder = @"请输入公司职务";
            return cell;
        }
            break;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.isFirstResponder) {
        [cell resignFirstResponder];
    }else{
        [cell becomeFirstResponder];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}
@end
