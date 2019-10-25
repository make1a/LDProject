//
//  LDVoiceViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDVoiceViewController.h"
#import "LDTagView.h"
#import "LDVoiceTableViewCell.h"
#import "SDCycleScrollView.h"
#import "LDTagModel.h"
#import "LDVoiceModel.h"
@interface LDVoiceViewController ()<SDCycleScrollViewDelegate,QMUITableViewDataSource,QMUITableViewDelegate>

@property (nonatomic,strong)LDTagView * tagView;
@property (nonatomic,strong)NSArray * netImages;
@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@property (nonatomic,strong)NSMutableArray * tagArray;


@end

@implementation LDVoiceViewController
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
    [self didSelectTagAction];
    [self configUI];
    
    if (self.isSearchModel) {
        [self isShowTagView:NO];
    } else {
        [self requestTag];
    }
}
#pragma  mark - Requst
- (void)requestTag {
    
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"item/getitem/1" requestParameters:@{@"id":@1} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            NSArray *array = [NSArray yy_modelArrayWithClass:[LDTagModel class] json:responseObject[@"data"][0][@"itemList"]];
            self.tagArray = @[].mutableCopy;
            for (LDTagModel *model in array) {
                [self.tagArray addObject:model.itemDesc];
            }
            self.tagView.titles = self.tagArray;
        }
    } faild:^(NSError *error) {
        
    }];
}
- (void)requestSource:(NSString *)title mark:(NSString *)mark back:(backSourceCountBlock)blcok{
//    @"pageSize":@1
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"audio/getaudios" requestParameters:@{@"title":title,@"mark":mark} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDVoiceModel class] json:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
                        if (blcok) {
                blcok(self.dataSource.count);
            }
        }
    } faild:^(NSError *error) {
        
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
#pragma mark - event response
- (void)didSelectTagAction{
    _weakself;
    self.tagView.didSelectButtonBlock = ^(NSInteger index) {
        [weakself isShowTagView:NO];
        [weakself requestSource:@"" mark:[NSString stringWithFormat:@"%ld",(long)index] back:nil];
    };
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
    return PtHeight(80);
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
        UIImage * placeholderImage = [UIImage imageNamed:@"seizeaseat_0"];
        CGRect frame = CGRectMake(PtWidth(20), 0, PtWidth(335), PtHeight(120));
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
        _cycleScrollView.imageURLStringsGroup = self.netImages;
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.layer.masksToBounds = YES;
        _cycleScrollView.layer.cornerRadius = 10;
    }
    return _cycleScrollView;
}

-(NSArray *)netImages{
    
    if (!_netImages) {
        _netImages = @[
            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1569321432704&di=d65324c4864f2a08817b6a73b6b5caeb&imgtype=0&src=http%3A%2F%2Fwww.leawo.cn%2Fattachment%2F201404%2F16%2F1433365_1397624557Bz7w.jpg",
            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1569321432704&di=52224a01dded6315a23357c5bc9afd03&imgtype=0&src=http%3A%2F%2Fimg.mp.itc.cn%2Fupload%2F20160830%2Ffe779ac6f79d4fb2a8101fda35eb8bdd_th.jpg",
            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1569321432703&di=4130ed50a2fdac16ce5ee7c234a1bc7a&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F2018-12-14%2F5c1319ac76f03.jpg",
            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1569321462846&di=65658adbc9c571fc14e125c62d2a705c&imgtype=jpg&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D312440173%2C484202537%26fm%3D214%26gp%3D0.jpg"
        ];
    }
    return _netImages;
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
