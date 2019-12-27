//
//  LDCatalogViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/12/14.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDCatalogViewController.h"
#import "LDVideoModel.h"
#import "LDCatalogCell.h"
@implementation LDCatalogViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self configTableView];
}
- (void)configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:@"LDCatalogCell" bundle:nil] forCellReuseIdentifier:@"LDCatalogCell"];
}
#pragma  mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDCatalogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDCatalogCell"];
    LDVideoDetailModel *model = self.dataSource[indexPath.row];
    cell.titleLabel.text = model.sectionName;
    if (self.currentIndex == indexPath.row) {
        cell.titleLabel.textColor = UIColorMake(70, 143, 233);
        cell.darkView.backgroundColor = UIColorMake(70, 143, 233);
    }else {
        cell.titleLabel.textColor = [UIColor blackColor];
        cell.darkView.backgroundColor = [UIColor blackColor];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.currentIndex == indexPath.row) {
        return;
    }
    self.currentIndex = indexPath.row;
    if (self.didSelectBlock) {
        self.didSelectBlock(indexPath.row);
    }
    [tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
@end
