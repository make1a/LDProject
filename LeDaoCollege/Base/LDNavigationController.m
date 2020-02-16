//
//  LDNavigationController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/18.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDNavigationController.h"
#import "LDLoginViewController.h"
@interface LDNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation LDNavigationController
- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        if (![LDUserManager isLogin]) {
            LDLoginViewController *vc = [LDLoginViewController new];
            vc.hidesBottomBarWhenPushed = YES;
            [super pushViewController:vc animated:YES];
        }
        viewController.hidesBottomBarWhenPushed = YES;
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    [super pushViewController:viewController animated:animated];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.topViewController;
}

@end
