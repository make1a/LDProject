//
//  LDBookDicViewController.m
//  LeDaoCollege
//
//  Created by make on 2020/2/15.
//  Copyright © 2020 Make. All rights reserved.
//

#import "LDBookDicViewController.h"
#import "LDDicBookCell.h"
#import "SDCycleScrollView.h"
@interface LDBookDicViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@end

@implementation LDBookDicViewController
- (instancetype)initWithStyle:(UITableViewStyle)style{
    style = UITableViewStyleGrouped;
    self = [super initWithStyle:style];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];

}
- (void)configUI{
    self.tableView.tableHeaderView = self.cycleScrollView;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorColor = [UIColor clearColor];
}
#pragma  mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDDicBookCell *cell = [LDDicBookCell dequeueReusableWithTableView:tableView];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]init];
    label.text = self.titleArray[section];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).mas_offset(18.5);
        make.bottom.mas_equalTo(view).mas_offset(-8);
    }];
    label.font = [UIFont boldSystemFontOfSize:18];
    return view;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
#pragma  mark - SDCyclesScrollview
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}

#pragma  mark - GET SET
- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"期刊",@"工具书",@"项目案例",@"知识库"];
    }
    return _titleArray;
}
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        UIImage * placeholderImage = [UIImage imageNamed:@"seizeaseat_1"];
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, 180);
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
        _cycleScrollView.imageURLStringsGroup = self.netImages;
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.currentPageDotColor = MainThemeColor;
        _cycleScrollView.pageDotColor = [UIColor whiteColor];
    }
    return _cycleScrollView;
}
- (void)setNetImages:(NSArray *)netImages{
    _netImages = netImages;
    self.cycleScrollView.imageURLStringsGroup = netImages;
}
@end
