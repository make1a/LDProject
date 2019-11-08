//
//  LDScoreViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/17.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDScoreViewController.h"
#import "LDScoreCell.h"
#import "LDScoreView.h"
#import "LDScoreModel.h"
@interface LDScoreViewController ()<QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic,strong)LDScoreView * headView;
@property (nonatomic,strong)NSArray * dataSource;
@end

@implementation LDScoreViewController
#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self regiseterCell];
    [self addTableHeader];
    [self requestDataSource];
    if (iPhoneX) {
        self.tableView.contentInset = UIEdgeInsetsMake(-kSTATUSBAR_HEIGHT, 0, 0, 0);
    }
}

- (void)requestDataSource {
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"poins/getmyPoins" requestParameters:nil requestHeader:nil success:^(id responseObject) {
        if (kCODE) {
            self.dataSource = [NSArray yy_modelArrayWithClass:[LDScoreModel class] json:responseObject[@"data"][@"poinsList"]];
            [self.tableView reloadData];
            self.headView.scoreLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"totalPoins"]];
        }
    } faild:^(NSError *error) {
        
    }];
}
#pragma mark - event response
- (void)clickBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - QMUITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LDScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDScoreCell" forIndexPath:indexPath];
    LDScoreModel *model = self.dataSource[indexPath.row];
    [cell refreshView:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}
#pragma mark - private method
- (void)regiseterCell {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"LDScoreCell" bundle:nil] forCellReuseIdentifier:@"LDScoreCell"];
}
- (void)addTableHeader{
    self.tableView.tableHeaderView = self.headView;
}
#pragma mark - get and set
- (LDScoreView *)headView {
    if (!_headView) {
        _headView = [[NSBundle mainBundle]loadNibNamed:@"LDScoreViewXib" owner:self options:nil].firstObject;
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, PtHeight(225));
        [_headView.backButton addTarget:self action:@selector(clickBackAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
