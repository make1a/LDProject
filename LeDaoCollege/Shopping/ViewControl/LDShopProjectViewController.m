//
//  LDShopProjectViewController.m
//  LeDaoCollege
//
//  Created by make on 2020/2/19.
//  Copyright © 2020 Make. All rights reserved.
//

#import "LDShopProjectViewController.h"

@interface LDShopProjectViewController ()

@end

@implementation LDShopProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)updateType{
    type = 2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    LDNewsModel *model = self.dataSource[indexPath.row];
//    LDWebViewViewController * vc = [LDWebViewViewController new];
//    vc.urlStrng = [NSString stringWithFormat:@"%@?id=%@&token=%@",model.contentUrl,model.newsId,[LDUserManager userID]];
//    vc.s_id = model.newsId;
//    vc.isCollection = [model.collectionFlag isEqualToString:@"Y"]?YES:NO;
//    vc.collectionType = @"1";
//    vc.title = model.title;
//    vc.didRefreshCollectionStateBlock = ^(BOOL isCollection) {
//        model.collectionFlag = isCollection?@"Y":@"N";
//    };
//    [self.navigationController pushViewController:vc animated:YES];
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
