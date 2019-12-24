//
//  LDVideoDetailContenViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/12/14.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDVideoDetailContenViewController.h"
#import "LDShoppingDetailNameViewCell.h"
#import "LDVideoModel.h"

@interface LDVideoDetailContenViewController ()<QMUITableViewDelegate,QMUITableViewDataSource,UIWebViewDelegate>
{
    BOOL isLoadData;
}
@property (nonatomic,strong)UIWebView * myWebView;
@end

@implementation LDVideoDetailContenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    
}
- (void)configTableView{
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    [self.tableView registerNib:[UINib nibWithNibName:@"LDShoppingDetailNameViewCell" bundle:nil] forCellReuseIdentifier:@"LDShoppingDetailNameViewCell"];
    [self.tableView reloadData];
}

#pragma  mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        LDShoppingDetailNameViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LDShoppingDetailNameViewCell" forIndexPath:indexPath];
        if (self.currentModel) {
            cell.nameLabel.text = self.currentModel.title;
            cell.priceLabel.text = [NSString stringWithFormat:@"%@",self.currentModel.originalPrice];
            cell.salePriceLabel.text = [NSString stringWithFormat:@"%@",self.currentModel.discount];
            cell.watchLabel.text = [NSString stringWithFormat:@"%@人已看",self.currentModel.numOfVisiter];
        }
        return cell;
    } else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            self.myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
            self.myWebView.delegate = self;
            self.myWebView.backgroundColor = [UIColor whiteColor];
            [cell addSubview:self.myWebView];
            
        }
        if (self.currentModel && !isLoadData) {
            [self.myWebView loadHTMLString:self.currentModel.briefIntroduction baseURL:nil];
            isLoadData = YES;
        }
        return cell;
    }
    return nil;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return PtHeight(107);
    }else{
        return self.myWebView.qmui_height;
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGFloat height = [[self.myWebView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    self.myWebView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    [self.tableView reloadData];
    [QMUITips hideAllTips];
}
@end
