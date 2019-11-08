//
//  LDCustomHistoryCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/24.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDCustomModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LDCustomHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *decsLabel;

- (void)refreshWith:(LDCustomLogModel*)model;
@end

NS_ASSUME_NONNULL_END
