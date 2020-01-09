//
//  LDCustomManagerListViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/24.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDCustomManagerListViewController.h"
#import "LDCustomerManagerViewController.h"
#import "LDEmptyViewController.h"
@interface LDCustomManagerListViewController ()
@property (nonatomic,strong)NSArray * images;
@property (nonatomic,strong)NSArray * titles;
@end

@implementation LDCustomManagerListViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorColor = UIColorFromHEXA(0xf1f1f1, 1);
    self.title = @"我的管理";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initForTableView:tableView withStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.imageView.image = self.images[indexPath.row];
        cell.textLabel.text = self.titles[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 2:
        {
            LDCustomerManagerViewController *vc = [LDCustomerManagerViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
        {
            LDEmptyViewController *vc = [LDEmptyViewController new];
            vc.title = self.titles[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
    }
}


- (NSArray *)images {
    if (!_images) {
        _images = @[[UIImage imageNamed:@"mine_list_project"],[UIImage imageNamed:@"mine_list_achievements"],[UIImage imageNamed:@"mine_list_daily"]];
    }
    return _images;
}

- (NSArray *)titles{
    if (!_titles) {
        _titles = @[@"项目管理",@"绩效管理",@"客户管理日志"];
    }
    return _titles;
}
@end
