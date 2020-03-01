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
#import "LDNavigationController.h"
#import "LDShoppingViewController.h"
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
    self = (LDTabBarController *)tabBarController;
    [self setTintColor:UIColorFromHEXA(0x2686EA, 1)];
    return self;
}

- (NSArray *)viewControllers {
    UIViewController *homeVC = [[LDMainViewController alloc] init];
    LDNavigationController *firstNavigationController = [[LDNavigationController alloc] initWithRootViewController:homeVC];
    firstNavigationController.navigationBar.hidden = YES;
    [homeVC cyl_setHideNavigationBarSeparator:YES];
    
    UIViewController *storeVC = [[LDShoppingViewController alloc] init];
    LDNavigationController *secondNavigationController = [[LDNavigationController alloc] initWithRootViewController:storeVC];
//    secondNavigationController.navigationBar.hidden = YES;
    [storeVC cyl_setHideNavigationBarSeparator:YES];
    
    UIViewController *mineVC = [[LDMineViewController alloc] init];
    LDNavigationController *thirdNavigationController = [[LDNavigationController alloc] initWithRootViewController:mineVC];
    thirdNavigationController.navigationBar.hidden = YES;
    [mineVC cyl_setHideNavigationBarSeparator:YES];
    
    NSArray *viewControllers = @[firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"院",
        CYLTabBarItemImage : @"nav_button_xueyuan_pre",
        CYLTabBarItemSelectedImage : @"nav_button_xueyuan_pre 2",
    };
    NSDictionary *secondTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"城",
        CYLTabBarItemImage : @"nav_button_shangcheng_default",
        CYLTabBarItemSelectedImage : @"nav_button_shangcheng_default 2",
    };
    
    NSDictionary *thirdTabBarItemsAttributes = @{
        CYLTabBarItemTitle : @"我",
        CYLTabBarItemImage : @"nav_button_mine_default",
        CYLTabBarItemSelectedImage : @"nav_button_mine_default 2",
    };
    
    NSArray *tabBarItemsAttributes = @[
        firstTabBarItemsAttributes,
        secondTabBarItemsAttributes,
        thirdTabBarItemsAttributes
    ];
    return tabBarItemsAttributes;
}
@end
