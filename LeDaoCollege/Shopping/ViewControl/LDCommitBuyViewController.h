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
@property (nonatomic,copy)NSString * goodsType;  //商品类型（1 音频  2 视频  3 书籍  4 微课）
@property (nonatomic,copy)NSString * goodsId;

@end

NS_ASSUME_NONNULL_END
