//
//  LDEmptyViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/24.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDEmptyViewController.h"

@interface LDEmptyViewController ()

@end

@implementation LDEmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emptyView = [[NSBundle mainBundle]loadNibNamed:@"LDEmptyViewXIB" owner:self options:nil].firstObject;
    [self showEmptyView];
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
