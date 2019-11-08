//
//  LDBookDetailViewController.m
//  LeDaoCollege
//
//  Created by Make on 2019/11/7.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDBookDetailViewController.h"
#import "LDStoreModel.h"
#import "MKPdfDocumentManager.h"
#import "MKReaderViewController.h"
@interface LDBookDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong)LDBookModel * currentModel;
@end

@implementation LDBookDetailViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestDataSource];
}

- (void)requestDataSource{
    self.bookID = @"1";
    NSString *url = [NSString stringWithFormat:@"book/book/%@",self.bookID];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:url requestParameters:@{@"id":self.bookID} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.currentModel = [LDBookModel yy_modelWithJSON:responseObject[@"data"]];
            self.descLabel.text = self.currentModel.title;
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@img/%@",BaseAPI,self.currentModel.coverImg]]];
            
        }
    } faild:^(NSError *error) {
        
    }];
}

- (void)readww{
   __block  MKPdfDocumentManager *doc = [MKPdfDocumentManager getToLocalWith:self.bookID];
        if (!doc) {
            [MKRequestManager loadFileWith:self.currentModel.bookUrl progress:^(id responseObject) {
                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                    [QMUITips showWithText:[NSString stringWithFormat:@"下载中...%@%%",responseObject]];
                }];
            } fileName:self.bookID success:^(id responseObject) {
                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                    [QMUITips hideAllTips];
                }];
                doc = [[MKPdfDocumentManager alloc]initWithUrl:responseObject];
                doc.name = self.bookID;
                MKReaderViewController *vc = [[MKReaderViewController alloc]init];
                vc.pdfInfo = doc;
                vc.modalPresentationStyle = 0;
                [self presentViewController:vc animated:YES completion:nil];
                
            } faild:^(NSError *error) {
                
            }];

        }else {
            MKReaderViewController *vc = [[MKReaderViewController alloc]init];
            vc.pdfInfo = doc;
            vc.modalPresentationStyle = 0;
            [self presentViewController:vc animated:YES completion:nil];
        }

    
}
//    MKPdfDocumentManager *doc = [MKPdfDocumentManager getToLocalWith:@"Reader"];
//    if (!doc) {
//        NSString *path = [[NSBundle mainBundle]pathForResource:@"Reader" ofType:@"pdf"];
//        NSURL *url = [NSURL fileURLWithPath:path];
//        doc = [[MKPdfDocumentManager alloc]initWithUrl:url];
//        doc.name = @"Reader";
//    }
//    MKReaderViewController *vc = [[MKReaderViewController alloc]init];
//    vc.pdfInfo = doc;
//    vc.modalPresentationStyle = 0;
//    [self presentViewController:vc animated:YES completion:nil];
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self readww];
}
@end
