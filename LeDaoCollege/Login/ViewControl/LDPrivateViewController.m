//
//  LDPrivateViewController.m
//  LeDaoCollege
//
//  Created by make on 2020/2/8.
//  Copyright © 2020 Make. All rights reserved.
//

#import "LDPrivateViewController.h"

@interface LDPrivateViewController ()

@end

@implementation LDPrivateViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐私政策条款";
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:@"https://ledao.ledozx.com/privacy/privacy.html"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
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
