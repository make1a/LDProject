//
//  AppDelegate.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import "AppDelegate.h"
#import "LDTabBarController.h"
#import <IQKeyboardManager.h>
#import "LDLoginViewController.h"
#import "LDFirstLoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIApplication sharedApplication].statusBarHidden = NO;
    // 设置主窗口,并设置根控制器
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    [self.window makeKeyAndVisible];
    [[QMUIConfiguration sharedInstance]applyInitialTemplate];

    [self configIQKeyboard];
    [self configMainView];
//    if (@available(iOS 13.0, *)) {
//        self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
//    } else {
//        // Fallback on earlier versions
//    }
    
    [self autoLogin];
    return YES;
}
- (void)configMainView{
    if ([LDUserManager isLogin]) {
        LDTabBarController *rootViewController = [[LDTabBarController alloc] init];
        AppDelegate  *delegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
        delegate.window.rootViewController = rootViewController;
    }else {
        LDLoginViewController *vc = [LDLoginViewController new];
        [self.window setRootViewController:vc];
    }
}
- (void)configIQKeyboard {
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)autoLogin{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:@"autologin" requestParameters:nil requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            LDUserModel *model = [LDUserModel yy_modelWithDictionary:responseObject[@"data"][@"user"]];
            [LDUserManager shareInstance].currentUser = model;
            NSString *f = responseObject[@"data"][@"firstLogin"];
            if ([f isEqualToString:@"Y"]) { //第一次登陆
                LDFirstLoginViewController *vc = [LDFirstLoginViewController new];
                AppDelegate  *delegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
                delegate.window.rootViewController = vc;
            }else {
                LDTabBarController *rootViewController = [[LDTabBarController alloc] init];
                AppDelegate  *delegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
                delegate.window.rootViewController = rootViewController;
            }
        }else {
            LDLoginViewController *vc = [LDLoginViewController new];
            [self.window setRootViewController:vc];
        }
    } faild:^(NSError *error) {
        LDLoginViewController *vc = [LDLoginViewController new];
        [self.window setRootViewController:vc];
    }];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
