//
//  LDRechargeCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/26.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDChargeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LDRechargeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *rmbLabel;
@property (weak, nonatomic) IBOutlet UILabel *iconlabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

- (void)refreshWith:(LDChargeModel *)model;
@end

NS_ASSUME_NONNULL_END
