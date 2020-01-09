//
//  LDMyIconViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/25.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDMyIconViewController.h"
#import "LDRechargeViewController.h"
@interface LDMyIconViewController ()
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIButton *czButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation LDMyIconViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.backButton setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
}
- (void)requestData{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"wallet/getlebi" requestParameters:nil requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            if ([responseObject[@"data"] isEqual:[NSNull null]]) {
                [QMUITips showError:@"网络错误请稍微重试"];
                return ;
            }
            NSString *icon;
            if ([responseObject[@"data"] isKindOfClass:[NSString class]]) {
                icon = @"0";
            }else{
                icon =[NSString stringWithFormat:@"%@",responseObject[@"data"][@"lecoin"]];
            }
            self.numberLabel.text = icon;
        }
    } faild:^(NSError *error) {
        
    }];
}
#pragma  mark - Touch Event
- (IBAction)clickCZButtonAction:(id)sender {
    LDRechargeViewController *vc = [LDRechargeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)clickBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
