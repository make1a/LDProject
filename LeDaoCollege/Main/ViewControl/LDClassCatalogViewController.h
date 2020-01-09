//
//  LDClassCatalogViewController.h
//  LeDaoCollege
//
//  Created by Make on 2020/1/8.
//  Copyright © 2020 Make. All rights reserved.
//

#import "QMUICommonTableViewController.h"
#import "LDClassModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LDClassCatalogViewController : QMUICommonTableViewController
@property (nonatomic,strong) LDClassModel* currenModel;
@property (nonatomic,copy)void (^didSelectBlock)(NSIndexPath *indexPath);
@property (nonatomic,assign)NSInteger currentIndex;
@end

NS_ASSUME_NONNULL_END
