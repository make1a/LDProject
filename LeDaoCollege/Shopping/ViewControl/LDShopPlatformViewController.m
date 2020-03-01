//
//  LDShopPlatformViewController.m
//  LeDaoCollege
//
//  Created by make on 2020/2/19.
//  Copyright © 2020 Make. All rights reserved.
//

#import "LDShopPlatformViewController.h"

@interface LDShopPlatformViewController ()

@end

@implementation LDShopPlatformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.emptyView = [[NSBundle mainBundle]loadNibNamed:@"LDEmptyViewXIB" owner:self options:nil].firstObject;
    self.emptyView.frame = self.view.bounds;
    [self showEmptyView];
}
- (void)updateType{
    type = 5;
}
- (void)requestAllStore{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
