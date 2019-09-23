//
//  LDSmallClassDetailViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/23.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDSmallClassDetailViewController.h"
#import "LDShoppingDetailFootView.h"
#import "LDShoppingDetailNameViewCell.h"
#import "LDSmallClassDetailHeadView.h"
#import "LDSmallClassDetailIntroCell.h"
#import "LDSmallClassLessonCell.h"
@interface LDSmallClassDetailViewController ()<QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic,strong)QMUITableView * tableView;
@property (nonatomic,strong)LDShoppingDetailFootView * footView;
@property (nonatomic,strong)LDSmallClassDetailHeadView * headView;
@property(nonatomic, strong) QMUINavigationBarScrollingSnapAnimator *navigationAnimator;
@end

@implementation LDSmallClassDetailViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 为了避免更改 navigationBar 显隐影响 scrollView 的滚动，这里屏蔽掉自动适应 contentInset
    if (@available(iOS 11, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    
    [self masLayoutSubViews];
    [self configNavBarAnimation];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.contentInset = UIEdgeInsetsMake(self.qmui_navigationBarMaxYInViewCoordinator, 0, self.view.qmui_safeAreaInsets.bottom, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self.tableView qmui_scrollToTopUponContentInsetTopChange];
}
- (void)masLayoutSubViews{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footView];
    self.tableView.tableHeaderView = self.headView;
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
- (void)configNavBarAnimation {
    self.navigationAnimator = [[QMUINavigationBarScrollingSnapAnimator alloc] init];
    self.navigationAnimator.scrollView = self.tableView;
    self.navigationAnimator.offsetYToStartAnimation = 44;
    __weak __typeof(self)weakSelf = self;
    self.navigationAnimator.animationBlock = ^(QMUINavigationBarScrollingSnapAnimator * _Nonnull animator, BOOL offsetYReached) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        NSLog(@"导航栏%@, inset.top = %.2f, offset.y = %.2f", offsetYReached ? @"被隐藏了" : @"显示出来了", strongSelf.tableView.contentInset.top, strongSelf.tableView.contentOffset.y);
        [strongSelf.navigationController setNavigationBarHidden:offsetYReached animated:YES];
    };
    

}
#pragma mark - <QMUINavigationControllerDelegate>

- (BOOL)preferredNavigationBarHidden {
    return self.navigationAnimator.offsetYReached;
}

- (BOOL)forceEnableInteractivePopGestureRecognizer {
    return self.navigationAnimator.offsetYReached;
}
#pragma  mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return 10;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        LDSmallClassDetailIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDSmallClassDetailIntroCell" forIndexPath:indexPath];
        return cell;
    }
    
    LDSmallClassLessonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDSmallClassLessonCell" forIndexPath:indexPath];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"第%ld章:天才是怎样炼成的",section];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view);
        make.left.mas_equalTo(view).mas_offset(16);
    }];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 30;
}
#pragma  mark - GET SET
- (QMUITableView *)tableView {
    if (!_tableView) {
        _tableView = [[QMUITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, SCREEN_HEIGHT-kTABBAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"LDSmallClassLessonCell" bundle:nil] forCellReuseIdentifier:@"LDSmallClassLessonCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"LDSmallClassDetailIntroCell" bundle:nil] forCellReuseIdentifier:@"LDSmallClassDetailIntroCell"];
        
    }
    return _tableView;
}
- (LDShoppingDetailFootView *)footView {
    if (!_footView) {
        _footView = [[NSBundle mainBundle]loadNibNamed:@"LDShoppingDetailFootView" owner:self options:nil].firstObject;
    }
    return _footView;
}
- (LDSmallClassDetailHeadView *)headView {
    if (!_headView) {
        _headView = [[NSBundle mainBundle]loadNibNamed:@"LDSmallClassDetailHeadView" owner:self options:nil].firstObject;
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 227);
    }
    return _headView;
}
@end
