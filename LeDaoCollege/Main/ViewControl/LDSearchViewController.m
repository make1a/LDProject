//
//  LDSearchViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/6.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDSearchViewController.h"
#import "LDSearchHistoryView.h"

@interface LDSearchViewController () <UISearchBarDelegate,UIGestureRecognizerDelegate>
@property(nonatomic, strong) NSArray<NSString *> *keywords;
@property(nonatomic, strong) NSMutableArray<NSString *> *searchResultsKeywords;
@property(nonatomic, strong) QMUISearchBar *searchBar;
@property (nonatomic,strong) UITableView * tableView;
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
    
    [self.navigationController.navigationBar addSubview:self.searchBar];
    self.searchBar.frame = CGRectMake(70, 0, 280, PtHeight(32));
    
    LDSearchHistoryView *historyView = [[LDSearchHistoryView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:historyView];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.searchBar removeFromSuperview];
    self.navigationController.navigationBar.hidden = YES;
}
#pragma  mark - Touch Event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.searchBar.qmui_textField resignFirstResponder];
}
#pragma  mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return self.keywords.count;
    }
    return self.searchResultsKeywords.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initForTableView:tableView withReuseIdentifier:identifier];
    }
    
    if (tableView == self.tableView) {
        cell.textLabel.text = self.keywords[indexPath.row];
    } else {
        NSString *keyword = self.searchResultsKeywords[indexPath.row];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:keyword attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
        NSRange range = [keyword rangeOfString:self.searchBar.text];
        if (range.location != NSNotFound) {
            [attributedString addAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} range:range];
        }
        cell.textLabel.attributedText = attributedString;
    }
    
    [cell updateCellAppearanceWithIndexPath:indexPath];
    return cell;
}
#pragma mark - <UISearchControllerDelegate>
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    DLog(@"searchBarShouldBeginEditing");
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    DLog(@"searchBarTextDidBeginEditing");
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    DLog(@"searchBarShouldEndEditing");
    
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    DLog(@"searchBarTextDidEndEditing");
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    DLog(@"textDidChange");
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar.qmui_textField resignFirstResponder];
}
#pragma mark - event response


#pragma mark - private method
#pragma mark - get and set

- (QMUISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[QMUISearchBar alloc]init];
        [_searchBar setCornerRadius:PtHeight(16)];
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.backgroundColor = UIColorFromHEXA(0xF5F6FA, 1);
        _searchBar.placeholder = @"搜索";
        _searchBar.delegate = self;
        [_searchBar qmui_styledAsQMUISearchBar];
    }
    return _searchBar;
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
