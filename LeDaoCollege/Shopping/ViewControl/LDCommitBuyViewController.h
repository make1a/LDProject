//
//  LDCommitBuyViewController.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/23.
//  Copyright © 2019 Make. All rights reserved.
//

#import "QMUICommonViewController.h"
#import "LDStoreModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LDCommitBuyViewController : QMUICommonViewController
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (nonatomic,strong)LDBookModel * currentModel;
@end

NS_ASSUME_NONNULL_END
