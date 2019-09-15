//
//  MKReaderViewController.h
//  LeDaoCollege
//
//  Created by make on 2019/9/13.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKPdfDocumentManager;
NS_ASSUME_NONNULL_BEGIN

@interface MKReaderViewController : UIViewController
@property (nonatomic,strong)MKPdfDocumentManager * pdfInfo;
@end

NS_ASSUME_NONNULL_END
