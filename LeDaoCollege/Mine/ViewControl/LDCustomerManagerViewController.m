//
//  LDCustomerManagerViewController.m
//  LeDaoCollege
//
//  Created by make on 2019/9/7.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDCustomerManagerViewController.h"
#import "ZYPinYinSearch.h"
#import "HCSortString.h"
#import "LDCustomerDetailViewController.h"
#import "LDAddressBookCell.h"
#import "LDCustomModel.h"
@interface LDCustomerManagerViewController ()<UISearchResultsUpdating>
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSArray *dataSource;/**<排序前的整个数据源*/
@property (strong, nonatomic) NSDictionary *allDataSource;/**<排序后的整个数据源*/
@property (strong, nonatomic) NSMutableArray *searchDataSource;/**<搜索结果数据源*/
@property (strong, nonatomic) NSArray *indexDataSource;/**<索引数据源*/

@end

@implementation LDCustomerManagerViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客户列表";
    self.tableView.tableFooterView = [UIView new];
    
    
    NSMutableDictionary * dict =[NSMutableDictionary dictionaryWithObjects:@[[UIColor whiteColor]]forKeys:@[NSForegroundColorAttributeName]];

    [self.navigationController.navigationBar setTitleTextAttributes:dict];

    self.navigationController.navigationBar.barTintColor = MainThemeColor;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    _searchController = nil;
}

- (void)requestData{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"customer/getcustomer" requestParameters:nil requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDCustomModel class] json:responseObject[@"data"]];
            [self initData];
            [self.tableView reloadData];
        }
    } faild:^(NSError *error) {
            
    }];
}
#pragma mark - Init
- (void)initData {
    _searchDataSource = [NSMutableArray new];
    
    _allDataSource = [HCSortString sortAndGroupForArray:_dataSource PropertyName:@"name"];
    _indexDataSource = [HCSortString sortForStringAry:[_allDataSource allKeys]];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LDAddressBookCell" bundle:nil] forCellReuseIdentifier:@"LDAddressBookCell"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.searchController.active) {
        return _indexDataSource.count;
    }else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.searchController.active) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[section]];
        return value.count;
    }else {
        return _searchDataSource.count;
    }
}
//头部索引标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!self.searchController.active) {
        return _indexDataSource[section];
    }else {
        return nil;
    }
}
//右侧索引列表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (!self.searchController.active) {
        return _indexDataSource;
    }else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LDAddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDAddressBookCell"];
    if (!self.searchController.active) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
       LDCustomModel *model = value[indexPath.row];
        cell.nameLabel.text = model.name;
        cell.phoneLabel.text = model.phone;
    }else{
        LDCustomModel *model = _searchDataSource[indexPath.row];
        cell.nameLabel.text = model.name;
        cell.phoneLabel.text = model.phone;
    }
    return cell;
}
//索引点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return  [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.searchController.active) {
    LDCustomerDetailViewController *vc = [LDCustomerDetailViewController new];
     NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
    LDCustomModel *model = value[indexPath.row];
    vc.c_id = model.c_id;
    [self.navigationController pushViewController:vc animated:YES];
    }else{
        LDCustomerDetailViewController *vc = [LDCustomerDetailViewController new];
        LDCustomModel *model = _searchDataSource[indexPath.row];
        vc.c_id = model.c_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
    self.searchController.active = NO;
}

#pragma mark - UISearchDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [_searchDataSource removeAllObjects];
    NSArray *ary = [HCSortString getAllValuesFromDict:_allDataSource];
    
    if (searchController.searchBar.text.length == 0) {
        [_searchDataSource addObjectsFromArray:ary];
    }else {
        ary = [ZYPinYinSearch searchWithOriginalArray:ary andSearchText:searchController.searchBar.text andSearchByPropertyName:@"name"];
        [_searchDataSource addObjectsFromArray:ary];
    }
    [self.tableView reloadData];
}


- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        _searchController.searchBar.placeholder = @"搜索";
        _searchController.searchBar.barStyle = UISearchBarStyleMinimal;
        [_searchController.searchBar qmui_styledAsQMUISearchBar];
        [_searchController.searchBar sizeToFit];
                UIImage *image = [UIImage qmui_imageWithColor:[UIColor whiteColor] size:CGSizeMake(200, 32) cornerRadius:0];
        [_searchController.searchBar setBackgroundImage:image];
        [_searchController.searchBar setBackgroundColor:[UIColor clearColor]];
        _searchController.searchBar.qmui_textField.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].title = @"取消";
    }
    return _searchController;
}

@end
