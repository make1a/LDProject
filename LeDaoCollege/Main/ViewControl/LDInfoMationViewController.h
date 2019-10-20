//
//  LDInfoMationViewController.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/5.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LDInfoMationViewController : QMUICommonViewController

/**
  作为搜索界面复用标示
 */
@property (nonatomic,assign)BOOL isSearchModel;

@property (nonatomic,strong)QMUITableView * tableView;

- (void)requestSource:(NSString *)title;
@end
