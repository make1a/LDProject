//
//  LDShoppingCartViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/16.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDShoppingCartViewController.h"
#import "LDShoppingCartCell.h"
#import "LDShoppingCartModel.h"
#import "LDShoppingCartPaymentView.h"
@interface LDShoppingCartViewController ()
@property (nonatomic,strong)NSMutableArray * dataSource;
@end

@implementation LDShoppingCartViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatNavButton];
}
#pragma mark - event response
- (void)configTablViewAction:(UIBarButtonItem *)sender {
    NSLog(@"%@",sender.title);
}
#pragma  mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDShoppingCartCell *cell = [LDShoppingCartCell dequeueReusableWithTableView:tableView];
    [cell cellRefreshWithModel:self.dataSource[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LDShoppingCartModel *model = self.dataSource[indexPath.row];
    model.isSelected = !model.isSelected;
    LDShoppingCartCell *cell = (LDShoppingCartCell *) [tableView cellForRowAtIndexPath:indexPath];
    [cell cellRefreshWithModel:model];
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PtHeight(80);
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return PtHeight(50);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    LDShoppingCartPaymentView *view = [LDShoppingCartPaymentView new];
    view.selectedAllButton.backgroundColor = [UIColor grayColor];
    return view;
}
#pragma mark - private method
- (void)creatNavButton{
    UIBarButtonItem *item = [UIBarButtonItem qmui_itemWithTitle:@"管理" target:self action:@selector(configTablViewAction:)];
    item.tintColor = UIColorFromHEXA(0x666666, 1);
    self.navigationItem.rightBarButtonItem = item;
}
#pragma mark - get and set
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
        for (int i = 0; i<10; i++) {
            LDShoppingCartModel *model = [LDShoppingCartModel new];
            model.isSelected = NO;
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
