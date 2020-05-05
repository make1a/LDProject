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

#import "LDShopClassViewController.h"
#import "LDShopProjectViewController.h"
#import "LDShopSkillViewController.h"
#import "LDShopBookViewController.h"
#import "LDShopPlatformViewController.h"
#import "LDShopResourceViewController.h"

#import "LDVideoDetailViewController.h"
@interface LDStoreSearchViewController ()

@end

@implementation LDStoreSearchViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}
- (NSArray *)menueBarTitles {
    return @[@"课程",@"项目",@"技术",@"书刊",@"平台",@"资源"];
}
- (void)requestTag {
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"academic/search" requestParameters:nil requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            NSArray *historyArray = responseObject[@"data"][@"historySearch"];
            if (responseObject[@"data"][@"historySearch"] != [NSNull null]) {
                if (historyArray.count>20) {
                    historyArray = [historyArray subarrayWithRange:NSMakeRange(0, 20)];
                }
                self.historyView.histroyArray = historyArray;
            }
            
            if (responseObject[@"data"][@"hotSearch"] != [NSNull null]) {
                NSArray *hotArray = responseObject[@"data"][@"hotSearch"];
                self.historyView.advanceArray = hotArray;
            }
        }
    } faild:^(NSError *error) {
        
    }];
}

// 设置菜单栏上面的每个按钮对应的VC
- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    _weakself;
    switch (pageIndex) {
        case 0:
        {
            static NSString *identifier = @"LDShopClassViewController.identifier";
            LDShopClassViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDShopClassViewController alloc] init];
                vc.isSearchModel = YES;
            }
            [vc requestSource:self.searchTitle back:^(NSInteger count) {
                weakself.noticeView.titleLabel.text = [NSString stringWithFormat:@"共找到%lu个相关内容",(unsigned long)vc.dataSource.count];
                [vc.tableView qmui_scrollToTop];
                vc.tableView.tableHeaderView = self.noticeView;
                [vc.tableView qmui_scrollToTop];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    vc.tableView.tableHeaderView = nil;
                });
            }];
            return vc;
        }
            break;
        case 1:
        {
            static NSString *identifier = @"LDShopProjectViewController.identifier";
            LDShopProjectViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDShopProjectViewController alloc] init];
                vc.isSearchModel = YES;
            }
            [vc requestSource:self.searchTitle back:^(NSInteger count) {
                weakself.noticeView.titleLabel.text = [NSString stringWithFormat:@"共找到%lu个相关内容",(unsigned long)vc.dataSource.count];
                [vc.tableView qmui_scrollToTop];
                vc.tableView.tableHeaderView = self.noticeView;
                [vc.tableView qmui_scrollToTop];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    vc.tableView.tableHeaderView = nil;
                });
            }];
            return vc;
        }
            break;
        case 2:
        {
            static NSString *identifier = @"LDShopSkillViewController.identifier";
            LDShopSkillViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDShopSkillViewController alloc] init];
                vc.isSearchModel = YES;
            }
            [vc requestSource:self.searchTitle back:^(NSInteger count) {
                weakself.noticeView.titleLabel.text = [NSString stringWithFormat:@"共找到%lu个相关内容",(unsigned long)vc.dataSource.count];
                [vc.tableView qmui_scrollToTop];
                vc.tableView.tableHeaderView = self.noticeView;
                [vc.tableView qmui_scrollToTop];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    vc.tableView.tableHeaderView = nil;
                });
            }];
            return vc;
        }
            break;
        case 3:
        {
            static NSString *identifier = @"LDShopBookViewController.identifier";
            LDShopBookViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDShopBookViewController alloc] init];
                vc.isSearchModel = YES;
            }
            [vc requestSource:self.searchTitle back:^(NSInteger count) {
                weakself.noticeView.titleLabel.text = [NSString stringWithFormat:@"共找到%lu个相关内容",(unsigned long)vc.dataSource.count];
                [vc.tableView qmui_scrollToTop];
                vc.tableView.tableHeaderView = self.noticeView;
                [vc.tableView qmui_scrollToTop];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    vc.tableView.tableHeaderView = nil;
                });
            }];
            return vc;
        }
            break;
        case 4:
        {
            static NSString *identifier = @"LDShopPlatformViewController.identifier";
            LDShopPlatformViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDShopPlatformViewController alloc] init];
                vc.isSearchModel = YES;
            }
            [vc requestSource:self.searchTitle back:^(NSInteger count) {
                weakself.noticeView.titleLabel.text = [NSString stringWithFormat:@"共找到%lu个相关内容",(unsigned long)vc.dataSource.count];
                [vc.tableView qmui_scrollToTop];
                vc.tableView.tableHeaderView = self.noticeView;
                [vc.tableView qmui_scrollToTop];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    vc.tableView.tableHeaderView = nil;
                });
            }];
            return vc;
        }
            break;
        case 5:
        {
            static NSString *identifier = @"LDShopSkillViewController.identifier";
            LDShopResourceViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDShopResourceViewController alloc] init];
                vc.isSearchModel = YES;
            }
            [vc requestSource:self.searchTitle back:^(NSInteger count) {
                weakself.noticeView.titleLabel.text = [NSString stringWithFormat:@"共找到%lu个相关内容",(unsigned long)vc.dataSource.count];
                [vc.tableView qmui_scrollToTop];
                vc.tableView.tableHeaderView = self.noticeView;
                [vc.tableView qmui_scrollToTop];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    vc.tableView.tableHeaderView = nil;
                });
            }];
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
