//
//  LDSmallClassDetailIntroCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/23.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDClassModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LDSmallClassDetailIntroCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)refreshWith:(LDClassModel *)model;
@end

NS_ASSUME_NONNULL_END
