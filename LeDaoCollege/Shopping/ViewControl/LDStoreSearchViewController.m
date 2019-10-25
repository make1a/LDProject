//
//  LDStoreSearchViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/19.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDStoreSearchViewController.h"
#import "LDAllshoppingViewController.h"
#import "LDToolBooksViewController.h"
#import "LDSmallClassViewController.h"

@interface LDStoreSearchViewController ()

@end

@implementation LDStoreSearchViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = !YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (NSArray *)menueBarTitles {
    return @[@"全部商品",@"工具书",@"微课"];
}
- (void)requestTag {
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"academic/search" requestParameters:nil requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            NSArray *historyArray = responseObject[@"data"][@"historySearch"];
            if (historyArray.count>20) {
               historyArray = [historyArray subarrayWithRange:NSMakeRange(0, 20)];
            }
            NSArray *hotArray = responseObject[@"data"][@"hotSearch"];
            self.historyView.histroyArray = historyArray;
            self.historyView.advanceArray = hotArray;
        }
    } faild:^(NSError *error) {
        
    }];
}

// 设置菜单栏上面的每个按钮对应的VC
- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    switch (pageIndex) {
        case 0:
        {
            static NSString *identifier = @"LDAllshoppingViewController.identifier";
            LDAllshoppingViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDAllshoppingViewController alloc] init];
            }
            return vc;
        }
            break;
        case 1:
        {
            static NSString *identifier = @"LDToolBooksViewController.identifier";
            LDToolBooksViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDToolBooksViewController alloc] init];
            }
            return vc;
        }
            break;
        case 2:
        {
            static NSString *identifier = @"LDSmallClassViewController.identifier";
            LDSmallClassViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDSmallClassViewController alloc] init];
            }
            return vc;
        }
            break;
        default:
        {
            return nil;
        }
            break;
    }
}

@end
