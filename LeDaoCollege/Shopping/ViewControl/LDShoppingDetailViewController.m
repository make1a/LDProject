//
//  LDShoppingDetailViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/20.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDShoppingDetailViewController.h"
#import "SDCycleScrollView.h"
#import "LDShoppingTableViewCell.h"
#import "LDShoppingDetailViewController.h"
#import "LDShoppingDetailNameViewCell.h"
#import "LDShoppingTitleCell.h"
#import "LDShoppingDetailFootView.h"
#import "LDCommitBuyViewController.h"
#import "LDStoreModel.h"
#import "LDNoUseView.h"
@interface LDShoppingDetailViewController ()<SDCycleScrollViewDelegate,QMUITableViewDelegate,QMUITableViewDataSource,UIWebViewDelegate>
{
    BOOL isLoadData;
}
@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@property (nonatomic,strong)NSArray * netImages;
@property (nonatomic,strong)QMUITableView * tableView;
@property (nonatomic,strong)LDShoppingDetailFootView * footView;
@property (nonatomic,strong)UIButton * backButton;
@property (nonatomic,strong)LDBookModel *currentModel;
@property (nonatomic,strong)UIWebView * myWebView;
@property (nonatomic,strong)LDNoUseView * noUseView;
@end

@implementation LDShoppingDetailViewController
#pragma  mark - view cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self masLayoutSubviews];
    [self footerViewActions];
    [self requestDataSource];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
#pragma  mark - Request
- (void)requestDataSource{
    if (self.shopID.length == 0) {
        return;
    }
    NSString *url = [NSString stringWithFormat:@"book/book/%@",self.shopID];
    [QMUITips showLoadingInView:self.view];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:url requestParameters:@{@"id":self.shopID} requestHeader:nil success:^(id responseObject) {
        if (kCODE==200) {
            self.currentModel = [LDBookModel yy_modelWithJSON:responseObject[@"data"]];
            [self.tableView reloadData];
            [self addNouseView:self.currentModel.activeFlag];
            if ([self.currentModel.collectionFlag isEqualToString:@"Y"]) {
                self.footView.collectionButton.selected = YES;
            }else {
                self.footView.collectionButton.selected = !YES;
            }
        }
    } faild:^(NSError *error) {
        
    }];
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
- (void)collectionAction{
    if (self.shopID.length == 0) {
        return;
    }
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:@"collection/addanddelete" requestParameters:@{@"collectionId":self.shopID,@"collectionType":@"4"} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            [QMUITips showSucceed:responseObject[@"returnMsg"]];
            if ([self.currentModel.collectionFlag isEqualToString:@"N"]) {
                self.currentModel.collectionFlag = @"Y";
            } else {
                self.currentModel.collectionFlag = @"N";
            }
        }
    } faild:^(NSError *error) {
        
    }];
}
#pragma  mark - UI
- (void)masLayoutSubviews{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.cycleScrollView;
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
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(17);
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(17);
        } else {
            make.top.mas_equalTo(self.view).mas_offset(17);
        }
    }];
}
#pragma  mark - Touch Event
- (void)footerViewActions {
    [self.footView.collectionButton addTarget:self action:@selector(clickCollectionAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickCollectionAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self collectionAction];
}
- (void)pushToBuyVC{
    LDCommitBuyViewController *vc = [[LDCommitBuyViewController alloc]initWithNibName:@"LDCommitBuyViewController" bundle:[NSBundle mainBundle]];
    vc.currentModel = self.currentModel;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)clickBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            LDShoppingDetailNameViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDShoppingDetailNameViewCell" forIndexPath:indexPath];
            if (self.currentModel) {
                cell.nameLabel.text = self.currentModel.title;
                cell.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.currentModel.originalPrice];
                cell.salePriceLabel.text = [NSString stringWithFormat:@"¥%@",self.currentModel.discount];
            }
            return cell;
        }
            break;
        case 1:
        {
            LDShoppingTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDShoppingTitleCell" forIndexPath:indexPath];
            return cell;
        }
            break;
        default:
        {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                self.myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
                self.myWebView.delegate = self;
                [cell addSubview:self.myWebView];
                
            }
            if (self.currentModel && !isLoadData) {
                [self.myWebView loadHTMLString:self.currentModel.bookInfo baseURL:nil];
                isLoadData = YES;
            }
            return cell;
        }
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            return PtHeight(107);
        }
            break;
        case 1:
        {
            return PtHeight(40);
        }
            break;
            
        default:
        {
            return self.myWebView.qmui_height;
        }
            break;
    }
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGFloat height = [[self.myWebView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    self.myWebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    [self.tableView reloadData];
    [QMUITips hideAllTips];
}
#pragma mark - get and set
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        UIImage * placeholderImage = [UIImage imageNamed:@"seizeaseat_0"];
        CGRect frame = CGRectMake(0, kSTATUSBAR_HEIGHT, SCREEN_WIDTH, PtHeight(225));
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
        _cycleScrollView.imageURLStringsGroup = self.netImages;
        _cycleScrollView.showPageControl = YES;
        [_cycleScrollView setCornerRadius:10];
    }
    return _cycleScrollView;
}
-(NSArray *)netImages{
    
    if (!_netImages) {
        _netImages = @[
            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1569321432704&di=d65324c4864f2a08817b6a73b6b5caeb&imgtype=0&src=http%3A%2F%2Fwww.leawo.cn%2Fattachment%2F201404%2F16%2F1433365_1397624557Bz7w.jpg",
            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1569321432704&di=52224a01dded6315a23357c5bc9afd03&imgtype=0&src=http%3A%2F%2Fimg.mp.itc.cn%2Fupload%2F20160830%2Ffe779ac6f79d4fb2a8101fda35eb8bdd_th.jpg",
            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1569321432703&di=4130ed50a2fdac16ce5ee7c234a1bc7a&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F2018-12-14%2F5c1319ac76f03.jpg",
            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1569321462846&di=65658adbc9c571fc14e125c62d2a705c&imgtype=jpg&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D312440173%2C484202537%26fm%3D214%26gp%3D0.jpg"
        ];
    }
    return _netImages;
}
- (QMUITableView *)tableView {
    if (!_tableView) {
        _tableView = [[QMUITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, SCREEN_HEIGHT-kTABBAR_HEIGHT) style:UITableViewStylePlain];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"LDShoppingDetailNameViewCell" bundle:nil] forCellReuseIdentifier:@"LDShoppingDetailNameViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"LDShoppingTitleCell" bundle:nil] forCellReuseIdentifier:@"LDShoppingTitleCell"];
        //        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableView;
}
- (LDShoppingDetailFootView *)footView {
    if (!_footView) {
        _footView = [[NSBundle mainBundle]loadNibNamed:@"LDShoppingDetailFootView" owner:self options:nil].firstObject;
        [_footView.buyButton addTarget:self action:@selector(pushToBuyVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footView;
}
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"nav_black"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(clickBackAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
- (LDNoUseView *)noUseView {
    if (!_noUseView) {
        _noUseView = [[NSBundle mainBundle]loadNibNamed:@"LDNoUseView" owner:self options:nil].firstObject;
    }
    return _noUseView;
}
@end
