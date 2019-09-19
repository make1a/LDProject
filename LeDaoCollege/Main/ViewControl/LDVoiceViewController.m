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

@interface LDVoiceViewController ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)LDTagView * tagView;
@property (nonatomic,strong)NSArray * netImages;
@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
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
    }
}

#pragma mark - event response
- (void)didSelectTagAction{
    _weakself;
    self.tagView.didSelectButtonBlock = ^(NSInteger index) {
        [weakself isShowTagView:NO];
    };
}
#pragma  mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDVoiceTableViewCell *cell = [LDVoiceTableViewCell dequeueReusableWithTableView:tableView];
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
        self.tagView.hidden = NO;
    }else {
        self.tableView.hidden = !YES;
        self.tagView.hidden = !NO;
    }
}
#pragma  mark - LayoutSubviews
- (void)masLayoutSubviews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(PtWidth(20));
        make.right.mas_equalTo(self.view).mas_offset(PtWidth(-20));
        make.top.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view);
        }
    }];
    if (!self.isSearchModel) {
        self.tableView.tableHeaderView = self.cycleScrollView;
        [self.cycleScrollView reloadInputViews];
    }else {
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}
#pragma mark - get and set

- (LDTagView *)tagView {
    if (!_tagView) {
        _tagView = [[LDTagView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tagView.titles = @[@"Helps", @"Maintain", @"Liver", @"Health", @"Function", @"Supports", @"Healthy", @"Fat"];
    }
    return _tagView;
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        UIImage * placeholderImage = [UIImage imageNamed:@"blank_common"];
        CGRect frame = CGRectMake(PtWidth(20), 0, PtWidth(335), PtHeight(120));
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
        _cycleScrollView.imageURLStringsGroup = self.netImages;
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.layer.masksToBounds = YES;
        _cycleScrollView.layer.cornerRadius = 5;
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

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
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
