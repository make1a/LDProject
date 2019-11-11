//
//  LDSmallClassSectionDetailViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/11/11.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDSmallClassSectionDetailViewController.h"

@interface LDSmallClassSectionDetailViewController ()
@property (nonatomic,strong)UIWebView * webView;
@end

@implementation LDSmallClassSectionDetailViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
}

#pragma  mark - GET SET
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.allowsInlineMediaPlayback = YES;
        _webView.mediaPlaybackRequiresUserAction = NO;
        [_webView loadHTMLString:self.urlStrng baseURL:nil];
    }
    return _webView;
}
@end
