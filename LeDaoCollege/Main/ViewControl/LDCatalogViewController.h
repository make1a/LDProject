//
//  LDCatalogViewController.h
//  LeDaoCollege
//
//  Created by Make on 2019/12/14.
//  Copyright © 2019 Make. All rights reserved.
//

#import "QMUICommonTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDCatalogViewController : QMUICommonTableViewController
@property (nonatomic,strong)NSArray * dataSource;
@property (nonatomic,copy)void (^didSelectBlock)(NSInteger row);
@property (nonatomic,assign)NSInteger currentIndex;

@end

NS_ASSUME_NONNULL_END
