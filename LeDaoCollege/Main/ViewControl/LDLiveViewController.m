//
//  LDLiveViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDLiveViewController.h"
#import "SDCycleScrollView.h"

@interface LDLiveViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@property (nonatomic,strong)NSArray * netImages;
@end

@implementation LDLiveViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor clearColor];
    CGFloat maxY = PtHeight(149)-self.cycleScrollView.frame.size.height;
    blueView.frame = CGRectMake(0, 0, SCREEN_WIDTH, maxY);
    [self.view addSubview:blueView];
    
    if (self.isSearchModel) {
        maxY = 0;
    }
    
    self.emptyView = [[NSBundle mainBundle]loadNibNamed:@"LDEmptyViewXIB" owner:self options:nil].firstObject;
    self.emptyView.frame = CGRectMake(0, maxY, SCREEN_WIDTH, CGRectGetHeight(self.view.frame));
    [self showEmptyView];
    
    if (!self.isSearchModel) {
        [self.view addSubview:self.cycleScrollView];
        [self.cycleScrollView reloadInputViews];
    }

}
#pragma mark - event response


#pragma mark - private method
#pragma  mark - SDCyclesScrollview
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}
#pragma mark - get and set
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        UIImage * placeholderImage = [UIImage imageNamed:@"seizeaseat_0"];
        CGRect frame = CGRectMake(PtWidth(20), 0, PtWidth(335), PtHeight(120));
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
        _cycleScrollView.imageURLStringsGroup = self.netImages;
        _cycleScrollView.backgroundColor = [UIColor redColor];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
