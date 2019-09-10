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
@property (nonatomic,strong)QMUIEmptyView * emptyView;
@property (nonatomic,strong)NSArray * netImages;
@end

@implementation LDLiveViewController
#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.cycleScrollView];
    [self.cycleScrollView reloadInputViews];
    
    CGFloat maxY = CGRectGetMaxY(self.cycleScrollView.frame)+10;
    self.emptyView = [[QMUIEmptyView alloc]initWithFrame:CGRectMake(0,maxY, SCREEN_WIDTH, SCREEN_HEIGHT-kTABBAR_HEIGHT-maxY-10)];
    [self.emptyView setImage:[UIImage imageNamed:@"home_loading_big"]];
    [self.emptyView setTextLabelText:@"敬请期待..."];
    self.emptyView.textLabelTextColor = [UIColor colorWithRed:0/255.0 green:204/255.0 blue:144/255.0 alpha:1.0];
    self.emptyView.textLabelFont = [UIFont systemFontOfSize:PtHeight(15)];
    self.emptyView.verticalOffset = -100;
    [self.emptyView setLoadingViewHidden:YES];
    [self.view addSubview:self.emptyView];
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
        UIImage * placeholderImage = [UIImage imageNamed:@"blank_common"];
        CGRect frame = CGRectMake(PtWidth(20), 0, PtWidth(335), PtHeight(120));
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
        _cycleScrollView.imageURLStringsGroup = self.netImages;
        _cycleScrollView.backgroundColor = [UIColor redColor];
        _cycleScrollView.showPageControl = YES;
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
