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
#import "LDStoreModel.h"
@interface LDShoppingCartViewController ()<QMUITableViewDelegate,QMUITableViewDataSource>
{
    BOOL isTableViewDeleteModel; //是否处于删除模式 - 对应UIBarButtonItem的管理按钮
}
@property (nonatomic,strong)NSMutableArray * selectDataSource;
@property (nonatomic,strong)NSArray * dataSource;
@property (nonatomic,strong)QMUITableView * tableView;
@property (nonatomic,strong)LDShoppingCartPaymentView * payView;
@end

@implementation LDShoppingCartViewController
#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    isTableViewDeleteModel = NO;
    [self creatNavButton];
    [self masLayoutSubviews];
    self.title = @"购物车";
    [self requestShop];
}
#pragma  mark - Request
- (void)requestShop{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"shoppingcat/getgoodslist" requestParameters:nil requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDStoreModel class] json:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
}
#pragma mark - event response
- (void)configTablViewAction:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"管理"]) {
        [sender setTitle:@"取消"];
        self.payView.payButton.selected = YES;
        isTableViewDeleteModel = YES;
        
    }else {
        self.payView.payButton.selected = NO;
        [sender setTitle:@"管理"];
        isTableViewDeleteModel = NO;
    }
}
- (void)clickSelectedAllAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    for (LDShoppingCartModel *model in self.selectDataSource) {
        model.isSelected = sender.isSelected;
    }
    [self.tableView reloadData];
}
- (void)clickPayOrDeleteAction:(UIButton *)sender {
    if (isTableViewDeleteModel == NO) {
        // 付款
    }else {
        // 删除
    }
}
#pragma  mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDShoppingCartCell *cell = [LDShoppingCartCell dequeueReusableWithTableView:tableView];
    [cell cellRefreshWithModel:self.dataSource[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LDShoppingCartModel *model = self.selectDataSource[indexPath.row];
    model.isSelected = !model.isSelected;
    LDShoppingCartCell *cell = (LDShoppingCartCell *) [tableView cellForRowAtIndexPath:indexPath];
    [cell cellRefreshWithModel:model];
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PtHeight(80);
}

#pragma mark - private method
- (void)creatNavButton{
    UIBarButtonItem *item = [UIBarButtonItem qmui_itemWithTitle:@"管理" target:self action:@selector(configTablViewAction:)];
    item.tintColor = UIColorFromHEXA(0x666666, 1);
    self.navigationItem.rightBarButtonItem = item;
}
- (void)masLayoutSubviews {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.payView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-kTABBAR_HEIGHT);
    }];
    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.tableView.mas_bottom);
    }];
}
#pragma mark - get and set
- (NSMutableArray *)selectDataSource{
    if (!_selectDataSource) {
        _selectDataSource = @[].mutableCopy;
        for (int i = 0; i<10; i++) {
            LDShoppingCartModel *model = [LDShoppingCartModel new];
            model.isSelected = NO;
            [_selectDataSource addObject:model];
        }
    }
    return _selectDataSource;
}
- (QMUITableView *)tableView{
    if (!_tableView) {
        _tableView = [[QMUITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (LDShoppingCartPaymentView *)payView{
    if (!_payView) {
        _payView = [[LDShoppingCartPaymentView alloc]init];
        [_payView.selectedAllButton addTarget:self action:@selector(clickSelectedAllAction:) forControlEvents:UIControlEventTouchUpInside];
        [_payView.payButton addTarget:self action:@selector(clickPayOrDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
