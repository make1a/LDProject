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
#import <SDImageCache.h>
#import "LDAlterPhoneViewController.h"
#import <StoreKit/StoreKit.h>

@interface LDConfigTableViewController () <UIImagePickerControllerDelegate,SKStoreProductViewControllerDelegate>
@property (nonatomic,strong)UIButton * logoutButton;
@end

@implementation LDConfigTableViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
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
- (void)checkVesion{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"/app/getversion/2" requestParameters:nil requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            NSString *code = responseObject[@"data"][@"version_code"];
            CGFloat version = [code floatValue];
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            CGFloat appV = [app_Version floatValue];
            if (appV < version) {
                [QMUITips showInfo:@"当前存在可以更新的版本"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self update];
                });
            }else{
                [QMUITips showInfo:@"当前已是最新版本"];
            }
        }
    } faild:^(NSError *error) {
        
    }];
}
- (void)update{
    SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
    //设置代理请求为当前控制器本身
    storeProductViewContorller.delegate = self;
    //加载一个新的视图展示
    [storeProductViewContorller loadProductWithParameters:
     //appId唯一的
     @{SKStoreProductParameterITunesItemIdentifier : @"1486286817"} completionBlock:^(BOOL result, NSError *error) {
         //block回调
         if(error){
             NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
         }else{
             //模态弹出appstore
             [self presentViewController:storeProductViewContorller animated:YES completion:^{
                 
             }
              ];
         }
    }];
}
//取消按钮监听
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
            NSURL *url = [NSURL URLWithString:[LDUserManager shareInstance].currentUser.headImgUrl];
            [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"seizeaseat_0"]];
            return cell;
        }
            break;
        case 2:
        {
            LDNameCell *cell = [LDNameCell dequeueReusableWithTableView:tableView];
            cell.textLabel.text = @"性别";
            cell.detailTextLabel.text = [[LDUserManager shareInstance].currentUser.sex isEqualToString:@"1"]?@"男":@"女";
            return cell;
        }
            break;
        case 3:
        {
            LDNameCell *cell = [LDNameCell dequeueReusableWithTableView:tableView];
            cell.textLabel.text = @"手机";
            cell.detailTextLabel.text = [LDUserManager shareInstance].currentUser.phone;
            return cell;
        }
            break;
        case 4:
        {
            LDNameCell *cell = [LDNameCell dequeueReusableWithTableView:tableView];
            cell.textLabel.text = @"清除缓存";
            CGFloat size = [[SDImageCache sharedImageCache] totalDiskSize] / 1024.0 / 1024.0;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM",size];
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
            cell.detailTextLabel.text = [LDUserManager shareInstance].currentUser.userName;
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
        case 3:
        {
            LDAlterPhoneViewController *vc = [LDAlterPhoneViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            [[LDUserManager shareInstance]updateUser];
            [QMUITips showSucceed:@"清除成功"];
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.detailTextLabel.text = @"0.00M";
            }];
        }
            break;
        case 5:
        {
            [self checkVesion];
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
            [LDUserManager shareInstance].currentUser.sex = @"1";
            
        }
        else if (index == 1)
        {
            [LDUserManager shareInstance].currentUser.sex = @"2";
            
        }
        [[LDUserManager shareInstance]updateUser];
        [weakself.tableView reloadData];
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
    
    UIImage *selectedImage = info[@"UIImagePickerControllerOriginalImage"];
    UIImage  *image = [HNTools zipImageWithImage:selectedImage withMaxSize:1000];
    [QMUITips showLoading:@"正在上传图片" inView:self.view];
    
    [MKRequestManager uploadImage:image success:^(id responseObject) {
        if (kCODE == 200) {
            NSString *url = responseObject[@"data"][@"imgUrl"];
            [LDUserManager shareInstance].currentUser.headImgUrl = [NSString stringWithFormat:@"%@img/%@",BaseAPI,url];
            [[LDUserManager shareInstance]updateUser];
            [self.tableView reloadData];
        }else {
            
        }
        [QMUITips hideAllTips];
    } faild:^(NSError *error) {
        [QMUITips hideAllTips];
    }];
    
}

#pragma  mark - GET SET
- (UIButton *)logoutButton{
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutButton setCornerRadius:PtHeight(20)];
        _logoutButton.backgroundColor = MainThemeColor;
        [_logoutButton addTarget:self action:@selector(logOutAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}
@end
