//
//  LDVideoDetailViewController.h
//  LeDaoCollege
//
//  Created by Make on 2019/12/13.
//  Copyright © 2019 Make. All rights reserved.
//

#import "QMUICommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDVideoDetailViewController : QMUICommonViewController
@property (nonatomic,copy)NSString * videoID;
@property (nonatomic,assign)BOOL isSmallClass;
@property (nonatomic,copy)NSString * collectionType;
- (void)reload;
@end

NS_ASSUME_NONNULL_END
