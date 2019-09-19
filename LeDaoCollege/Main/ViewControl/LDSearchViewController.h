//
//  LDSearchViewController.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/6.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VTMagic/VTMagic.h>

@interface LDSearchViewController : QMUICommonViewController <UISearchBarDelegate,VTMagicViewDelegate,VTMagicViewDataSource>

- (NSArray *)menueBarTitles;
@end
