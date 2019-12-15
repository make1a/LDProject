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
#import "LDSmallClassSectionDetailViewController.h"
#import "LDClassModel.h"
#import "LDCommitBuyViewController.h"
#import "LDNoUseView.h"

@interface LDSmallClassDetailViewController ()<QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic,strong)QMUITableView * tableView;
@property (nonatomic,strong)LDShoppingDetailFootView * footView;
@property (nonatomic,strong)LDSmallClassDetailHeadView * headView;
@property(nonatomic, strong) QMUINavigationBarScrollingSnapAnimator *navigationAnimator;
@property (nonatomic,strong)LDClassModel * currenModel;
@property (nonatomic,strong)LDNoUseView * noUseView;
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
    self.title = @"商品详情";
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, QMUIViewSelfSizingHeight);
}
- (void)masLayoutSubViews{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    if (self.isPay == NO) {
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
    self.tableView.tableHeaderView = self.headView;
}
- (void)addNouseView:(NSString *)flag {
    if ([flag isEqualToString:@"N"]) {
        self.footView.buyButton.enabled = NO;
        [self.view addSubview:self.noUseView];
        [self.noUseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.footView.mas_top);
            make.left.right.mas_equalTo(self.view);
            make.height.mas_equalTo(PtHeight(40));
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
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
            [self addNouseView:self.currenModel.activeFlag];
            self.headView.titleLabel.text = self.currenModel.title;
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
            [self.view setNeedsLayout];
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
- (void)clickBuyAction:(id)sender{
    LDCommitBuyViewController *vc = [[LDCommitBuyViewController alloc]initWithNibName:@"LDCommitBuyViewController" bundle:[NSBundle mainBundle]];
    vc.currentModel = self.currenModel;
    vc.title = @"确认购买";
    vc.goodsId = self.currenModel.c_id;
    vc.goodsType = @"4";
    [self.navigationController pushViewController:vc animated:YES];
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
    if (!self.isPay) {
        return;
    }
    if (indexPath.section != 0) {
        LDSmallClassSectionDetailViewController *vc = [LDSmallClassSectionDetailViewController new];
        LDClassChapterModel *model = self.currenModel.chapterArray[indexPath.section-1];
        LDClassChapterSectionModel *sectionModel = model.sectionArray[indexPath.row];
        vc.urlStrng = sectionModel.sectionContent;
        [self.navigationController pushViewController:vc animated:YES];
    }
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
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == self.currenModel.chapterArray.count) {
//        return 10;;
//    }
//    return CGFLOAT_MIN;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return  [UIView new];
//}
#pragma  mark - GET SET
- (QMUITableView *)tableView {
    if (!_tableView) {
        _tableView = [[QMUITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, SCREEN_HEIGHT-kTABBAR_HEIGHT) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
        [_tableView registerNib:[UINib nibWithNibName:@"LDSmallClassLessonCell" bundle:nil] forCellReuseIdentifier:@"LDSmallClassLessonCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"LDSmallClassDetailIntroCell" bundle:nil] forCellReuseIdentifier:@"LDSmallClassDetailIntroCell"];
        
    }
    return _tableView;
}
- (LDShoppingDetailFootView *)footView {
    if (!_footView) {
        _footView = [[NSBundle mainBundle]loadNibNamed:@"LDShoppingDetailFootView" owner:self options:nil].firstObject;
        [_footView.collectionButton addTarget:self action:@selector(clickCollectionAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footView.buyButton addTarget:self action:@selector(clickBuyAction:) forControlEvents:UIControlEventTouchUpInside];
        _footView.qmui_borderPosition = QMUIViewBorderPositionTop;
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
- (LDNoUseView *)noUseView {
    if (!_noUseView) {
        _noUseView = [[NSBundle mainBundle]loadNibNamed:@"LDNoUseView" owner:self options:nil].firstObject;
    }
    return _noUseView;
}
@end
