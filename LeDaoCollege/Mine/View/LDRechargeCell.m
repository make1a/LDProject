//
//  LDRechargeCell.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/26.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDRechargeCell.h"

@implementation LDRechargeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)refreshWith:(LDChargeModel *)model{
    self.rmbLabel.text = [NSString stringWithFormat:@"%@元",model.itemCode];
    self.iconlabel.text = model.itemDesc;
}

@end
