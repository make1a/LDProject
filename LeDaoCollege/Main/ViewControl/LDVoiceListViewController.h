//
//  LDVoiceListViewController.h
//  LeDaoCollege
//
//  Created by make on 2019/12/8.
//  Copyright © 2019 Make. All rights reserved.
//

#import "QMUICommonTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDVoiceListViewController : QMUICommonTableViewController
@property (nonatomic,strong)NSArray * dataSource;
@property (nonatomic,strong)NSArray * netImages;
@property (nonatomic,assign)BOOL isSearchModel;
- (void)requestSource:(NSString *)title mark:(NSString *)mark back:(backSourceCountBlock)blcok;
@end

NS_ASSUME_NONNULL_END
