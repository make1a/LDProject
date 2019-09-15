//
//  LDReadPDFViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/12.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDReadPDFViewController.h"
#import "LDCustomNavBar.h"
#import "LDReadProgressView.h"



@interface LDReadPDFViewController ()
@property (nonatomic,strong)LDCustomNavBar * navBar;
@property (nonatomic,strong)LDReadProgressView * progressView;
@end

@implementation LDReadPDFViewController
#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showBar) name:@"kNotificationShowBar" object:nil];
    [self configPDF];
    [self masLayoutsubview];
    [self changePageAction];
}
#pragma mark - event response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch");
}
- (void)pagingAction:(UISlider *)slider {

}
#pragma mark - private method
- (void)changePageAction {

}
- (void)showBar{
    [UIView animateWithDuration:0.1 animations:^{
        self.navBar.hidden = !self.navBar.hidden;
    }];
}
- (void)configPDF{

    
}
- (void)masLayoutsubview{
    [self.view addSubview:self.navBar];
    [self.view addSubview:self.progressView];
}
#pragma mark - get and set

- (LDCustomNavBar *)navBar {
    if (!_navBar) {
        _navBar = [[LDCustomNavBar alloc]init];
        _navBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _navBar.hidden = YES;
    }
    return _navBar;
}

- (LDReadProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[LDReadProgressView alloc]init];
        _progressView.slider.value = 0;
        
        _progressView.slider.continuous = NO;
        [_progressView.slider addTarget:self action:@selector(pagingAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _progressView;
}
@end
