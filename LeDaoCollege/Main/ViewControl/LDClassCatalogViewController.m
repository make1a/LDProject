//
//  LDClassCatalogViewController.m
//  LeDaoCollege
//
//  Created by Make on 2020/1/8.
//  Copyright © 2020 Make. All rights reserved.
//

#import "LDClassCatalogViewController.h"

#import "LDCatalogCell.h"
#import "LDSmallClassLessonCell.h"

@interface LDClassCatalogViewController ()

@end

@implementation LDClassCatalogViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self configTableView];
}
- (void)configTableView{
    [self.tableView registerNib:[UINib nibWithNibName:@"LDCatalogCell" bundle:nil] forCellReuseIdentifier:@"LDCatalogCell"];
}
//#pragma  mark - TableView
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataSource.count;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    LDCatalogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDCatalogCell"];
//    LDVideoDetailModel *model = self.dataSource[indexPath.row];
//    cell.titleLabel.text = model.sectionName;
//    if (self.currentIndex == indexPath.row) {
//        cell.titleLabel.textColor = UIColorMake(70, 143, 233);
//        cell.darkView.backgroundColor = UIColorMake(70, 143, 233);
//    }else {
//        cell.titleLabel.textColor = [UIColor blackColor];
//        cell.darkView.backgroundColor = [UIColor blackColor];
//    }
//    return cell;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    if (self.currentIndex == indexPath.row) {
//        return;
//    }
//    self.currentIndex = indexPath.row;
//    if (self.didSelectBlock) {
//        self.didSelectBlock(indexPath.row);
//    }
//    [tableView reloadData];
//}


#pragma  mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.currenModel.chapterArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LDClassChapterModel *model = self.currenModel.chapterArray[section];
    return model.sectionArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LDCatalogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDCatalogCell"];
    LDClassChapterModel *model = self.currenModel.chapterArray[indexPath.section];
    LDClassChapterSectionModel *sectionModel = model.sectionArray[indexPath.row];
    cell.titleLabel.text = sectionModel.sectionTitle;
    if (self.currentIndex == indexPath.row) {
        cell.titleLabel.textColor = UIColorMake(70, 143, 233);
        cell.darkView.backgroundColor = UIColorMake(70, 143, 233);
    }else {
        cell.titleLabel.textColor = [UIColor blackColor];
        cell.darkView.backgroundColor = [UIColor blackColor];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.currentIndex == indexPath.row) {
        return;
    }
    self.currentIndex = indexPath.row;
    if (self.didSelectBlock) {
        self.didSelectBlock(indexPath);
    }
    [tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.currenModel) {
        LDClassChapterModel *model = self.currenModel.chapterArray[section];
        NSString *chapterName = [NSString stringWithFormat:@"%@:%@",model.chapterNo,model.chapterTitle];
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc]init];
        label.text = chapterName;
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(view);
            make.left.mas_equalTo(view).mas_offset(16);
        }];
        return view;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
@end
