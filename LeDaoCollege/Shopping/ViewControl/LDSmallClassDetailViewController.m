//
//  LDSmallClassDetailViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/23.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDSmallClassDetailViewController.h"
#import "LDShoppingDetailFootView.h"
#import "LDShoppingDetailNameViewCell.h"
#import "LDSmallClassDetailHeadView.h"
#import "LDSmallClassDetailIntroCell.h"
#import "LDSmallClassLessonCell.h"
#import "LDClassModel.h"
@interface LDSmallClassDetailViewController ()<QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic,strong)QMUITableView * tableView;
@property (nonatomic,strong)LDShoppingDetailFootView * footView;
@property (nonatomic,strong)LDSmallClassDetailHeadView * headView;
@property(nonatomic, strong) QMUINavigationBarScrollingSnapAnimator *navigationAnimator;
@property (nonatomic,strong)LDClassModel * currenModel;
@end

@implementation LDSmallClassDetailViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self masLayoutSubViews];
    [self requestDtasource];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)masLayoutSubViews{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footView];
    self.tableView.tableHeaderView = self.headView;
    [self.view addSubview:self.footView];
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.tableView.mas_bottom);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
    }];
}
- (void)requestDtasource{
    if (!self.classID) {
        return;
    }
    NSString *api = [NSString stringWithFormat:@"course/getcourseinfo/%@",self.classID];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:api requestParameters:@{@"id":self.classID} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.currenModel = [LDClassModel yy_modelWithJSON:responseObject[@"data"]];
            [self.tableView reloadData];
            self.headView.nameLabel.text = self.currenModel.lecturerName;
            self.headView.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.currenModel.discount];
            self.headView.discountPriceLabel.text = [NSString stringWithFormat:@"¥%@",self.currenModel.originalPrice];
            self.headView.introLabel.text = self.currenModel.briefIntroduction;
            [self.headView.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@img/%@",BaseAPI,self.currenModel.coverImg]] placeholderImage:[UIImage imageNamed:@"mine_headportrait_default"]];
            if ([self.currenModel.collectionFlag isEqualToString:@"Y"]) {
                self.footView.collectionButton.selected = YES;
            }else {
                self.footView.collectionButton.selected = !YES;
            }
        }
    } faild:^(NSError *error) {
        
    }];
}
- (void)collectionAction{
    if (self.classID.length == 0) {
        return;
    }
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:@"collection/addanddelete" requestParameters:@{@"collectionId":self.classID,@"collectionType":@"5"} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            [QMUITips showSucceed:responseObject[@"returnMsg"]];
            if ([self.currenModel.collectionFlag isEqualToString:@"N"]) {
                self.currenModel.collectionFlag = @"Y";
            } else {
                self.currenModel.collectionFlag = @"N";
            }
        }
    } faild:^(NSError *error) {
        
    }];
}
- (void)clickCollectionAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    [self collectionAction];
}
#pragma  mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.currenModel.chapterArray.count+1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    LDClassChapterModel *model = self.currenModel.chapterArray[section-1];
    return model.sectionArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && indexPath.section == 0) {
        LDSmallClassDetailIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDSmallClassDetailIntroCell" forIndexPath:indexPath];
        if (self.currenModel) {
            [cell refreshWith:self.currenModel];
        }
        return cell;
    }
    LDSmallClassLessonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDSmallClassLessonCell" forIndexPath:indexPath];
    if (self.currenModel) {
        LDClassChapterModel *model = self.currenModel.chapterArray[indexPath.section-1];
        LDClassChapterSectionModel *sectionModel = model.sectionArray[indexPath.row];
        [cell refreshWith:sectionModel];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.currenModel) {
        LDClassChapterModel *model = self.currenModel.chapterArray[section-1];
        NSString *chapterName = model.chapterTitle;
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
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 30;
}
#pragma  mark - GET SET
- (QMUITableView *)tableView {
    if (!_tableView) {
        _tableView = [[QMUITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, SCREEN_HEIGHT-kTABBAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"LDSmallClassLessonCell" bundle:nil] forCellReuseIdentifier:@"LDSmallClassLessonCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"LDSmallClassDetailIntroCell" bundle:nil] forCellReuseIdentifier:@"LDSmallClassDetailIntroCell"];
        
    }
    return _tableView;
}
- (LDShoppingDetailFootView *)footView {
    if (!_footView) {
        _footView = [[NSBundle mainBundle]loadNibNamed:@"LDShoppingDetailFootView" owner:self options:nil].firstObject;
        [_footView.collectionButton addTarget:self action:@selector(clickCollectionAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footView;
}
- (LDSmallClassDetailHeadView *)headView {
    if (!_headView) {
        _headView = [[NSBundle mainBundle]loadNibNamed:@"LDSmallClassDetailHeadView" owner:self options:nil].firstObject;
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 227);
    }
    return _headView;
}
@end
