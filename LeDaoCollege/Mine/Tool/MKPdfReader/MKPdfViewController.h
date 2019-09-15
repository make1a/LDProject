//
//  MKPdfViewController.h
//  LeDaoCollege
//
//  Created by make on 2019/9/14.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKPdfDocumentManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKPdfViewController : UIViewController

/**
 当前页数
 */
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong,nonnull)MKPdfDocumentManager * pdfInfo;

- (instancetype)initWithDocumentManager:(MKPdfDocumentManager *)doc currentPage:(NSInteger)currentPage;

- (void)scrollToNormal;
@end

NS_ASSUME_NONNULL_END
