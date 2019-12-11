//
//  LDVoiceListViewController.m
//  LeDaoCollege
//
//  Created by make on 2019/12/8.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDVoiceListViewController.h"
#import "LDVoiceTableViewCell.h"
#import "LDVoiceModel.h"
#import "LDWebViewViewController.h"

@interface LDVoiceListViewController ()

@end

@implementation LDVoiceListViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
#pragma  mark - Request
- (void)requestSource:(NSString *)title mark:(NSString *)mark back:(backSourceCountBlock)blcok{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"audio/getaudios" requestParameters:@{@"title":title,@"mark":mark,@"pageSize":@1000} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDVoiceModel class] json:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
                        if (blcok) {
                blcok(self.dataSource.count);
            }
        }
    }faild:^(NSError *error) {
        
    }];
}
- (void)requestCollection:(LDVoiceModel*)model index:(NSInteger)index{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:@"collection/addanddelete" requestParameters:@{@"collectionId":model.v_id,@"collectionType":@"2"} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            [QMUITips showSucceed:responseObject[@"returnMsg"]];
            if ([model.collectionFlag isEqualToString:@"N"]) {
                model.collectionFlag = @"Y";
            } else {
                model.collectionFlag = @"N";
            }
            
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
    } faild:^(NSError *error) {
        
    }];
}
#pragma  mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDVoiceTableViewCell *cell = [LDVoiceTableViewCell dequeueReusableWithTableView:tableView];
    LDVoiceModel *model = self.dataSource[indexPath.row];
    [cell refreshWithModel:model];
    _weakself;
    cell.didSelectCollectionActionBlock = ^{
        [weakself requestCollection:model index:indexPath.row];
    };
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return PtHeight(87);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LDVoiceModel *model = self.dataSource[indexPath.row];
    LDWebViewViewController * vc = [LDWebViewViewController new];
    vc.title = model.title;
    vc.urlStrng = [NSString stringWithFormat:@"%@?id=%@&token=%@",model.contentUrl,model.v_id,[LDUserManager userID]];
    vc.s_id = model.v_id;
    vc.isCollection = [model.collectionFlag isEqualToString:@"Y"]?YES:NO;
    vc.collectionType = @"2";
    vc.didRefreshCollectionStateBlock = ^(BOOL isCollection) {
        model.collectionFlag = isCollection?@"Y":@"N";
        [tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
@end
