//
//  LDStoreViewController.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDShoppingHeadView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LDStoreViewController : QMUICommonViewController
@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic, strong)VTMagicController *magicController;
@property (nonatomic,strong)LDShoppingHeadView * headView;
@end

NS_ASSUME_NONNULL_END
