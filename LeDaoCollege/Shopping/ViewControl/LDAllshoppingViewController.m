//
//  LDAllshoppingViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/20.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDAllshoppingViewController.h"
#import "LDShoppingTableViewCell.h"
#import "LDStoreModel.h"
@interface LDAllshoppingViewController ()
{
    NSInteger page;
    
}
@property (nonatomic,strong)NSArray * dataSource;
@end

@implementation LDAllshoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestAllStore];
}
- (void)requestAllStore {
    NSDictionary *dic = @{@"title":@"",
                          @"page":@(page),
                          @"pageSize":@20};
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"goods/getallgoods" requestParameters:dic requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
           self.dataSource = [NSArray yy_modelArrayWithClass:[LDStoreModel class] json:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
}
#pragma  mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDShoppingTableViewCell *cell = [LDShoppingTableViewCell dequeueReusableWithTableView:tableView];
    [cell refreshWithModel:self.dataSource[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PtHeight(80);
}
@end
