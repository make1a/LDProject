//
//  LDFinishOrderViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/11.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDFinishOrderViewController.h"
#import "LDFinishOrderCell.h"

@interface LDFinishOrderViewController ()

@end

@implementation LDFinishOrderViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
}
- (void)configUI {
    self.tableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark - event response
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LDFinishOrderCell *cell = [LDFinishOrderCell dequeueReusableWithTableView:tableView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}
#pragma mark - private method
//当程序从后台进入时，重新刷新tableView
- (void)applicationDidBecomeActive:(NSNotification *)notification {
    [self.tableView reloadData];
}

#pragma mark - get and set


@end
