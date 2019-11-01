//
//  LDSearchViewController.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/6.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VTMagic/VTMagic.h>
#import "LDSearchHistoryView.h"
#import "LDNoticeView.h"

@interface LDSearchViewController : QMUICommonViewController <UISearchBarDelegate,VTMagicViewDelegate,VTMagicViewDataSource>
@property (nonatomic,strong)LDSearchHistoryView * historyView;
@property (nonatomic,copy)NSString *searchTitle;

@property (strong, nonatomic) LDNoticeView *noticeView;
@property(nonatomic, strong) QMUISearchBar *searchBar;
@property (nonatomic, strong)VTMagicController *magicController;

@property (nonatomic,strong)NSArray * menueBarTitles;
- (NSArray *)menueBarTitles;
@end
