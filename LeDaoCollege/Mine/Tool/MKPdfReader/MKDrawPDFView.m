//
//  MKDrawPDFView.m
//  LeDaoCollege
//
//  Created by make on 2019/9/14.
//  Copyright © 2019 Make. All rights reserved.
//

#import "MKDrawPDFView.h"

@implementation MKDrawPDFView
- (instancetype)initWithFrame:(CGRect)frame andDoc:(CGPDFDocumentRef)document pageNo:(NSInteger)pageNo
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pdfDocument = document;
        self.pageNO = pageNo;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawInContext:UIGraphicsGetCurrentContext()];
}

-(void)drawInContext:(CGContextRef)context {
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    if (self.pageNO == 0) {
        self.pageNO = 1;
    }

    CGPDFPageRef page = CGPDFDocumentGetPage(self.pdfDocument, self.pageNO);
    CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(page, kCGPDFCropBox, self.bounds, 0, true);
    CGContextConcatCTM(context, pdfTransform);
    CGContextDrawPDFPage(context, page);
}

@end
