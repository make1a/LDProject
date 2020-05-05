//
//  LDBookDicViewController.m
//  LeDaoCollege
//
//  Created by make on 2020/2/15.
//  Copyright © 2020 Make. All rights reserved.
//

#import "LDBookDicViewController.h"
#import "LDDicBookCell.h"
#import "SDCycleScrollView.h"
#import "LDStoreModel.h"
#import "LDShoppingDetailViewController.h"
#import "LDBookListViewController.h"
#import "LDBannerModel.h"
#import "LDVideoDetailViewController.h"
#import "LDWebViewViewController.h"
#import "LDSmallClassDetailViewController.h"

@interface LDBookDicViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@property (nonatomic,strong)NSMutableArray * dataSource0;
@property (nonatomic,strong)NSMutableArray * dataSource1;
@property (nonatomic,strong)NSMutableArray * dataSource2;
@property (nonatomic,strong)NSMutableArray * dataSource3;

@property (nonatomic,strong)NSArray * bannerArray;
@property (nonatomic,strong)NSMutableArray * imageArray;
@end

@implementation LDBookDicViewController
- (instancetype)initWithStyle:(UITableViewStyle)style{
    style = UITableViewStyleGrouped;
    self = [super initWithStyle:style];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    if (!self.isSearchModel) {
        [self requestSource:nil mark:nil back:^(NSInteger count) {
            
        }];
        typeof(self)weakSelf = self;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf requestSource:nil mark:nil back:^(NSInteger count) {
                
            }];
        }];
        [self requestBannerList];
    }
}
- (void)configUI{
    self.tableView.tableHeaderView = self.cycleScrollView;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorColor = [UIColor clearColor];
}

- (void)requestSource:(NSString * _Nullable )title mark:(NSString * _Nullable)mark back:(backSourceCountBlock)blcok{
    NSDictionary *dic;
    if (title) {
        dic = @{@"title":title};
    }
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"book/books" requestParameters:dic requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDStoreModel class] json:responseObject[@"data"][@"list"]];
            self.dataSource0 = @[].mutableCopy;
            self.dataSource1 = @[].mutableCopy;
            self.dataSource2 = @[].mutableCopy;
            self.dataSource3 = @[].mutableCopy;
            for (LDStoreModel *model in self.dataSource) {
                if ([model.type isEqualToString:@"1"]) {
                    [self.dataSource0 addObject:model];
                }else if ([model.type isEqualToString:@"2"]) {
                    [self.dataSource1 addObject:model];
                }else if ([model.type isEqualToString:@"3"]) {
                    [self.dataSource2 addObject:model];
                }else{
                    [self.dataSource3 addObject:model];
                }
            }
            [self.tableView reloadData];
            if (blcok) {
                blcok(self.dataSource.count);
            }
        }
        [self.tableView.mj_header endRefreshing];
    } faild:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)requestBannerList {
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"banner/getbytype/1" requestParameters:@{@"type":@"1"} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            NSArray *array = responseObject[@"data"];
            if (![responseObject[@"data"] isKindOfClass:[NSArray class]]) {
                return ;
            }
           self.bannerArray = [NSArray yy_modelArrayWithClass:[LDBannerModel class] json:responseObject[@"data"]];
            self.imageArray = @[].mutableCopy;
            for (NSDictionary *dic in array) {
                NSString *url = dic[@"imgUrl"];
                if ([url containsString:@"http"]) {
                    [self.imageArray addObject:url];
                }else{
                    url = [NSString stringWithFormat:@"%@img/%@",BaseAPI,url];
                    [self.imageArray addObject:url];
                }
            }
            self.netImages = self.imageArray;
        }
    } faild:^(NSError *error) {
        
    }];
}
- (void)clickShowMore:(UIButton *)sender{
    LDBookListViewController *vc = [LDBookListViewController new];
    vc.type = sender.tag-100;
    vc.title = self.titleArray[sender.tag-101];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma  mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    switch (section) {
        case 0:
           return self.dataSource0.count;
            break;
        case 1:
           return self.dataSource1.count;
            break;
        case 2:
           return self.dataSource2.count;
            break;
        default:
            return self.dataSource3.count;
            break;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDDicBookCell *cell = [LDDicBookCell dequeueReusableWithTableView:tableView];
    if (self.dataSource) {
        LDStoreModel *model;
        switch (indexPath.section) {
            case 0:
                model = self.dataSource0[indexPath.row];
                break;
            case 1:
               model = self.dataSource1[indexPath.row];
                break;
            case 2:
               model = self.dataSource2[indexPath.row];
                break;
            default:
                model = self.dataSource3[indexPath.row];
                break;
        }
        [cell refreshWithModel:model];
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]init];
    label.text = self.titleArray[section];
    [view addSubview:label];
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.tag = section+100+1;
    [moreButton setTitle:@"更多" forState:UIControlStateNormal];
    [moreButton setTitleColor:UIColorFromHEXA(0x999898, 1.f) forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(clickShowMore:) forControlEvents:UIControlEventTouchUpInside];
    moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:moreButton];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).mas_offset(18.5);
        make.bottom.mas_equalTo(view).mas_offset(-8);
    }];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view).mas_offset(-8);
        make.bottom.mas_equalTo(label);
    }];
    label.font = [UIFont boldSystemFontOfSize:18];
    return view;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kTableViewCellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LDShoppingDetailViewController *vc = [LDShoppingDetailViewController new];
    LDStoreModel *model;
     switch (indexPath.section) {
         case 0:
             model = self.dataSource0[indexPath.row];
             break;
         case 1:
            model = self.dataSource1[indexPath.row];
             break;
         case 2:
            model = self.dataSource2[indexPath.row];
             break;
         default:
             model = self.dataSource3[indexPath.row];
             break;
     }
    vc.shopID = model.s_id;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma  mark - SDCyclesScrollview
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    LDBannerModel *model = self.bannerArray[index];
    if ([model.bannerType isEqualToString:@"1"]) {
        LDWebViewViewController * vc = [LDWebViewViewController new];
        vc.urlStrng = [NSString stringWithFormat:@"%@?id=%@&token=%@",model.bannerUrl,model.bannerId,[LDUserManager userID]];
        vc.s_id = model.bannerId;
        vc.collectionType = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.bannerType isEqualToString:@"2"]){
        LDShoppingDetailViewController *vc = [LDShoppingDetailViewController new];
        vc.shopID = model.bannerId;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.bannerType isEqualToString:@"3"]){
        
        LDVideoDetailViewController *vc = [[LDVideoDetailViewController alloc]init];
        vc.videoID = model.bannerId;
        vc.isSmallClass = NO;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([model.bannerType isEqualToString:@"4"]){
        LDWebViewViewController * vc = [LDWebViewViewController new];
        vc.urlStrng = [NSString stringWithFormat:@"%@?id=%@&token=%@",model.bannerUrl,model.bannerId,[LDUserManager userID]];
        vc.s_id = model.bannerId;
        vc.collectionType = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LDSmallClassDetailViewController *vc = [LDSmallClassDetailViewController new];
        vc.videoID = model.bannerId;
        [self.navigationController pushViewController:vc animated:YES];
    }

}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}

#pragma  mark - GET SET
- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"期刊",@"工具书",@"项目案例",@"知识库"];
    }
    return _titleArray;
}
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        UIImage * placeholderImage = [UIImage imageNamed:@"seizeaseat_1"];
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, 180);
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
        _cycleScrollView.imageURLStringsGroup = self.netImages;
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.currentPageDotColor = MainThemeColor;
        _cycleScrollView.pageDotColor = [UIColor whiteColor];
    }
    return _cycleScrollView;
}
- (void)setNetImages:(NSArray *)netImages{
    _netImages = netImages;
    self.cycleScrollView.imageURLStringsGroup = netImages;
}

@end

