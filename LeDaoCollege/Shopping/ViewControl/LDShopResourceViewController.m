//
//  LDShopResourceViewController.m
//  LeDaoCollege
//
//  Created by make on 2020/2/19.
//  Copyright © 2020 Make. All rights reserved.
//

#import "LDShopResourceViewController.h"
#import "LDShoppingDetailViewController.h"

@interface LDShopResourceViewController ()

@end

@implementation LDShopResourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)updateType{
    type = 6;
}
- (void)requestAllStore{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LDShoppingDetailViewController *vc = [LDShoppingDetailViewController new];
    LDStoreModel *model = self.dataSource[indexPath.row];
    vc.shopID = model.s_id;
    vc.collectionType = @"5";
    [self.navigationController pushViewController:vc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
