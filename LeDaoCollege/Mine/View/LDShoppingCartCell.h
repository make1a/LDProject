//
//  LDShoppingCartCell.h
//  LeDaoCollege
//
//  Created by Make on 2019/9/16.
//  Copyright © 2019 Make. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDShoppingCartModel.h"
extern NSString *const kLDShoppingCartCellIdentifier;
@interface LDShoppingCartCell : QMUITableViewCell

@property (nonatomic,strong)UIButton * selectButton;
@property (nonatomic,strong)UIImageView * bigImageView;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)QMUILabel * tagLabel;
@property (nonatomic,strong)QMUILabel * cheapPriceLabel;
@property (nonatomic,strong)QMUILabel * priceLabel;

+ (instancetype)dequeueReusableWithTableView:(UITableView *)tableView;

- (void)cellRefreshWithModel:(LDShoppingCartModel *)model;
@end
