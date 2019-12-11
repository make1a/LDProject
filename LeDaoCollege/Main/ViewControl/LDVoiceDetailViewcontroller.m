//
//  LDVoiceDetailViewcontroller.m
//  LeDaoCollege
//
//  Created by Make on 2019/12/11.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDVoiceDetailViewcontroller.h"
@interface LDVoiceDetailViewcontroller()
@property (nonatomic,strong)UIImageView * bigImageView;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * timeLabel;

@end
@implementation LDVoiceDetailViewcontroller
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad{
    [super viewDidLoad];
}


#pragma  mark - GET SET

@end
