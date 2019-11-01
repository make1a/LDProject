//
//  LDSmallClassViewController.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/20.
//  Copyright © 2019 Make. All rights reserved.
//

#import "QMUICommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDSmallClassViewController : QMUICommonTableViewController
@property (nonatomic,assign)BOOL isSearchModel;
@property (nonatomic,strong)NSArray * dataSource;

- (void)requestSource:(NSString *)title back:(backSourceCountBlock)blcok;
@end

NS_ASSUME_NONNULL_END
