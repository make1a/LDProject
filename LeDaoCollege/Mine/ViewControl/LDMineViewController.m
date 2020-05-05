//
//  LDMineViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDMineViewController.h"
#import "LDNormalTableViewCell.h"
#import "LDCustomerManagerViewController.h"
#import "LDConfigTableViewController.h"
#import "LDCollectViewController.h"
#import "LDFinishOrderViewController.h"
#import "LDShoppingCartViewController.h"
#import "LDBookRackViewController.h"
#import "LDMineCustomHead.h"
#import "LDScoreViewController.h"
#import "LDCustomManagerListViewController.h"
#import "LDMyIconViewController.h"
#import "LDCollegeViewController.h"

@interface LDMineViewController () <QMUITableViewDelegate,QMUITableViewDataSource>
{
    BOOL _iscompanymember;
}
@property (nonatomic,strong)QMUITableView * tableView;
@property (nonatomic,strong)NSMutableArray * titlesArray;
@property (nonatomic,strong)NSMutableArray * imagesArray;
@property (nonatomic,strong)LDMineCustomHead * headView;
@end

@implementation LDMineViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self refreshView];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self masLayoutSubviews];
    [self requestScore];
}
- (void)masLayoutSubviews{
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
    
    self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.headView.headHeight.constant);
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.headView.mas_bottom);
    }];
}
- (BOOL)prefersStatusBarHidden {
    return NO;
}
- (void)refreshView{
    [self.headView.headImageView sd_setImageWithURL:[NSURL URLWithString:[LDUserManager shareInstance].currentUser.headImgUrl]
                                   placeholderImage:[UIImage imageNamed:@"mine_headportrait_default"]];
    self.headView.nameLabel.text = [LDUserManager shareInstance].currentUser.userName;

}
- (void)requestScore{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:@"poins/getmypoinsleval" requestParameters:@{} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
           NSString *point = responseObject[@"data"][@"poins"];
           NSString *level = responseObject[@"data"][@"levalDesc"];
            self.headView.levelLabel.text = [NSString stringWithFormat:@"%@",level];
            self.headView.scoreLabel.text = [NSString stringWithFormat:@"%@",point];
           NSString *iscompanymember = responseObject[@"data"][@"iscompanymember"];
            self->_iscompanymember = [iscompanymember isEqualToString:@"Y"]?YES:NO;
            if (!self->_iscompanymember) {
                [self.imagesArray[0] removeObjectAtIndex:1];
                [self.titlesArray[0] removeObjectAtIndex:1];
            }
            [self.tableView reloadData];
        }
    } faild:^(NSError *error) {
        
    }];
}
#pragma  mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  self.titlesArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.titlesArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LDNormalTableViewCell *cell = [LDNormalTableViewCell dequeueReusableWithTableView:tableView];
    cell.imageView.image = [UIImage imageNamed:self.imagesArray[indexPath.section][indexPath.row]];
    cell.textLabel.text = self.titlesArray[indexPath.section][indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        LDConfigTableViewController *vc = [[LDConfigTableViewController alloc]initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (_iscompanymember) {
    switch (indexPath.row) {
            case 0:
        {
            LDCollegeViewController *vc = [LDCollegeViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            LDCustomManagerListViewController *vc = [LDCustomManagerListViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            LDCollectViewController *vc = [LDCollectViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            LDFinishOrderViewController *vc = [LDFinishOrderViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
//        case 3:
//        {
//            LDShoppingCartViewController *vc = [LDShoppingCartViewController new];
//            [self.navigationController pushViewController:vc animated:YES];
//
//        }
            break;
        case 4:
        {
            LDBookRackViewController *vc = [LDBookRackViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            LDScoreViewController *vc = [LDScoreViewController new];
            vc.allScore = self.headView.scoreLabel.text;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
            LDMyIconViewController *vc = [[LDMyIconViewController alloc]initWithNibName:@"LDMyIconViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
    }else{
         switch (indexPath.row) {
                    case 0:
                {
                    LDCollegeViewController *vc = [LDCollegeViewController new];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1:
                {
                    LDCollectViewController *vc = [LDCollectViewController new];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 2:
                {
                    LDFinishOrderViewController *vc = [LDFinishOrderViewController new];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
        //        case 3:
        //        {
        //            LDShoppingCartViewController *vc = [LDShoppingCartViewController new];
        //            [self.navigationController pushViewController:vc animated:YES];
        //
        //        }
                    break;
                case 3:
                {
                    LDBookRackViewController *vc = [LDBookRackViewController new];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 4:
                {
                    LDScoreViewController *vc = [LDScoreViewController new];
                    vc.allScore = self.headView.scoreLabel.text;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 5:
                {
                    LDMyIconViewController *vc = [[LDMyIconViewController alloc]initWithNibName:@"LDMyIconViewController" bundle:nil];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                default:
                    break;
            }
    }
}
#pragma  mark - GET && SET
- (QMUITableView *)tableView {
    if (!_tableView) {
        _tableView = [[QMUITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _tableView;
}
- (NSMutableArray *)titlesArray {
    if (!_titlesArray) {
        _titlesArray = @[@[@"我的大学",@"我的管理",@"我的收藏",@"我的订单",@"我的智库",@"我的积分",@"我的乐币"].mutableCopy,@[@"设置"].mutableCopy].mutableCopy;
    }
    return _titlesArray;
}
- (NSMutableArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = @[@[@"nav_button_xueyuan_pre2",@"mine_manage_list",@"mine_collect_list",@"mine_list_daily",@"mine_shoppingcart_list",@"mine_integral_list",@"mine_coin_list"].mutableCopy,@[@"mine_set_list"].mutableCopy].mutableCopy;
    }
    return _imagesArray;
}
- (LDMineCustomHead *)headView {
    if (!_headView) {
        _headView = [[NSBundle mainBundle]loadNibNamed:@"LDMineCustomHead" owner:self options:nil].firstObject;
    }
    return _headView;
}
@end
