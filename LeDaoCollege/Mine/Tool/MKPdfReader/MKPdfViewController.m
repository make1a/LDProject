//
//  MKPdfViewController.m
//  LeDaoCollege
//
//  Created by make on 2019/9/14.
//  Copyright © 2019 Make. All rights reserved.
//

#import "MKPdfViewController.h"
#import "MKDrawPDFView.h"

@interface MKPdfViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)MKDrawPDFView * pdfView;

@end

@implementation MKPdfViewController

- (instancetype)initWithDocumentManager:(MKPdfDocumentManager *)doc currentPage:(NSInteger)currentPage
{
    self = [super init];
    if (self) {
        self.pdfInfo = doc;
        self.pageIndex = currentPage;
        [self.view addSubview:self.scrollView];
        [self creatPDFViewWith:doc andPageNo:currentPage];
    }
    return self;
}
- (void)creatPDFViewWith:(MKPdfDocumentManager *)doc andPageNo:(NSInteger)currentPage{
    MKDrawPDFView *pdfView = [[MKDrawPDFView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andDoc:doc.pdfDocument pageNo:currentPage];
    [self.scrollView addSubview:pdfView];
    self.pdfView = pdfView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)scrollToNormal {
    [self.scrollView setZoomScale:1.0 animated:YES];
}
#pragma  mark - Private

#pragma  mark - UIScrollView Delegate
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
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 2.0;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.bouncesZoom = YES;
    }
    return _scrollView;
}
@end
