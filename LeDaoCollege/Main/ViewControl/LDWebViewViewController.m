//
//  LDWebViewViewController.m
//  LeDaoCollege
//
//  Created by make on 2019/11/3.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDWebViewViewController.h"
#import <UMShare/UMShare.h>
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
    
    NSMutableArray *array = @[].mutableCopy;
    
   QMUIMoreOperationItemView *wx = [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"wechat") title:@"分享给微信好友" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
        [self share:UMSocialPlatformType_WechatSession];
        [moreOperationController hideToBottom];
    }];
   QMUIMoreOperationItemView *wxp = [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"pyq") title:@"分享到朋友圈" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
        [self share:UMSocialPlatformType_WechatTimeLine];
        [moreOperationController hideToBottom];
    }];
   QMUIMoreOperationItemView *sina = [QMUIMoreOperationItemView itemViewWithImage:UIImageMake(@"weibo") title:@"分享到微博" handler:^(QMUIMoreOperationController *moreOperationController, QMUIMoreOperationItemView *itemView) {
        [self share:UMSocialPlatformType_Sina];
        [moreOperationController hideToBottom];
    }];
    if ([[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatSession]) {
        [array addObject:wx];
        [array addObject:wxp];
    }
    if ([[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_Sina]) {
        [array addObject:sina];
    }
    moreOperationController.items = @[array];
    [moreOperationController showFromBottom];
}
- (void)share:(UMSocialPlatformType)shareType{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UIImage *image = [UIImage imageNamed:@"ledao_logo_2"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"乐道分享" descr:nil thumImage:image];
    //设置网页地址
    shareObject.webpageUrl = self.urlStrng;
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:shareType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
            NSLog(@"%@",data);
        }
    }];
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
