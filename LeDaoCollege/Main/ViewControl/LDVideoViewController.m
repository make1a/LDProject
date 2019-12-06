//
//  LDVideoViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDVideoViewController.h"
#import "LDTagView.h"
#import "LDVideoTableViewCell.h"
#import "SDCycleScrollView.h"
#import "LDTagModel.h"
#import "LDVideoModel.h"
#import "LDWebViewViewController.h"
@interface LDVideoViewController ()<SDCycleScrollViewDelegate,QMUITableViewDataSource,QMUITableViewDelegate>
{
    NSInteger currentIndex;
}
@property (nonatomic,strong)LDTagView * tagView;

@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@property (nonatomic,strong)NSMutableArray * tagArray;

@end

@implementation LDVideoViewController
#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.isSearchModel) {
        [self isShowTagView:YES];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.netImages = @[];
    [self didSelectTagAction];
    [self configUI];
    if (self.isSearchModel) {
        [self isShowTagView:NO];
    }else {
        [self requestTag];
    }
}
- (void)requestTag {
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"item/getitem/2" requestParameters:@{@"id":@2} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.tagArray = [NSArray yy_modelArrayWithClass:[LDTagModel class] json:responseObject[@"data"][0][@"itemList"]].mutableCopy;
            NSMutableArray *tags = @[].mutableCopy;
            for (LDTagModel *model in self.tagArray) {
                [tags addObject:model];
            }
            NSMutableArray *titles = @[].mutableCopy;
            for (LDTagModel *model in self.tagArray) {
                [titles addObject: model.itemDesc];
            }
            self.tagView.titles = titles;
        }
    } faild:^(NSError *error) {
        
    }];
}
- (void)requestSource:(NSString *)title mark:(NSString *)mark back:(backSourceCountBlock)blcok{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"video/getlist" requestParameters:@{@"title":title,@"mark":mark,@"pageSize":@1000} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDVideoModel class] json:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
            if (blcok) {
                blcok(self.dataSource.count);
            }
            
        }
    } faild:^(NSError *error) {
        
    }];
}

- (void)requestCollection:(LDVideoModel*)model index:(NSInteger)index{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:@"collection/addanddelete" requestParameters:@{@"collectionId":model.v_id,@"collectionType":@"3"} requestHeader:nil success:^(id responseObject) {
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
#pragma mark - event response
- (void)didSelectTagAction{
    _weakself;
    self.tagView.didSelectButtonBlock = ^(NSInteger index) {
        [weakself isShowTagView:NO];
        LDTagModel *model = weakself.tagArray[index];
        [weakself requestSource:@"" mark:[NSString stringWithFormat:@"%@",model.tagId] back:nil];
    };
}
#pragma  mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDVideoTableViewCell *cell = [LDVideoTableViewCell dequeueReusableWithTableView:tableView];
    LDVideoModel *model = self.dataSource[indexPath.row];
    [cell refreshWithModel:model];
    _weakself;
    cell.didSelectCollectionActionBlock = ^{
        [weakself requestCollection:model index:indexPath.row];
    };
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return PtHeight(80);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LDVideoModel *model = self.dataSource[indexPath.row];
    LDWebViewViewController * vc = [LDWebViewViewController new];
    vc.urlStrng = [NSString stringWithFormat:@"%@?id=%@&token=%@",model.contentUrl,model.v_id,[LDUserManager userID]];
    vc.s_id = model.v_id;
    vc.isCollection = [model.collectionFlag isEqualToString:@"Y"]?YES:NO;
    vc.collectionType = @"3";
    vc.didRefreshCollectionStateBlock = ^(BOOL isCollection) {
        model.collectionFlag = isCollection?@"Y":@"N";
        [tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma  mark - SDCyclesScrollview
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}
#pragma mark - private method
- (void)configUI {
    [self masLayoutSubviews];
    [self.view addSubview:self.tagView];
}
- (void)isShowTagView:(BOOL)isShow {
    if (isShow) {
        self.tableView.hidden = YES;
        self.cycleScrollView.hidden = YES;
        self.tagView.hidden = NO;
    }else {
        self.tableView.hidden = !YES;
        self.tagView.hidden = !NO;
        self.cycleScrollView.hidden = NO;
    }
}
#pragma  mark - LayoutSubviews
- (void)masLayoutSubviews {
    [self.view addSubview:self.tableView];

    if (!self.isSearchModel) {
        [self.view addSubview:self.cycleScrollView];
        [self.cycleScrollView reloadInputViews];
        [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(PtWidth(20));
            make.right.mas_equalTo(self.view).mas_offset(PtWidth(-20));
            make.top.mas_equalTo(self.view);
            make.height.mas_equalTo(PtHeight(120));
        }];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(PtWidth(20));
            make.right.mas_equalTo(self.view).mas_offset(PtWidth(-20));
            make.top.mas_equalTo(self.cycleScrollView.mas_bottom);
            if (@available(iOS 11.0, *)) {
                make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.mas_equalTo(self.view);
            }
        }];
        
    }else {
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}
#pragma mark - get and set

- (LDTagView *)tagView {
    if (!_tagView) {
        _tagView = [[LDTagView alloc]initWithFrame:CGRectMake(0, PtHeight(30), SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _tagView;
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        UIImage * placeholderImage = [UIImage imageNamed:@"seizeaseat_1"];
        CGRect frame = CGRectMake(PtWidth(20), 0, PtWidth(335), PtHeight(120));
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
        _cycleScrollView.imageURLStringsGroup = self.netImages;
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.layer.masksToBounds = YES;
        _cycleScrollView.layer.cornerRadius = 10;
    }
    return _cycleScrollView;
}

- (void)setNetImages:(NSArray *)netImages{
    _netImages = netImages;
    self.cycleScrollView.imageURLStringsGroup = netImages;
}
- (QMUITableView *)tableView {
    if (!_tableView) {
        _tableView = [[QMUITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
