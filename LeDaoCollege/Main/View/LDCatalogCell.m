//
//  LDCatalogCell.m
//  LeDaoCollege
//
//  Created by Make on 2019/12/14.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDCatalogCell.h"

@implementation LDCatalogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.darkView setCornerRadius:10];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
