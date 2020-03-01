//
//  LDBookListViewController.h
//  LeDaoCollege
//
//  Created by make on 2020/2/28.
//  Copyright © 2020 Make. All rights reserved.
//

#import "QMUICommonTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDBookListViewController : QMUICommonTableViewController
@property (nonatomic,strong)NSArray* dataSource;
@property (nonatomic,assign)NSInteger type;
@end

NS_ASSUME_NONNULL_END
