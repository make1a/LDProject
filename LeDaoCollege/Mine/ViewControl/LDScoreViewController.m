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
@interface LDScoreViewController ()<QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic,strong)LDScoreView * headView;
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
    if (iPhoneX) {
        self.tableView.contentInset = UIEdgeInsetsMake(-kSTATUSBAR_HEIGHT, 0, 0, 0);
    }
}
#pragma mark - event response
- (void)clickBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - QMUITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LDScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDScoreCell" forIndexPath:indexPath];
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
