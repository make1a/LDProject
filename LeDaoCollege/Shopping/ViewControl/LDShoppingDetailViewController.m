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
@interface LDShoppingDetailViewController ()<SDCycleScrollViewDelegate,QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@property (nonatomic,strong)NSArray * netImages;
@property (nonatomic,strong)QMUITableView * tableView;
@property (nonatomic,strong)LDShoppingDetailFootView * footView;
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
    }
    return _footView;
}
@end
