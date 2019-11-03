//
//  LDWebViewViewController.m
//  LeDaoCollege
//
//  Created by make on 2019/11/3.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDWebViewViewController.h"

@interface LDWebViewViewController ()
@property (nonatomic,strong)UIWebView * webView;
@end

@implementation LDWebViewViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
}

- (UIWebView *)webView {
    if (_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStrng]];
        [_webView loadRequest:request];
    }
    return _webView;
}
@end
