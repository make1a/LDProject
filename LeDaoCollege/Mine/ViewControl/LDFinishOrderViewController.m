//
//  LDFinishOrderViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/11.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDFinishOrderViewController.h"
#import "LDFinishOrderCell.h"
#import "LDOrderModel.h"
#import "LDCommitBuyViewController.h"
@interface LDFinishOrderViewController ()
@property (nonatomic,strong)NSArray * dataSource;
@end

@implementation LDFinishOrderViewController
#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的订单";
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
    [self requestData];
}

- (void)configUI {
    self.tableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)requestData{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"order/orderlist" requestParameters:nil requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDOrderModel class] json:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
}
#pragma mark - event response
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LDFinishOrderCell *cell = [LDFinishOrderCell dequeueReusableWithTableView:tableView];
    LDOrderModel*model = self.dataSource[indexPath.row];
    [cell refreshWith:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
        LDCommitBuyViewController *vc = [[LDCommitBuyViewController alloc]initWithNibName:@"LDCommitBuyViewController" bundle:[NSBundle mainBundle]];
    vc.currentModel = self.dataSource[indexPath.row];
    vc.footView.hidden = YES;
    vc.title = @"订单详情";
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - private method


#pragma mark - get and set


@end
