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

@end

@implementation LDMyIconViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
