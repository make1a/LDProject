//
//  LDCollegeViewController.m
//  LeDaoCollege
//
//  Created by make on 2020/2/21.
//  Copyright © 2020 Make. All rights reserved.
//

#import "LDCollegeViewController.h"
#import "LDNormalTableViewCell.h"
#import "LDLiveViewController.h"
@interface LDCollegeViewController ()

@property (nonatomic,strong)NSArray * titlesArray;
@property (nonatomic,strong)NSArray * imagesArray;
@end

@implementation LDCollegeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的大学";
}

#pragma  mark - GET && SET
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LDNormalTableViewCell *cell = [LDNormalTableViewCell dequeueReusableWithTableView:tableView];
    cell.imageView.image = [UIImage imageNamed:self.imagesArray[indexPath.row]];
    cell.textLabel.text = self.titlesArray[indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LDLiveViewController *vc =[LDLiveViewController new];
    vc.title = self.titlesArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma  mark - GET SET
- (NSArray *)titlesArray {
    if (!_titlesArray) {
        _titlesArray = @[@"部门/岗位",@"必修课程",@"选修课程",@"选修课程",@"配套测试题",@"考试通关",@"学业积分",@"成果发布"];
    }
    return _titlesArray;
}
- (NSArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = @[@"0",@"1",@"2",
                         @"3",@"4",@"5",@"6",@"7"];
    }
    return _imagesArray;
}
@end
