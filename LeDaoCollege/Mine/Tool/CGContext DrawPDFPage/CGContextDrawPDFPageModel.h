//
//  CGContextDrawPDFPageModel.h
//  PDFViewAndDownload
//
//  Created by Dustin on 17/4/6.
//  Copyright © 2017年 PicVision. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIPageViewController.h>

@class CGContextDrawPDFPageController;

@interface CGContextDrawPDFPageModel : NSObject <UIPageViewControllerDataSource>
{
    CGPDFDocumentRef pdfDocument;
}
@property (nonatomic,assign) NSInteger pageSum;

-(id) initWithPDFDocument:(CGPDFDocumentRef) pdfDocument;

- (CGContextDrawPDFPageController *)viewControllerAtIndex:(NSInteger)index;
- (NSUInteger)indexOfViewController:(CGContextDrawPDFPageController *)viewController;
@end
