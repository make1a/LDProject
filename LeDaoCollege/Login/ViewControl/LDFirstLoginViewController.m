//
//  LDFirstLoginViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/11/6.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDFirstLoginViewController.h"
#import "LDTabBarController.h"
#import "AppDelegate.h"


@interface LDFirstLoginViewController ()

@end

@implementation LDFirstLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LDTabBarController *rootViewController = [[LDTabBarController alloc] init];
        AppDelegate  *delegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
        delegate.window.rootViewController = rootViewController;
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
