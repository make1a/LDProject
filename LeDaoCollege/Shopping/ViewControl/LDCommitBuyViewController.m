//
//  LDCommitBuyViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/23.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDCommitBuyViewController.h"

@interface LDCommitBuyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *salePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UILabel *bigPayLabel;

@end

@implementation LDCommitBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI {
    self.salePriceLabel.textColor = UIColorFromHEXA(0xFF0B0B, 1.0);
    self.payLabel.textColor = UIColorFromHEXA(0xFF0B0B, 1.0);
    self.bigPayLabel.textColor = UIColorFromHEXA(0xFF0B0B, 1.0);

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
