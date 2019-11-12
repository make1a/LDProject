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
    [self.webView reload];

    QMUINavigationButton *button = [QMUINavigationButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"collect_default"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"collect_sele"] forState:UIControlStateSelected];
    
    UIBarButtonItem *collectionButton = [UIBarButtonItem qmui_itemWithButton:button target:self action:@selector(clickCollectionAction:)];
    UIBarButtonItem *shareButton = [UIBarButtonItem qmui_itemWithImage:[UIImage imageNamed:@"share_default"] target:self action:@selector(clickShareAction)];
    self.navigationItem.rightBarButtonItems = @[shareButton,collectionButton];
    
    if (self.isCollection) {
        button.selected = YES;
    }
}
- (void)clickShareAction{
    QMUIMoreOperationController *moreOperationController = [[QMUIMoreOperationController alloc] init];
    moreOperationController.items = @[
        // 第一行
        @[
            [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"wechat") title:@"分享给微信好友" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
                [moreOperationController hideToBottom];
            }],
            [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"icon_moreOperation_shareMoment") title:@"分享到朋友圈" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
                [moreOperationController hideToBottom];
            }],
            [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"icon_moreOperation_shareWeibo") title:@"分享到微博" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
                [moreOperationController hideToBottom];
            }],
            
            [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"icon_moreOperation_shareChat") title:@"分享到私信" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
                [moreOperationController hideToBottom];
            }]
        ],
    ];
    [moreOperationController showFromBottom];
}
- (void)clickCollectionAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    [self requestCollection:self.s_id collection:sender.selected];
}

#pragma  mark - Request
- (void)requestCollection:(NSString *)collectionID collection:(BOOL)isCollection{
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:@"collection/addanddelete" requestParameters:@{@"collectionId":collectionID,@"collectionType":self.collectionType} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            [QMUITips showSucceed:responseObject[@"returnMsg"]];
            if (isCollection && self.didRefreshCollectionStateBlock) {
                self.didRefreshCollectionStateBlock(isCollection);
            }
        }
    } faild:^(NSError *error) {

    }];
}
#pragma  mark - GET SET
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStrng]];
        [_webView loadRequest:request];
    }
    return _webView;
}
@end
