//
//  LDShoppingDetailNameViewCell.m
//  LeDaoCollege
//
//  Created by Make on 2019/9/20.
//  Copyright © 2019 Make. All rights reserved.
//

#import "LDShoppingDetailNameViewCell.h"

@implementation LDShoppingDetailNameViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.nameLabel.frame = CGRectMake(PtWidth(17), PtHeight(19), PtWidth(335), PtHeight(39));
    [self.salePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(PtWidth(17));
        make.bottom.mas_equalTo(self.contentView).mas_offset(PtHeight(-18));
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.salePriceLabel.mas_right).mas_offset(PtWidth(15));
        make.centerY.mas_equalTo(self.salePriceLabel);
    }];
    [self setNormalPrice:@"¥299"];
}

- (void)setNormalPrice:(NSString *)textStr {
    
      NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
      NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
      
      self.priceLabel.attributedText = attribtStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
