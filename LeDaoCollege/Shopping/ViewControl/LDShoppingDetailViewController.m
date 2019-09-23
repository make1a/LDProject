//
//  LDShoppingDetailViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/20.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDShoppingDetailViewController.h"
#import "SDCycleScrollView.h"
#import "LDShoppingTableViewCell.h"
#import "LDShoppingDetailViewController.h"
#import "LDShoppingDetailNameViewCell.h"
#import "LDShoppingTitleCell.h"
#import "LDShoppingDetailFootView.h"
#import "LDCommitBuyViewController.h"
@interface LDShoppingDetailViewController ()<SDCycleScrollViewDelegate,QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@property (nonatomic,strong)NSArray * netImages;
@property (nonatomic,strong)QMUITableView * tableView;
@property (nonatomic,strong)LDShoppingDetailFootView * footView;
@property (nonatomic,strong)UIButton * backButton;
@end

@implementation LDShoppingDetailViewController
#pragma  mark - view cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self masLayoutSubviews];
    [self footerViewActions];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)masLayoutSubviews{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.cycleScrollView;
    [self.view addSubview:self.footView];
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.tableView.mas_bottom);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
    }];
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(17);
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(17);
        } else {
            make.top.mas_equalTo(self.view).mas_offset(17);
        }
    }];
}
#pragma  mark - Touch Event
- (void)footerViewActions {
    [self.footView.collectionButton addTarget:self action:@selector(clickCollectionAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickCollectionAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [QMUITips showSucceed:@"收藏成功"];
}
- (void)pushToBuyVC{
    LDCommitBuyViewController *vc = [[LDCommitBuyViewController alloc]initWithNibName:@"LDCommitBuyViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)clickBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            LDShoppingDetailNameViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDShoppingDetailNameViewCell" forIndexPath:indexPath];
            return cell;
        }
            break;
        case 1:
        {
            LDShoppingTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDShoppingTitleCell" forIndexPath:indexPath];
            return cell;
        }
            break;
        default:
        {
            LDShoppingDetailNameViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDShoppingDetailNameViewCell" forIndexPath:indexPath];
            return cell;
        }
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            return PtHeight(107);
        }
            break;
        case 1:
        {
            return PtHeight(40);
        }
            break;
            
        default:
        {
            return PtHeight(107);;
        }
            break;
    }
    
}
#pragma mark - get and set
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        UIImage * placeholderImage = [UIImage imageNamed:@"blank_common"];
        CGRect frame = CGRectMake(0, kSTATUSBAR_HEIGHT, SCREEN_WIDTH, PtHeight(225));
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
        _cycleScrollView.imageURLStringsGroup = self.netImages;
        _cycleScrollView.showPageControl = YES;
    }
    return _cycleScrollView;
}
-(NSArray *)netImages{
    
    if (!_netImages) {
        _netImages = @[
            @"http://d.hiphotos.baidu.com/zhidao/pic/item/72f082025aafa40f507b2e99aa64034f78f01930.jpg",
            @"http://b.hiphotos.baidu.com/zhidao/pic/item/4b90f603738da9770889666fb151f8198718e3d4.jpg",
            @"http://g.hiphotos.baidu.com/zhidao/pic/item/f2deb48f8c5494ee4e84ef5d2cf5e0fe98257ed4.jpg",
            @"http://d.hiphotos.baidu.com/zhidao/pic/item/9922720e0cf3d7ca104edf32f31fbe096b63a93e.jpg"
        ];
    }
    return _netImages;
}
- (QMUITableView *)tableView {
    if (!_tableView) {
        _tableView = [[QMUITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, SCREEN_HEIGHT-kTABBAR_HEIGHT) style:UITableViewStylePlain];

        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"LDShoppingDetailNameViewCell" bundle:nil] forCellReuseIdentifier:@"LDShoppingDetailNameViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"LDShoppingTitleCell" bundle:nil] forCellReuseIdentifier:@"LDShoppingTitleCell"];
        
        
    }
    return _tableView;
}
- (LDShoppingDetailFootView *)footView {
    if (!_footView) {
        _footView = [[NSBundle mainBundle]loadNibNamed:@"LDShoppingDetailFootView" owner:self options:nil].firstObject;
        [_footView.buyButton addTarget:self action:@selector(pushToBuyVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footView;
}
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"nav_black"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(clickBackAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
@end
