//
//  LDStoreSearchViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/19.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDStoreSearchViewController.h"


#import "LDInfoMationViewController.h"
#import "LDVoiceViewController.h"
#import "LDVideoViewController.h"
#import "LDLiveViewController.h"

@interface LDStoreSearchViewController ()

@end

@implementation LDStoreSearchViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = !YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (NSArray *)menueBarTitles {
    return @[@"全部商品",@"工具书",@"微课"];
}

// 设置菜单栏上面的每个按钮对应的VC
- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    switch (pageIndex) {
        case 0:
        {
            static NSString *identifier = @"LDInfoMationViewController.identifier";
            LDInfoMationViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDInfoMationViewController alloc] init];
                vc.isSearchModel = YES;
            }
            return vc;
        }
            break;
        case 1:
        {
            static NSString *identifier = @"LDVoiceViewController.identifier";
            LDVoiceViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDVoiceViewController alloc] init];
                vc.isSearchModel = YES;
            }
            return vc;
        }
            break;
        case 2:
        {
            static NSString *identifier = @"LDVideoViewController.identifier";
            LDVideoViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDVideoViewController alloc] init];
                vc.isSearchModel = YES;
            }
            return vc;
        }
            break;
        default:
        {
            static NSString *identifier = @"LDLiveViewController.identifier";
            LDLiveViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDLiveViewController alloc] init];
                vc.isSearchModel = YES;
            }
            return vc;
        }
            break;
    }
}

@end
