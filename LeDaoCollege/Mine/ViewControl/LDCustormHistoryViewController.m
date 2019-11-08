//
//  LDCustormHistoryViewController.m
//  LeDaoCollege
//
//  Created by make on 2019/9/7.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDCustormHistoryViewController.h"
#import "LDCustomHistoryCell.h"
#import "LDCustomModel.h"
@interface LDCustormHistoryViewController ()<QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic,strong)QMUITableView * tableView;
@end

@implementation LDCustormHistoryViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestDatsSource];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self masLayoutSubviews];
}
- (void)masLayoutSubviews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.equalTo(self.view.mas_safeAreaLayoutGuide);
        } else {
            make.edges.equalTo(self.view);
        }
    }];
}
-(void)requestDatsSource{
    NSString *url = [NSString stringWithFormat:@"customer/getcustomerinfo/%@",self.c_id];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:url requestParameters:@{@"id":self.c_id} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDCustomLogModel class] json:responseObject[@"data"][@"customerLogVOS"]];
            [self.tableView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
}
#pragma  mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDCustomHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDCustomHistoryCell" forIndexPath:indexPath];
    LDCustomLogModel *model = self.dataSource[indexPath.row];
    [cell refreshWith:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
#pragma  mark - GET SET
- (QMUITableView *)tableView {
    if (!_tableView) {
        _tableView = [[QMUITableView alloc]init];
        _tableView.delegate = self;
        self.tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"LDCustomHistoryCell" bundle:nil] forCellReuseIdentifier:@"LDCustomHistoryCell"];
    }
    return _tableView;
}

@end
