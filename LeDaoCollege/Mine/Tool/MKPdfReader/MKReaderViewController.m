//
//  MKReaderViewController.m
//  LeDaoCollege
//
//  Created by make on 2019/9/13.
//  Copyright © 2019 Make. All rights reserved.
//

#import "MKReaderViewController.h"
#import "MKPdfViewController.h"
#import "MKPdfDocumentManager.h"
#import "LDCustomNavBar.h"
#import "LDReadProgressView.h"
#import "MKIndexView.h"
@interface MKReaderViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (nonatomic, strong) UIPageViewController * pageViewController;
@property (nonatomic,strong)LDCustomNavBar * navBar;
@property (nonatomic,strong)LDReadProgressView * progressView;
@property (nonatomic,assign)NSInteger currentIndex;
@property (nonatomic,strong)MKIndexView * pageIndexView;

/**
 当前是左滑还是右滑 YES为右，判断页面滑一半返回的情况下处理index
 */
@property (nonatomic,assign)BOOL isAfter;

@end

@implementation MKReaderViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addPageVC];
    [self addSubviews];
    [self addSingleTapGesture];
    [self hiddenSubviews];
}

- (MKPdfViewController *)getPdfControllerWithIndex:(NSInteger)index {
    if (index == 0 || index > self.pdfInfo.totalPage) {
        return nil;
    }
    MKPdfViewController *vc = [[MKPdfViewController alloc]initWithDocumentManager:self.pdfInfo currentPage:index];
    return vc;
}
- (void)clickBackAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma  mark - Private
- (void)addPageVC {
    _progressView.slider.value = 1;
    self.currentIndex = self.pdfInfo.currentPage;
    if (self.currentIndex == 0) {
        self.currentIndex = 1;
    }
    MKPdfViewController *pdfVC = [self getPdfControllerWithIndex:self.pdfInfo.currentPage];
    [self.pageViewController setViewControllers:@[pdfVC]
                                      direction:UIPageViewControllerNavigationDirectionForward animated:NO
                                     completion:nil];
}
- (void)addSubviews{
    [self.view addSubview:self.navBar];
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.pageIndexView];
}
- (void)addSingleTapGesture
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    [self.view addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
}
#pragma  mark - Public
- (void)hiddenSubviews{
    [UIView animateWithDuration:0.3 animations:^{
        self.navBar.hidden = YES;
        self.progressView.hidden = YES;
        self.pageIndexView.hidden = YES;
    }];
}
- (void)showSubviews{
    self.progressView.totalPage = self.pdfInfo.totalPage;
    self.progressView.curPage = self.currentIndex;
    [self.progressView showSliderPogress];
    self.pageIndexView.label.text = [NSString stringWithFormat:@"%.0ld/%.0ld",(long)self.progressView.curPage,(long)self.progressView.totalPage];
    [UIView animateWithDuration:0.3 animations:^{
        self.navBar.hidden = NO;
        self.progressView.hidden = NO;
        self.pageIndexView.hidden = NO;
    }];
}
- (void)showPageView{

}
#pragma  mark - Touch Event

- (void)singleTapAction:(UIGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            if (self.navBar.hidden) {
                [self showSubviews];
            }else {
                [self hiddenSubviews];
            }
        }];
    }
}
- (void)doubleTapAction:(UIGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        MKPdfViewController *vc = (MKPdfViewController *)self.pageViewController.viewControllers.firstObject;
        [vc scrollToNormal];
    }
}
- (void)pagingAction:(UISlider *)slider{
    NSInteger currenIndex = roundf(slider.value);
    if (currenIndex < 1) { currenIndex = 1; }
    self.pageIndexView.label.text = [NSString stringWithFormat:@"%.0ld/%.0ld",currenIndex,(long)self.progressView.totalPage];
}
- (void)pageingEndAction:(UISlider *)slider{
    NSInteger currenIndex = roundf(slider.value);
    if (currenIndex < 1) { currenIndex = 1; }
    [self.pageViewController setViewControllers:@[[self getPdfControllerWithIndex:currenIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [slider setValue:currenIndex animated:YES];
    self.currentIndex = currenIndex;
}
#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    MKPdfViewController *vc = (MKPdfViewController *)viewController;
    self.isAfter = NO;
    if (vc.pageIndex > 1) {
        return [self getPdfControllerWithIndex:vc.pageIndex-1];
    }else {
        return nil;
    }
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    MKPdfViewController *vc = (MKPdfViewController *)viewController;
    self.isAfter = YES;
    if (vc.pageIndex < vc.pdfInfo.totalPage) {
        return [self getPdfControllerWithIndex:vc.pageIndex+1];
    }else {
        return nil;
    }


}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        //更新UI
        [self hiddenSubviews];
        if (self.isAfter) { //右滑
            self.currentIndex ++;
        } else {
            self.currentIndex --;
        }
        [self.pdfInfo saveToPlist];
    }
}

#pragma  mark - GET SET
- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    self.pdfInfo.currentPage = currentIndex;
}
- (UIPageViewController *)pageViewController{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc]init];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        _pageViewController.view.frame = self.view.bounds;
        [self addChildViewController:_pageViewController];
        _pageViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view addSubview:_pageViewController.view];
    }
    return _pageViewController;
}

- (LDCustomNavBar *)navBar {
    if (!_navBar) {
        _navBar = [[LDCustomNavBar alloc]init];
        _navBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //        _navBar.hidden = YES;
        [_navBar.backButton addTarget:self action:@selector(clickBackAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navBar;
}

- (LDReadProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[LDReadProgressView alloc]init];
        _progressView.slider.maximumValue = self.pdfInfo.totalPage;
        _progressView.slider.minimumValue = 0;
        [_progressView.slider addTarget:self action:@selector(pageingEndAction:) forControlEvents:UIControlEventTouchUpInside];

        [_progressView.slider addTarget:self action:@selector(pagingAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _progressView;
}

- (MKIndexView *)pageIndexView {
    if (!_pageIndexView) {
        _pageIndexView = [[MKIndexView alloc]init];
        _pageIndexView.frame = CGRectMake(0, 0, 100, 20);
        [_pageIndexView sizeToFit];
        _pageIndexView.center = CGPointMake(self.view.center.x, CGRectGetMinY(self.progressView.frame)-10);
    }
    return _pageIndexView;
}
@end
