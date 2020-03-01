//
//  LDBookDicViewController.h
//  LeDaoCollege
//
//  Created by make on 2020/2/15.
//  Copyright © 2020 Make. All rights reserved.
//

#import "QMUICommonTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDBookDicViewController : QMUICommonTableViewController
@property (nonatomic,strong)NSArray * netImages;
@property (nonatomic,assign)BOOL isSearchModel;
@property (nonatomic,strong)NSArray * dataSource;

- (void)requestSource:(NSString *)title mark:(NSString *)mark back:(backSourceCountBlock)blcok;
@end

NS_ASSUME_NONNULL_END
