//
//  LDUnfinishOrderViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/11.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDUnfinishOrderViewController.h"
#import "LDTimerCell.h"

@interface LDUnfinishOrderViewController ()

@end

@implementation LDUnfinishOrderViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    //监听程序进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}
#pragma mark - event response
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LDTimerCell *cell = [LDTimerCell dequeueReusableWithTableView:tableView];
    cell.timeInterval = [NSDate date].timeIntervalSince1970 - 10*60;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
#pragma mark - private method
//当程序从后台进入时，重新刷新tableView
- (void)applicationDidBecomeActive:(NSNotification *)notification {
    [self.tableView reloadData];
}

#pragma mark - get and set

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
