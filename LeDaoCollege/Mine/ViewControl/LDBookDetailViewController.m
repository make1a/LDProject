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
{
    BOOL _isUpdate;
}
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong)LDBookModel * currentModel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation LDBookDetailViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestDataSource];
    [self.backButton setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    UISwipeGestureRecognizer * recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:recognizer];
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self readww];
    }
}
- (IBAction)readAction:(id)sender {
    [self readww];
}

- (void)requestDataSource{
    NSString *url = [NSString stringWithFormat:@"book/book/%@",self.bookID];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypeGET requestAPI:url requestParameters:@{@"id":self.bookID} requestHeader:nil success:^(id responseObject) {
        if (kCODE == 200) {
            self.currentModel = [LDBookModel yy_modelWithJSON:responseObject[@"data"]];
            self.descLabel.text = self.currentModel.briefIntroduction;
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@img/%@",BaseAPI,self.currentModel.coverImg]]];
            
        }
    } faild:^(NSError *error) {
        
    }];
}
- (void)updateBook{
    NSString *url = [NSString stringWithFormat:@"/book/updateIsChange/%@",self.bookID];
    [MKRequestManager sendRequestWithMethodType:MKRequestMethodTypePOST requestAPI:url  requestParameters:nil requestHeader:nil success:^(id responseObject) {
        self.currentModel.isChange = @"N";
    } faild:^(NSError *error) {
        
    }];
}
- (void)readww{
   __block  MKPdfDocumentManager *doc = [MKPdfDocumentManager getToLocalWith:self.bookID];
        if (!doc || [self.currentModel.isChange isEqualToString:@"Y"]) {

            [MKRequestManager loadFileWith:self.currentModel.bookUrl progress:^(id responseObject) {
                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                    [QMUITips showWithText:[NSString stringWithFormat:@"下载中...%@%%",responseObject]];
                }];
            } fileName:self.bookID success:^(id responseObject) {
                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                    [QMUITips hideAllTips];
                }];
                doc = [[MKPdfDocumentManager alloc]initWithUrl:responseObject name:self.bookID];
                if (doc.pdfDocument == nil) {
                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                        [QMUITips showError:@"PDF为空"];
                    }];
                    return;
                }
                [doc saveToPlist];
                [self updateBook];
                MKReaderViewController *vc = [[MKReaderViewController alloc]init];
                vc.pdfInfo = doc;
                vc.modalPresentationStyle = 0;
                [self presentViewController:vc animated:YES completion:nil];
                
            } faild:^(NSError *error) {
                [QMUITips showError:error.localizedDescription];
            }];
            
        }else {
            MKReaderViewController *vc = [[MKReaderViewController alloc]init];
            vc.pdfInfo = doc;
            vc.modalPresentationStyle = 0;
            [self presentViewController:vc animated:YES completion:nil];
        }

    
}

@end
