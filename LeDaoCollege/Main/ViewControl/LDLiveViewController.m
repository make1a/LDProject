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
- (void)setNetImages:(NSArray *)netImages{
    _netImages = netImages;
    self.cycleScrollView.imageURLStringsGroup = netImages;
}
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        UIImage * placeholderImage = [UIImage imageNamed:@"seizeaseat_0"];
        CGRect frame = CGRectMake(PtWidth(20), 0, PtWidth(335), PtHeight(160));
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
        _cycleScrollView.imageURLStringsGroup = self.netImages;
        _cycleScrollView.backgroundColor = [UIColor redColor];
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.layer.masksToBounds = YES;
        _cycleScrollView.layer.cornerRadius = 10;
    }
    return _cycleScrollView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
