//
//  MKDrawPDFView.h
//  LeDaoCollege
//
//  Created by make on 2019/9/14.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKDrawPDFView : UIView
@property (nonatomic,assign)NSInteger pageNO;
@property (nonatomic,assign)CGPDFDocumentRef pdfDocument;

- (instancetype)initWithFrame:(CGRect)frame andDoc:(CGPDFDocumentRef)document pageNo:(NSInteger)pageNo;
@end

NS_ASSUME_NONNULL_END
