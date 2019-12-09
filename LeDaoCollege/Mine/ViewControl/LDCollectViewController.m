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

#import "LDWebViewViewController.h"
#import "LDShoppingDetailViewController.h"
#import "LDSmallClassDetailViewController.h"

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
@property (nonatomic,strong)NSArray * dataSource;
@end

@implementation LDCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    [self leftTableView];
    [self rightTableView];
    [self requestDataSource];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}
- (void)requestDataSource {
    // type:收藏类型(1.资讯 2.音频 3.视频 4书籍 5课程)
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"collection/mycollection" requestParameters:@{@"page":@1,@"pageSize":@1000,@"type":@1} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource1 = [NSArray yy_modelArrayWithClass:[LDNewsModel class] json:responseObject[@"data"][@"list"]];
            self.dataSource = self.dataSource1;
            [self.rightTableView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
}
- (void)requestDataSource2{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"collection/mycollection" requestParameters:@{@"page":@1,@"pageSize":@1000,@"type":@2} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource2 = [NSArray yy_modelArrayWithClass:[LDVoiceModel class] json:responseObject[@"data"][@"list"]];
            self.dataSource = self.dataSource2;
            [self.rightTableView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
}
- (void)requestDataSource3{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"collection/mycollection" requestParameters:@{@"page":@1,@"pageSize":@1000,@"type":@3} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource3 = [NSArray yy_modelArrayWithClass:[LDVideoModel class] json:responseObject[@"data"][@"list"]];
            self.dataSource = self.dataSource3;
            [self.rightTableView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
}
- (void)requestDataSource4{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"collection/mycollection" requestParameters:@{@"page":@1,@"pageSize":@1000,@"type":@4} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource4 = [NSArray yy_modelArrayWithClass:[LDStoreModel class] json:responseObject[@"data"][@"list"]];
            self.dataSource = self.dataSource4;
            [self.rightTableView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
}
- (void)requestDataSource5{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"collection/mycollection" requestParameters:@{@"page":@1,@"pageSize":@1000,@"type":@5} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource5 = [NSArray yy_modelArrayWithClass:[LDStoreModel class] json:responseObject[@"data"][@"list"]];
            self.dataSource = self.dataSource5;
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
        return 1;
    }
}

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
        if (self.dataSource == self.dataSource1) {
            LDNewsTableViewCell *cell = [LDNewsTableViewCell dequeueReusableWithTableView:tableView];
            [cell refreshWithModel:self.dataSource1[indexPath.row]];
            return cell;
        } else if (self.dataSource == self.dataSource2) {
            LDVoiceTableViewCell *cell = [LDVoiceTableViewCell dequeueReusableWithTableView:tableView];
            cell.collectionButton.hidden = YES;
            [cell refreshWithModel:self.dataSource2[indexPath.row]];
            return cell;
        } else if (self.dataSource == self.dataSource3) {
            LDVideoTableViewCell *cell = [LDVideoTableViewCell dequeueReusableWithTableView:tableView];
            cell.collectionButton.hidden = YES;
            [cell refreshWithModel:self.dataSource3[indexPath.row]];
            return cell;
        } else if (self.dataSource == self.dataSource4) {
            LDShoppingTableViewCell *cell = [LDShoppingTableViewCell dequeueReusableWithTableView:tableView];
            [cell.bigImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell);
            }];
            [cell refreshWithModel:self.dataSource4[indexPath.row]];
            return cell;
        } else {
            LDShoppingTableViewCell *cell = [LDShoppingTableViewCell dequeueReusableWithTableView:tableView];
            [cell.bigImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell);
            }];
            [cell refreshWithModel:self.dataSource5[indexPath.row]];
            return cell;
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
    return 20;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {

        switch (indexPath.row) {
            case 0:
            {
                [self requestDataSource];
            }
                break;
            case 1:
            {
                [self requestDataSource2];
            }
                break;
            case 2:
            {
                [self requestDataSource3];
            }
                break;
            case 3:
            {
                [self requestDataSource4];
            }
                break;
            case 4:
            {
                [self requestDataSource5];
            }
                break;
            default:
                break;
        }
    } else {
        [self.rightTableView deselectRowAtIndexPath:indexPath animated:NO];
        
        if (self.dataSource == self.dataSource1) {
            LDNewsModel *model = self.dataSource1[indexPath.row];
            LDWebViewViewController * vc = [LDWebViewViewController new];
            vc.urlStrng = model.contentUrl;
            vc.s_id = model.newsId;
            vc.isCollection =YES;
            vc.collectionType = @"1";
            vc.didRefreshCollectionStateBlock = ^(BOOL isCollection) {
                [tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        } else if (self.dataSource == self.dataSource2) {
            LDVoiceModel *model = self.dataSource2[indexPath.row];
            LDWebViewViewController * vc = [LDWebViewViewController new];
            vc.urlStrng = [NSString stringWithFormat:@"%@?id=%@&token=%@",model.contentUrl,model.v_id,[LDUserManager userID]];
            vc.s_id = model.v_id;
            vc.isCollection = YES;
            vc.collectionType = @"2";
            vc.didRefreshCollectionStateBlock = ^(BOOL isCollection) {
                [tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        } else if (self.dataSource == self.dataSource3) {
            LDVideoModel *model = self.dataSource3[indexPath.row];
            LDWebViewViewController * vc = [LDWebViewViewController new];
            vc.urlStrng = [NSString stringWithFormat:@"%@?id=%@&token=%@",model.contentUrl,model.v_id,[LDUserManager userID]];
            vc.s_id = model.v_id;
            vc.isCollection = YES;
            vc.collectionType = @"3";
            vc.didRefreshCollectionStateBlock = ^(BOOL isCollection) {
                [tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        } else if (self.dataSource == self.dataSource4) {
            LDShoppingDetailViewController *vc = [LDShoppingDetailViewController new];
            LDStoreModel *model = self.dataSource4[indexPath.row];
            vc.shopID = model.bookId;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            LDSmallClassDetailViewController *vc = [LDSmallClassDetailViewController new];
            LDStoreModel *model = self.dataSource5[indexPath.row];
            vc.classID = model.courseId;
            if ([model.isPayFlag isEqualToString:@"Y"]) {
                vc.isPay = YES;
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
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
