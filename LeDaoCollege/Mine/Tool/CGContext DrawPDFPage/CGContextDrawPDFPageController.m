//
//  CGContextDrawPDFPageController.m
//  PDFViewAndDownload
//
//  Created by Dustin on 17/4/6.
//  Copyright © 2017年 PicVision. All rights reserved.
//

#import "CGContextDrawPDFPageController.h"
#import "CGContextDrawPDFView.h"

@interface CGContextDrawPDFPageController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)CGContextDrawPDFView * pdfView;
@end

@implementation CGContextDrawPDFPageController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
}
- (void)creatUI{
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    CGContextDrawPDFView *pdfView = [[CGContextDrawPDFView alloc] initWithFrame:frame atPage:self.pageNO withPDFDoc:self.pdfDocument];
    pdfView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:pdfView];
    _pdfView = pdfView;
    _weakself;
    pdfView.touchBeginBlock = ^(NSInteger tagCount) {
        if (tagCount == 1) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"kNotificationShowBar" object:nil];
        }else if (tagCount == 2){
            [weakself.scrollView setZoomScale:1.0 animated:YES];
        }
    };
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _pdfView;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    _pdfView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,scrollView.contentSize.height * 0.5 + offsetY);
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 2.0;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.bouncesZoom = YES;
    }
    return _scrollView;
}
@end
