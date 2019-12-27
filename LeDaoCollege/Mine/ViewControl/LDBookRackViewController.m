//
//  CollectionViewController.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import "CollectionCategoryModel.h"
#import "CollectionViewCell.h"
#import "LDBookRackViewController.h"
#import "CollectionViewHeaderView.h"
#import "LJCollectionViewFlowLayout.h"
#import "LeftTableViewCell.h"
#import "NSObject+Property.h"
#import "MKPdfDocumentManager.h"
#import "MKPdfViewController.h"
#import "MKReaderViewController.h"
#import "LDBookDetailViewController.h"
#import "LDSmallClassDetailViewController.h"
#import "LDShujiaModel.h"
#import "LDShoppingTableViewCell.h"
#import "LDVideoDetailViewController.h"

@interface LDBookRackViewController () <QMUITableViewDataSource, QMUITableViewDelegate>

@property (nonatomic, strong) QMUITableView *leftTableView;
@property (nonatomic, strong) QMUITableView *rightTableView;

@property (nonatomic,strong) NSArray * leftTitles;
@property (nonatomic,strong)NSArray * bookArray;
@property (nonatomic,strong)NSArray * smallClassArray;
@property (nonatomic,strong)NSArray * dataSource;
@end

@implementation LDBookRackViewController
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的书架";
    [self leftTableView];
    [self rightTableView];
    
    [self reqeustDataSource];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma  mark - Request
- (void)reqeustDataSource{
    //        商品类型 1 书籍 2微课
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"bookshelf/goods" requestParameters:@{@"goodsType":@"1",@"page":@"1",@"pageSize":@"1000"} requestHeader:nil success:^(id responseObject) {
        self.bookArray = [NSArray yy_modelArrayWithClass:[LDShujiaModel class] json:responseObject[@"data"][@"list"]];
        self.dataSource = self.bookArray;
        [self.rightTableView reloadData];
    } faild:^(NSError *error) {
        
    }];
    
}
- (void)requestClassDataSource{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"bookshelf/goods" requestParameters:@{@"goodsType":@"2",@"page":@"1",@"pageSize":@"1000"} requestHeader:nil success:^(id responseObject) {
        self.smallClassArray = [NSArray yy_modelArrayWithClass:[LDShujiaModel class] json:responseObject[@"data"][@"list"]];
        self.dataSource = self.smallClassArray;
        [self.rightTableView reloadData];
    } faild:^(NSError *error) {
        
    }];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return self.leftTitles.count;
    } else {
        return self.dataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left];
        cell.name.text = self.leftTitles[indexPath.row];
        return cell;
    } else {
        if (self.dataSource == self.bookArray) {
            LDShoppingTableViewCell *cell = [LDShoppingTableViewCell dequeueReusableWithTableView:tableView];
            [cell refreshWithModel:self.dataSource[indexPath.row]];
            [cell.bigImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.contentView).mas_offset(PtWidth(18));
            }];
            return cell;
        }else {
            LDShoppingTableViewCell *cell = [LDShoppingTableViewCell dequeueReusableWithTableView:tableView];
            [cell refreshWithModel:self.dataSource[indexPath.row]];
            return cell;
        }
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        return PtHeight(100);
    } else {
        return PtHeight(80);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return 1;
    } else {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        switch (indexPath.row) {
            case 0:
            {
                [self  reqeustDataSource];
            }
                break;
            default:
            {
                [self requestClassDataSource];
            }
                break;
        }
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        if (self.dataSource == self.bookArray) {
            LDBookDetailViewController *vc = [[LDBookDetailViewController alloc]initWithNibName:@"LDBookDetailViewController" bundle:[NSBundle mainBundle]];
            LDShujiaModel *model =self.smallClassArray[indexPath.item];
            vc.bookID = model.goodsId;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            LDVideoDetailViewController *vc = [LDVideoDetailViewController new];
            LDShujiaModel *model =self.smallClassArray[indexPath.item];
            vc.videoID = model.goodsId;
            vc.isSmallClass = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - Getters
- (QMUITableView *)leftTableView {
    if (nil == _leftTableView){
        _leftTableView = [[QMUITableView alloc] initWithFrame:CGRectMake(0, 0, PtWidth(85), self.view.frame.size.height)];
        _leftTableView.backgroundColor = UIColorFromHEXA(0xF9F9F9, 1);
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [self.view addSubview:_leftTableView];
        [_leftTableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left];
    }
    return _leftTableView;
}

- (QMUITableView *)rightTableView{
    if (nil == _rightTableView){
        _rightTableView = [[QMUITableView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftTableView.frame), 0, self.view.frame.size.width - CGRectGetMaxX(self.leftTableView.frame), self.view.frame.size.height)];
        _rightTableView.backgroundColor = [UIColor whiteColor];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        [self.view addSubview:_rightTableView];
    }
    return _rightTableView;
}
- (NSArray *)leftTitles {
    if (!_leftTitles) {
        _leftTitles = @[@"工具书",@"微课"];
    }
    return _leftTitles;
}
@end
