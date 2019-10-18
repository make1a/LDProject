//
//  LDConfigTableViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/9.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDConfigTableViewController.h"
#import "DatePickerCell.h"
#import "ClickPickerCell.h"
#import "PickerViewCell.h"
#import "LDHeadImageCell.h"
#import "HNAlertView.h"
#import "LDNameCell.h"
#import "LDAlterNameViewController.h"
#import "LDLoginViewController.h"

@interface LDConfigTableViewController () <UIImagePickerControllerDelegate>
@property (nonatomic,strong)UIButton * logoutButton;
@end

@implementation LDConfigTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI {
    self.title = @"设置";
    self.tableView.separatorInset = UIEdgeInsetsMake(0,10, 0, 10);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.logoutButton];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(PtWidth(37));
        make.width.mas_equalTo(PtWidth(300.5));
        make.height.mas_equalTo(PtHeight(40));
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(PtHeight(-89.5));
        } else {
            make.bottom.mas_equalTo(self.view).mas_offset(PtHeight(-89.5));
        }
    }];
    
    [self.view bringSubviewToFront:self.logoutButton];
}

#pragma  mark - Action
- (void)logOutAction:(UIButton *)sender{
    [LDUserManager removeUserID];
    LDLoginViewController *vc = [LDLoginViewController new];
    [[UIApplication sharedApplication].keyWindow setRootViewController:vc];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            LDHeadImageCell *cell = [LDHeadImageCell dequeueReusableWithTableView:tableView];
            return cell;
        }
            break;
        case 2:
        {
            LDNameCell *cell = [LDNameCell dequeueReusableWithTableView:tableView];
            cell.textLabel.text = @"性别";
            cell.detailTextLabel.text = @"男";
            return cell;
        }
            break;
        case 3:
        {
            LDNameCell *cell = [LDNameCell dequeueReusableWithTableView:tableView];
            cell.textLabel.text = @"手机";
            cell.detailTextLabel.text = @"13380398412";
            return cell;
        }
            break;
        case 4:
        {
            LDNameCell *cell = [LDNameCell dequeueReusableWithTableView:tableView];
            cell.textLabel.text = @"清楚缓存";
            cell.detailTextLabel.text = @"1003M";
            return cell;
        }
            break;
        case 5:
        {
            LDNameCell *cell = [LDNameCell dequeueReusableWithTableView:tableView];
            cell.textLabel.text = @"版本更新";
            return cell;
        }
            break;
        default:
        {
            LDNameCell *cell = [LDNameCell dequeueReusableWithTableView:tableView];
            cell.textLabel.text = @"昵称";
            cell.detailTextLabel.text = @"makemake";
            return cell;
        }
            break;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            [self showSelectPhotoViewAction];
        }
            break;
        case 1:
        {
            LDAlterNameViewController *vc = [LDAlterNameViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            [self showSelectSexViewAction];
        }
            break;
        default:
            break;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return PtHeight(84.5);
            break;
        default:
            return PtHeight(55.5);
            break;
    }
}
#pragma  mark - private
- (void)showSelectPhotoViewAction {
    HNAlertView *view = [[HNAlertView alloc] initWithTitle:nil Content:nil whitTitleArray:@[@"从相册选择",@"拍摄",@"取消"] withType:@"bottom"];
    _weakself;
    [view showAlertView:^(NSInteger index) {
        if (index == 0)
        {
            [weakself selectPhoto:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        else if (index == 1)
        {
            [weakself selectPhoto:UIImagePickerControllerSourceTypeCamera];
            
        }
    }];
}
- (void)showSelectSexViewAction {
    HNAlertView *view = [[HNAlertView alloc] initWithTitle:nil Content:nil whitTitleArray:@[@"男",@"女",@"取消"] withType:@"bottom"];
    _weakself;
    [view showAlertView:^(NSInteger index) {
        if (index == 0)
        {
            
        }
        else if (index == 1)
        {
            
            
        }
    }];
}
#pragma mark - 调用相册处理

-(void)selectPhoto:(UIImagePickerControllerSourceType)type{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    if (type == UIImagePickerControllerSourceTypeCamera) {
        if ([UIImagePickerController isSourceTypeAvailable:type]) {
            picker.sourceType =type;
            if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
                picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
        }
    }else{
        picker.sourceType =type;
        
    }
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //    UIImage *selectedImage = info[@"UIImagePickerControllerOriginalImage"];
    //    //    UIImage *newSelectImg = [HNTools imageCompressForSize:selectedImage targetSize:CGSizeMake((SCREEN_WIDTH-70) * 2, (SCREEN_WIDTH -70) * 2)];
    //    UIImage  *image = [HNTools zipImageWithImage:selectedImage withMaxSize:1000];
    //    // 七牛上传图片， 先获取下上传的token
    //    [MBProgressHUD showMessage:@"正在上传图片..." toView:self.view];
    //    _weakself;
    //    // 腾讯云上传
    //    [[HNTencentUploadTools shareInstance] uploadFileWithImage:image uploadSuccess:^(NSString *resp) {
    //        [MBProgressHUD hideHUDForView:self.view];
    //        _upimgUrl =resp;
    //        [weakself uploadImage:_upimgUrl isVideo:NO];
    //
    //    } uploadFailed:^(NSDictionary *dict) {
    //
    //        [MBProgressHUD hideHUDForView:self.view];
    //        [MBProgressHUD showError:@"头像上传失败"];
    //    }];
}

#pragma  mark - GET SET
- (UIButton *)logoutButton{
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutButton setCornerRadius:PtHeight(20)];
        _logoutButton.backgroundColor = UIColorFromHEXA(0x69B681, 1);
        [_logoutButton addTarget:self action:@selector(logOutAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}
@end
