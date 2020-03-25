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

#import "IAPShare.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import "LDNavigationController.h"
#import <UMAnalytics/MobClick.h>
@interface AppDelegate ()
{
    LDTabBarController *_tabbarController;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIApplication sharedApplication].statusBarHidden = NO;
    // 设置主窗口,并设置根控制器
    sleep(3);
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
    [self setUMdata];
    [self autoLogin];
    [self recharge];
    return YES;
}

- (void)setUMdata
{
    //设置友盟appkey
//      [UMCommonLogManager setUpUMCommonLogManager];
    [UMConfigure initWithAppkey:UMengAppkey channel:nil];
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAPPKEY appSecret:WXAPPSecret redirectURL:BaseAPI];
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:WBAPPKEY  appSecret:WBAPPSecret redirectURL:BaseAPI];
    
    [MobClick setScenarioType:E_UM_NORMAL];
}
- (void)configMainView{
    if ([LDUserManager isLogin]) {
        LDTabBarController *rootViewController = [[LDTabBarController alloc] init];
        AppDelegate  *delegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
        delegate.window.rootViewController = rootViewController;
        _tabbarController = rootViewController;
    }else {
        LDLoginViewController *vc = [LDLoginViewController new];
        LDNavigationController *nav = [[LDNavigationController alloc]initWithRootViewController:vc];
        [self.window setRootViewController:nav];
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
                LDTabBarController *rootViewController = [[LDTabBarController alloc] init];
            self->_tabbarController = rootViewController;
                AppDelegate  *delegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
                delegate.window.rootViewController = rootViewController;
            if ([f isEqualToString:@"Y"]) { //第一次登录
                [[NSNotificationCenter defaultCenter]postNotificationName:@"LDFirstLoginNotify" object:nil];
            }
        }else {
            LDLoginViewController *vc = [LDLoginViewController new];
            LDNavigationController *nav = [[LDNavigationController alloc]initWithRootViewController:vc];
            [self.window setRootViewController:nav];
        }
    } faild:^(NSError *error) {
        LDLoginViewController *vc = [LDLoginViewController new];
        LDNavigationController *nav = [[LDNavigationController alloc]initWithRootViewController:vc];
        [self.window setRootViewController:nav];
    }];
}
- (void)recharge{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]valueForKey:kLocalPurchData];
    if (!dic) {
        return;
    }
    [[IAPShare sharedHelper].iap checkReceipt:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]] onCompletion:^(NSString *response, NSError *error) {

        [IAPHelper sendDataToServerorderId:dic[@"orderId"] productID:dic[@"productID"] recesData:dic[@"receipt"] success:^(id responseObject) {
            if (kCODE == 200) {
                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                    [QMUITips hideAllTips];
                    [QMUITips showSucceed:@"充值成功"];
                }];
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:kLocalPurchData];
            }else {
                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                    [QMUITips hideAllTips];
                    [QMUITips showError:kRequestFailMsg];
                }];
            }
        } faild:^(NSError *error) {
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                [QMUITips hideAllTips];
                [QMUITips showError:kRequestFailMsg];
            }];
        }];;
    }];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];

    return result;
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
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAll;
}

@end
