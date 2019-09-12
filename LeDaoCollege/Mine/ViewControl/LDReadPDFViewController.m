//
//  LDReadPDFViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/12.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDReadPDFViewController.h"

@interface LDReadPDFViewController ()

@end

@implementation LDReadPDFViewController
#pragma mark - life cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showBar) name:@"kNotificationShowBar" object:nil];
    [self viewDidLayoutSubviews];
}

#pragma mark - event response


#pragma mark - private method
- (void)showBar{
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
//    self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;
}
#pragma mark - get and set

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
