//
//  LDTabBarController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDTabBarController.h"
#import "LDMainViewController.h"
#import "LDStoreViewController.h"
#import "LDMineViewController.h"
@interface LDTabBarController ()

@end

@implementation LDTabBarController
- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }

    CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers: self.viewControllers
                                                                               tabBarItemsAttributes: self.tabBarItemsAttributesForController
                                                                                         imageInsets: UIEdgeInsetsZero
                                                                             titlePositionAdjustment: UIOffsetZero
                                                                                             context: nil];
    self.navigationController.navigationBar.hidden = YES;
    self = (LDTabBarController *)tabBarController;
    [self setTintColor:UIColorFromHEXA(0xFF07C062, 1)];
    return self;
}

- (NSArray *)viewControllers {
    UIViewController *homeVC = [[LDMainViewController alloc] init];
    CYLBaseNavigationController *firstNavigationController = [[CYLBaseNavigationController alloc] initWithRootViewController:homeVC];
    firstNavigationController.navigationBar.hidden = YES;
    [homeVC cyl_setHideNavigationBarSeparator:YES];
    
    UIViewController *storeVC = [[LDStoreViewController alloc] init];
    CYLBaseNavigationController *secondNavigationController = [[CYLBaseNavigationController alloc] initWithRootViewController:storeVC];
    secondNavigationController.navigationBar.hidden = YES;
    [storeVC cyl_setHideNavigationBarSeparator:YES];
    
    UIViewController *mineVC = [[LDMineViewController alloc] init];
    CYLBaseNavigationController *thirdNavigationController = [[CYLBaseNavigationController alloc] initWithRootViewController:mineVC];
//    thirdNavigationController.navigationBar.hidden = YES;
    [mineVC cyl_setHideNavigationBarSeparator:YES];
    
    NSArray *viewControllers = @[firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"学院",
                                                 CYLTabBarItemImage : @"nav_button_xueyuan_default",
                                                 CYLTabBarItemSelectedImage : @"nav_button_xueyuan_pre",
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"商城",
                                                  CYLTabBarItemImage : @"nav_button_shangcheng_default",
                                                  CYLTabBarItemSelectedImage : @"nav_button_shangcheng_pre",
                                                  };
    
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"我的",
                                                  CYLTabBarItemImage : @"nav_button_mine_default",
                                                  CYLTabBarItemSelectedImage : @"nav_button_mine_pre",
                                                  };
    
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}
@end
