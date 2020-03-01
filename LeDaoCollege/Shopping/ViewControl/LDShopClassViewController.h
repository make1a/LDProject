//
//  LDShopClassViewController.h
//  LeDaoCollege
//
//  Created by make on 2020/2/19.
//  Copyright © 2020 Make. All rights reserved.
//

#import "QMUICommonTableViewController.h"
#import "LDStoreModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LDShopClassViewController : QMUICommonTableViewController<JXPagerViewListViewDelegate>
{
    NSInteger type;
}
@property (nonatomic,assign)BOOL isSearchModel;
@property (nonatomic,strong)NSArray * dataSource;

- (void)updateType;
- (void)requestSource:(NSString *)title back:(backSourceCountBlock __nullable)blcok;
@end

NS_ASSUME_NONNULL_END
