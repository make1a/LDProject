//
//  LDSearchViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/6.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDSearchViewController.h"

#import "LDInfoMationViewController.h"
#import "LDVoiceViewController.h"
#import "LDVideoViewController.h"
#import "LDLiveViewController.h"

@interface LDSearchViewController ()
{
    NSString *searchTitle;
}
@property(nonatomic, strong) NSArray<NSString *> *keywords;
@property(nonatomic, strong) NSMutableArray<NSString *> *searchResultsKeywords;

@end

@implementation LDSearchViewController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    searchTitle = @"";
    [self configMagicController];
    [self addHistoryView];
    [self addSearchBar];
    [self showHistoryView:YES];
    [self requestTag];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.searchBar removeFromSuperview];
    self.navigationController.navigationBar.hidden = YES;
}

- (NSArray *)menueBarTitles {
    return @[@"资讯",@"音频",@"视频",@"直播"];
}
- (void)requestTag {
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"academic/search" requestParameters:nil requestHeader:nil success:^(id responseObject) {
        DLog(@"%@",responseObject);
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

#pragma mark - private method
- (void)configMagicController{
    [self addChildViewController:self.magicController];
    [self.view addSubview:self.magicController.view];
    [self.magicController.magicView reloadData];
}
- (void)addSearchBar{
    [self.navigationController.navigationBar addSubview:self.searchBar];
    self.searchBar.frame = CGRectMake((375-280)/2, 0, 280, PtHeight(32));
    
}
- (void)addHistoryView {
    [self.view addSubview:self.historyView];
    _weakself;
    self.historyView.didSelectAdvanceActionBlock = ^(NSString *title) {
        [weakself searchAction:title];
    };
    self.historyView.didSelectHistoryActionBlock = ^(NSString *title) {
        [weakself searchAction:title];
    };
}
- (void)showHistoryView:(BOOL)isShow {
    self.historyView.hidden = !isShow;
}
#pragma  mark - Touch Event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.searchBar.qmui_textField resignFirstResponder];
}
#pragma mark - VTMagicViewDelegate
- (NSArray<__kindof NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView{
    return self.menueBarTitles;
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex
{
    
}

// 设置菜单栏上面的每个按钮对应的VC
- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    _weakself;
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
            [vc requestSource:searchTitle back:^(NSInteger count) {
                weakself.noticeView.titleLabel.text = [NSString stringWithFormat:@"共找到%ld个相关内容",vc.dataSource.count];
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
            static NSString *identifier = @"LDVoiceViewController.identifier";
            LDVoiceViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDVoiceViewController alloc] init];
                vc.isSearchModel = YES;
            }
            [vc requestSource:searchTitle mark:@"" back:^(NSInteger count) {
                weakself.noticeView.titleLabel.text = [NSString stringWithFormat:@"共找到%ld个相关内容",vc.dataSource.count];
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
            static NSString *identifier = @"LDVideoViewController.identifier";
            LDVideoViewController *vc = [magicView dequeueReusablePageWithIdentifier:identifier];
            if (!vc)
            {
                vc = [[LDVideoViewController alloc] init];
                vc.isSearchModel = YES;
            }
            [vc requestSource:searchTitle mark:@"" back:^(NSInteger count) {
                weakself.noticeView.titleLabel.text = [NSString stringWithFormat:@"共找到%ld个相关内容",vc.dataSource.count];
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

- (nonnull UIButton *)magicView:(nonnull VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:UIColorFromHEXA(0x666666, 1) forState:UIControlStateNormal];
        [menuItem setTitleColor:UIColorFromRGBA(145, 226, 192, 1) forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return menuItem;
}

#pragma mark - <UISearchControllerDelegate>
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//    searchBar.showsCancelButton = YES;
//    return YES;
//}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        [self showHistoryView:YES];
        self.searchBar.showsCancelButton = NO;
    }else {
        searchBar.showsCancelButton = YES;
        [self showHistoryView:NO];
    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    [self showHistoryView:YES];
    searchBar.text = @"";
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchAction:searchBar.text];
}
- (void)searchAction:(NSString *)title{
    searchTitle = title;
    [self showHistoryView:NO];
    [self.searchBar.qmui_textField resignFirstResponder];
    [self.magicController.magicView reloadData];
}
#pragma mark - get and set

- (QMUISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[QMUISearchBar alloc]init];
        _searchBar.placeholder = @"搜索";
        [_searchBar setCornerRadius:PtHeight(17)];
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        //        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.delegate = self;
        //        _searchBar.qmui_cancelButtonFont
        [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].title = @"取消";
        [_searchBar qmui_styledAsQMUISearchBar];
    }
    return _searchBar;
}
- (VTMagicController *)magicController {
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor clearColor];
        _magicController.magicView.navigationHeight = PtHeight(40);
        _magicController.magicView.sliderHidden = NO;
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, PtWidth(20), 5)];
        view.backgroundColor = MainThemeColor;
        [view setCornerRadius:5.0/2];
        [_magicController.magicView setSliderView:view];
        _magicController.magicView.sliderWidth = PtWidth(20);
        _magicController.magicView.sliderHeight = 5;
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.itemSpacing = 20;
        _magicController.magicView.frame = CGRectMake(0,kSTATUSBAR_NAVIGATION_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-kSTATUSBAR_NAVIGATION_HEIGHT);
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
        _magicController.magicView.needPreloading = NO;
        _magicController.magicView.separatorHidden = YES;
    }
    return _magicController;
}
- (LDSearchHistoryView *)historyView{
    if (!_historyView) {
        LDSearchHistoryView *historyView = [[LDSearchHistoryView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _historyView = historyView;
    }
    return _historyView;
}
- (LDNoticeView *)noticeView {
    if (!_noticeView) {
        _noticeView = [[NSBundle mainBundle]loadNibNamed:@"LDNoticeView" owner:self options:nil].firstObject;
    }
    return _noticeView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"dealloc..");
    self.searchBar.delegate = nil;
}
@end
