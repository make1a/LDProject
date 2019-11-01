//
//  LDCollectViewController.m
//  LeDaoCollege
//
//  Created by make on 2019/9/10.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDCollectViewController.h"
#import "LeftTableViewCell.h"

#import "LDNewsTableViewCell.h"
#import "LDVoiceTableViewCell.h"
#import "LDVideoTableViewCell.h"
#import "LDShoppingTableViewCell.h"
#import "LDSmallClassLessonCell.h"

#import "LDNewsModel.h"
#import "LDVideoModel.h"
#import "LDVoiceModel.h"
#import "LDStoreModel.h"

@interface LDCollectViewController ()<QMUITableViewDataSource, QMUITableViewDelegate> {
    NSArray *_dataArray;
    BOOL _isRelate;
}
@property (nonatomic, strong) QMUITableView *leftTableView;
@property (nonatomic, strong) QMUITableView *rightTableView;
@property (nonatomic,strong) NSMutableArray * leftTitles;

// type:收藏类型(1.资讯 2.音频 3.视频 4书籍 5课程)
@property (nonatomic,strong)NSArray * dataSource1;
@property (nonatomic,strong)NSArray * dataSource2;
@property (nonatomic,strong)NSArray * dataSource3;
@property (nonatomic,strong)NSArray * dataSource4;
@property (nonatomic,strong)NSArray * dataSource5;
@end

@implementation LDCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    [self leftTableView];
    [self rightTableView];
    _isRelate = YES;
    [self requestDataSource];
}
- (void)requestDataSource {
    // type:收藏类型(1.资讯 2.音频 3.视频 4书籍 5课程)
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"collection/mycollection" requestParameters:@{@"page":@1,@"pageSize":@1000,@"type":@1} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource1 = [NSArray yy_modelArrayWithClass:[LDNewsModel class] json:responseObject[@"data"][@"list"]];
            [self.rightTableView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"collection/mycollection" requestParameters:@{@"page":@1,@"pageSize":@1000,@"type":@2} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource2 = [NSArray yy_modelArrayWithClass:[LDVoiceModel class] json:responseObject[@"data"][@"list"]];
            [self.rightTableView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"collection/mycollection" requestParameters:@{@"page":@1,@"pageSize":@1000,@"type":@3} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource3 = [NSArray yy_modelArrayWithClass:[LDVideoModel class] json:responseObject[@"data"][@"list"]];
            [self.rightTableView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"collection/mycollection" requestParameters:@{@"page":@1,@"pageSize":@1000,@"type":@4} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource4 = [NSArray yy_modelArrayWithClass:[LDStoreModel class] json:responseObject[@"data"][@"list"]];
            [self.rightTableView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"collection/mycollection" requestParameters:@{@"page":@1,@"pageSize":@1000,@"type":@5} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource5 = [NSArray yy_modelArrayWithClass:[LDStoreModel class] json:responseObject[@"data"][@"list"]];
            [self.rightTableView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.leftTableView) {
        return 1;
    } else {
        //        return [_dataArray count];
        return 5;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return self.leftTitles.count;
    } else {
        switch (section) {
            case 0:
                return self.dataSource1.count;
                break;
            case 1:
                return self.dataSource2.count;
                break;
            case 2:
                return self.dataSource3.count;
                break;
            case 3:
                return self.dataSource4.count;
                break;
            default:
                return self.dataSource5.count;
                break;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left];
        cell.name.text = self.leftTitles[indexPath.row];
        return cell;
    } else {
        switch (indexPath.section) {
            case 0:
            {
                LDNewsTableViewCell *cell = [LDNewsTableViewCell dequeueReusableWithTableView:tableView];
                [cell refreshWithModel:self.dataSource1[indexPath.row]];
                return cell;
            }
                break;
            case 1:
            {
                LDVoiceTableViewCell *cell = [LDVoiceTableViewCell dequeueReusableWithTableView:tableView];
                cell.collectionButton.hidden = YES;
                [cell refreshWithModel:self.dataSource2[indexPath.row]];
                return cell;
            }
                break;
            case 2:
            {
                LDVideoTableViewCell *cell = [LDVideoTableViewCell dequeueReusableWithTableView:tableView];
                cell.collectionButton.hidden = YES;
                [cell refreshWithModel:self.dataSource3[indexPath.row]];
                return cell;
            }
                break;
            case 3:
            {
                LDShoppingTableViewCell *cell = [LDShoppingTableViewCell dequeueReusableWithTableView:tableView];
                [cell.bigImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(cell);
                }];
                [cell refreshWithModel:self.dataSource4[indexPath.row]];
                return cell;
            }
                break;
            default:
            {
                LDShoppingTableViewCell *cell = [LDShoppingTableViewCell dequeueReusableWithTableView:tableView];
                [cell.bigImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(cell);
                }];
                [cell refreshWithModel:self.dataSource5[indexPath.row]];
                return cell;
            }
                break;
        }
        
    }
    
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        return PtHeight(100);
    } else {
        return PtHeight(77);
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
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.rightTableView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0.1)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:view.bounds];
        lable.font = [UIFont systemFontOfSize:13];
//        lable.text = self.leftTitles[section];
        [view addSubview:lable];
        return view;
        
    } else {
        return [UIView new];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if (_isRelate) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        if (tableView == self.rightTableView) {
            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    if (_isRelate) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        
        if (tableView == self.rightTableView) {
            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && self.dataSource1.count == 0) {
        return;
    } else if (indexPath.section == 1 && self.dataSource2.count == 0) {
        return;
    }else if (indexPath.section == 2 && self.dataSource3.count == 0) {
        return;
    }else if (indexPath.section == 3 && self.dataSource4.count == 0) {
        return;
    }else if (indexPath.section == 4 && self.dataSource5.count == 0) {
        return;
    }
    
    if (tableView == self.leftTableView) {
        _isRelate = NO;
        [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else {
        [self.rightTableView deselectRowAtIndexPath:indexPath animated:NO];
        
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _isRelate = YES;
}


#pragma  mark - GET & SET
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
        _rightTableView = [[QMUITableView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftTableView.frame)+10, 0, self.view.frame.size.width - CGRectGetMaxX(self.leftTableView.frame), self.view.frame.size.height)];
        _rightTableView.backgroundColor = [UIColor whiteColor];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        [self.view addSubview:_rightTableView];
    }
    return _rightTableView;
}
- (NSMutableArray *)leftTitles {
    if (!_leftTitles) {
        _leftTitles = @[@"资讯",@"音频",@"视频",@"工具书",@"微课"].mutableCopy;
    }
    return _leftTitles;
}
@end
