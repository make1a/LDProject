//
//  LDCollectViewController.m
//  LeDaoCollege
//
//  Created by make on 2019/9/10.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDCollectViewController.h"
#import "LDNewsTableViewCell.h"

@interface LDCollectViewController ()<QMUITableViewDataSource, QMUITableViewDelegate> {
    NSArray *_dataArray;
    BOOL _isRelate;
}
@property (nonatomic, strong) QMUITableView *leftTableView;
@property (nonatomic, strong) QMUITableView *rightTableView;

@end

@implementation LDCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self leftTableView];
    [self rightTableView];
    _isRelate = YES;
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
//    NSDictionary *item = [_dataArray objectAtIndex:section];
    if (tableView == self.leftTableView) {
//        return [_dataArray count];
        return 5;
    } else {
//        return [[item objectForKey:@"list"] count];
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.leftTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.textLabel.text = @"资讯";
        cell.textLabel.textColor = UIColorFromHEXA(0x999999, 1);
        cell.contentView.backgroundColor = UIColorFromHEXA(0xECF9F5, 1);
        [cell.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(cell.contentView);
        }];
        
        UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        selectedBackgroundView.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = selectedBackgroundView;
        UIView *liner = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 5, PtHeight(80))];
        liner.backgroundColor = UIColorFromHEXA(0x00AD6F, 1);
        [selectedBackgroundView addSubview:liner];
        
        return cell;
    } else {
        LDNewsTableViewCell *cell = [LDNewsTableViewCell dequeueReusableWithTableView:tableView];
        [cell.bigImageVIew mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(PtWidth(109));
            make.height.mas_equalTo(PtHeight(60));
        }];
        return cell;
    }
    
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        return PtHeight(80);
    } else {
        return PtHeight(95);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return CGFLOAT_MIN;
    } else {
        return CGFLOAT_MIN;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.rightTableView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
        view.backgroundColor = UIColorFromRGBA(217, 217, 217, 0.7);
        
        UILabel *lable = [[UILabel alloc]initWithFrame:view.bounds];
        NSDictionary *item = [_dataArray objectAtIndex:section];
        NSString *title = [item objectForKey:@"title"];
        lable.text = [NSString stringWithFormat:@"   %@", title];
        [view addSubview:lable];
        
        return view;
        
    } else {
        return nil;
    }
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
        _leftTableView = [[QMUITableView alloc] initWithFrame:CGRectMake(0, 0, PtWidth(90), self.view.frame.size.height)];
        _leftTableView.backgroundColor = [UIColor whiteColor];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [self.view addSubview:_leftTableView];
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
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
@end
